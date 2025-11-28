# 🔀 Guía de Pull Requests (PR)

**Fecha:** Hoy  
**Objetivo:** Aprender a crear y manejar Pull Requests en tu proyecto

---

## 📖 ¿Qué es un Pull Request?

Un **Pull Request** (PR) es una forma de proponer cambios a tu código. Es como decir:

> *"He terminado este trabajo en mi branch. ¿Puedes revisarlo y fusionarlo con master?"*

### ¿Por qué usar Pull Requests?

1. **Revisión de código**: Otros (o tú mismo) pueden revisar los cambios antes de fusionarlos
2. **Historial claro**: Cada PR documenta qué se hizo y por qué
3. **Discusión**: Puedes comentar y discutir cambios antes de fusionar
4. **Pruebas**: Puedes verificar que todo funciona antes de fusionar

---

## 🚀 Proceso Completo de Pull Request

### Paso 1: Trabajar en tu Branch ✅ (Ya lo hicimos)

```bash
# Ya creamos el branch
git checkout -b feature/arena-visual

# Ya hicimos commits
git commit -m "feat: agregar sistema de tiles visuales..."
```

### Paso 2: Subir tu Branch al Repositorio Remoto

```bash
# Subir el branch por primera vez
git push -u origin feature/arena-visual

# En commits siguientes, solo necesitas:
git push
```

**¿Qué hace esto?**
- Sube tu branch al repositorio remoto (GitHub/GitLab)
- El `-u` establece el "upstream" para futuros `git push`

### Paso 3: Crear el Pull Request

#### En GitHub:

1. **Ve a tu repositorio en el navegador**
   - Ejemplo: `https://github.com/tu-usuario/autochess`

2. **Verás un banner amarillo** que dice:
   ```
   feature/arena-visual had recent pushes
   [Compare & pull request]
   ```
   - Haz clic en "Compare & pull request"

3. **O manualmente:**
   - Haz clic en "Pull requests" (pestaña superior)
   - Haz clic en "New pull request"
   - Selecciona:
     - **Base:** `master` (hacia dónde quieres fusionar)
     - **Compare:** `feature/arena-visual` (tu branch)

#### En GitLab:

1. Ve a tu repositorio
2. Haz clic en "Merge requests" → "New merge request"
3. Selecciona los branches (source: `feature/arena-visual`, target: `master`)

### Paso 4: Escribir una Buena Descripción del PR

**Template de descripción:**

```markdown
## 🎯 Objetivo
Agregar sistema de tiles visuales para los tableros aliado y enemigo usando tiles de Tiny Dungeons.

## 📝 Cambios Realizados
- [x] Script `generate_arena.gd` para generar arenas desde tiles
- [x] Modificación de `GridAlly.gd` para usar sprite de arena
- [x] Modificación de `GridEnemy.gd` para usar sprite de arena
- [x] Assets de arena generados (arena_ally.png, arena_enemy.png)
- [x] Documentación técnica agregada

## 🧪 Cómo Probar
1. Ejecutar `generate_arena.gd` desde Godot para generar las arenas
2. Verificar que los tableros muestran los tiles correctamente
3. Probar colocación de unidades sobre los tiles

## ⚠️ Estado Actual
- ✅ Generación de arenas funciona
- ⚠️ La visualización necesita ajustes (tiles no se ven bien)
- ❌ Falta mejorar el posicionamiento de los sprites

## 📸 Capturas (si aplica)
[Agregar capturas de pantalla si es visual]

## 🔗 Issues Relacionados
[Si hay issues de GitHub/GitLab, mencionarlos aquí]
```

### Paso 5: Revisar el PR

**Antes de crear el PR, revisa:**

- ✅ ¿El código compila/ejecuta sin errores?
- ✅ ¿Los commits tienen mensajes descriptivos?
- ✅ ¿La descripción del PR es clara?
- ✅ ¿Hay archivos que no deberían estar? (archivos temporales, etc.)

### Paso 6: Fusionar el PR

**Cuando estés listo para fusionar:**

