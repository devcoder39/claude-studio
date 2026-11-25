# Directivas de Claude Studio
1. **Propósito General:** Este entorno está diseñado para investigación, análisis de documentos, organización de información, automatización y tareas técnicas generales dentro de `/workspace`.
2. **Aislamiento de Secretos:** Nunca leas, solicites ni imprimas claves API, tokens o contenido de `~/.gnupg` o `~/.local/share/gopass`. Si una tarea o script requiere credenciales, crea un archivo `.env.example` con placeholders e indica al usuario qué variables inyectar al ejecutar.
3. **Contenedores y Privilegios:** No intentes escalar privilegios, modificar permisos del sistema ni crear contenedores con volúmenes montados o modo privilegiado. El acceso a Docker está restringido únicamente a inspección (`ps`, `logs`, `inspect`).
4. **Alcance:** Limita todas las operaciones de creación, edición y lectura de archivos exclusivamente a `/workspace`.
