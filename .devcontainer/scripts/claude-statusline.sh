#!/usr/bin/env bash
# Barra de estado personalizada para Claude Code en Claude Studio

INPUT=$(cat)

# Extraer métricas clave del JSON de sesión usando node (ya instalado vía mise)
/home/vscode/.local/share/mise/shims/node -e '
const fs = require("fs");
const data = JSON.parse(process.argv[1]);

const model = data.model?.display_name || "Claude";
const usedPct = Math.round(data.context_window?.used_percentage || 0);
const remPct = Math.max(0, 100 - usedPct);
const totalTokens = ((data.context_window?.total_input_tokens || 0) + (data.context_window?.total_output_tokens || 0));
const tokensK = (totalTokens / 1000).toFixed(1) + "k";
const cost = (data.cost?.total_cost_usd || 0).toFixed(3);
const agent = data.agent?.name ? ` | 🤖 ${data.agent.name}` : "";

// Barra visual de progreso de contexto (10 bloques)
const filled = Math.min(10, Math.round(usedPct / 10));
const bar = "█".repeat(filled) + "░".repeat(10 - filled);

// Color según uso de contexto (verde < 60%, amarillo 60-80%, rojo > 80%)
const color = usedPct > 80 ? "\x1b[31m" : usedPct > 60 ? "\x1b[33m" : "\x1b[32m";
const reset = "\x1b[0m";

// Contar servidores MCP configurados
let mcpCount = 0;
try {
  const cfg = JSON.parse(fs.readFileSync("/etc/claude-code/managed-settings.json", "utf8"));
  mcpCount = Object.keys(cfg.mcpServers || {}).length;
} catch {}

process.stdout.write(
  ` ${model}${agent} │ ${color}[${bar}] ${usedPct}% usado (${remPct}% libre)${reset} │ 🪙 ${tokensK} tok ($${cost}) │ 🔌 MCPs: ${mcpCount}`
);
' "$INPUT"