1. **Revisa los cambios** en la pestaña "Files changed"
2. **Si todo está bien**, haz clic en "Merge pull request"
3. **Opciones de merge:**
   - **Merge commit**: Crea un commit de merge (recomendado para proyectos pequeños)
   - **Squash and merge**: Combina todos los commits en uno solo
   - **Rebase and merge**: Aplica los commits directamente sin merge commit

4. **Confirma el merge**
5. **Opcional:** Elimina el branch después de fusionar (botón que aparece)

---

## 📋 Checklist Antes de Crear un PR

### ✅ Código
- [ ] El código funciona correctamente
- [ ] No hay errores de compilación
- [ ] Los tests pasan (si los hay)
- [ ] El código sigue las convenciones del proyecto

### ✅ Commits
- [ ] Mensajes de commit descriptivos
- [ ] Commits lógicos (no demasiado grandes ni pequeños)
- [ ] No hay commits de "WIP" (Work In Progress) a menos que sea necesario

### ✅ Documentación
- [ ] Se actualizó la documentación si es necesario
- [ ] Los comentarios en el código son claros

### ✅ PR Description
- [ ] Descripción clara del objetivo
- [ ] Lista de cambios realizada
- [ ] Instrucciones de cómo probar
- [ ] Estado actual del trabajo

---

## 🔄 Trabajar en un PR Existente

Si necesitas hacer más cambios después de crear el PR:

```bash
# Asegúrate de estar en tu branch
git checkout feature/arena-visual

# Haz tus cambios
# ... editar archivos ...

# Agrega y commitea
git add archivo.gd
git commit -m "fix: corregir posicionamiento de tiles"

# Sube los cambios
git push
```

**¡El PR se actualiza automáticamente!** No necesitas crear un nuevo PR.

---

## 💬 Comentarios y Revisión

### Hacer Comentarios en un PR

- Puedes comentar en líneas específicas de código
- Puedes hacer comentarios generales
- Puedes solicitar cambios o aprobar

### Responder a Comentarios

- Responde a los comentarios
- Haz los cambios solicitados
- Haz commit y push de los cambios

---

## 🎓 Buenas Prácticas

### ✅ **PRs Pequeños y Enfocados**
- Un PR por funcionalidad
- Más fácil de revisar
- Más fácil de entender

### ✅ **Títulos Descriptivos**
```markdown
# ❌ Mal
"Cambios"

# ✅ Bien
"feat: agregar sistema de tiles visuales para tableros"
```

### ✅ **Descripciones Claras**
- Explica el "qué" y el "por qué"
- Incluye cómo probar
- Menciona problemas conocidos

### ✅ **Commits Lógicos**
- Un commit por cambio lógico
- Mensajes descriptivos
- No mezcles cambios no relacionados

---

## 🛠️ Comandos Útiles para PRs

```bash
# Ver diferencias entre tu branch y master
git diff master..feature/arena-visual

# Ver commits que no están en master
git log master..feature/arena-visual

# Actualizar tu branch con cambios de master
git checkout feature/arena-visual
git merge master
# O con rebase (más limpio):
git rebase master

# Ver el estado de tu PR localmente
git log --oneline --graph --all
```

---

## 📚 Ejemplo Práctico: Tu PR de Arena Visual

### Situación Actual
- ✅ Branch creado: `feature/arena-visual`
- ✅ Commits hechos
- ⏳ Falta: Subir al remoto y crear PR

### Próximos Pasos

1. **Subir el branch:**
   ```bash
   git push -u origin feature/arena-visual
   ```

2. **Ir a GitHub/GitLab y crear el PR**

3. **Escribir descripción usando el template**

4. **Revisar y fusionar cuando esté listo**

---

## 🎯 Resumen

1. **Trabaja en un branch** ✅
2. **Haz commits** ✅
3. **Sube el branch** (`git push -u origin feature/arena-visual`)
4. **Crea el PR** (en GitHub/GitLab)
5. **Escribe buena descripción**
6. **Revisa y fusiona**

---

**¡Ahora estás listo para crear tu primer Pull Request! 🚀**

