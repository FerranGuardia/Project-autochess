# 🚀 Guía Simple de Gitflow y Pull Requests

**Fecha:** Hoy  
**Objetivo:** Aprender gitflow de manera práctica con el proyecto autochess

---

## 📚 ¿Qué es Gitflow?

**Gitflow** es una forma de organizar tu trabajo en Git usando diferentes "ramas" (branches). Piensa en las ramas como líneas de tiempo paralelas donde puedes trabajar en diferentes cosas sin afectar el código principal.

### Conceptos Básicos

#### 🌳 **Branches (Ramas)**
- **`master`**: Tu código principal, estable y funcional. Es como el "producto final".
- **`feature/`**: Ramas para trabajar en nuevas funcionalidades. Ejemplo: `feature/arena-visual`

#### 🔄 **Flujo de Trabajo Simple**

```
master (código estable)
  │
  ├── feature/arena-visual (tu trabajo nuevo)
  │     └── Aquí trabajas en los tiles visuales
  │
  └── feature/otra-cosa (otro trabajo)
```

---

## 🎯 Flujo de Trabajo Paso a Paso

### 1️⃣ **Crear un Branch para tu Trabajo**

Cuando quieres trabajar en algo nuevo (como los tiles visuales):

```bash
# Asegúrate de estar en master y tener todo actualizado
git checkout master
git pull origin master

# Crea un nuevo branch para tu trabajo
git checkout -b feature/arena-visual
```

**¿Por qué?** Así trabajas en un espacio separado sin afectar el código principal.

### 2️⃣ **Trabajar en tu Branch**

Ahora puedes:
- Modificar archivos
- Crear nuevos archivos
- Probar tu código
- Hacer commits

```bash
# Ver qué has cambiado
git status

# Agregar archivos al "staging area"
git add archivo1.gd archivo2.gd

# O agregar todos los cambios
git add .

# Hacer un commit (guardar tu progreso)
git commit -m "Agregar tiles visuales para board aliado y enemigo"
```

### 3️⃣ **Subir tu Branch al Repositorio Remoto**

```bash
# Subir tu branch por primera vez
git push -u origin feature/arena-visual

# En commits siguientes, solo necesitas:
git push
```

### 4️⃣ **Crear un Pull Request (PR)**

Un **Pull Request** es como decir: *"Oye, he terminado este trabajo, ¿puedes revisarlo y fusionarlo con master?"*

**En GitHub/GitLab:**
1. Ve a tu repositorio en el navegador
2. Verás un botón "Compare & pull request" o "Create merge request"
3. Escribe una descripción de lo que hiciste
4. Crea el PR

**¿Qué incluir en la descripción?**
- Qué hiciste (ej: "Agregué tiles visuales para los tableros")
- Qué archivos modificaste
- Si hay algo que no funciona todavía
- Capturas de pantalla si es visual

### 5️⃣ **Revisar y Fusionar**

- Revisa tus cambios
- Si todo está bien, fusiona el PR
- El código se integrará en `master`

---

## 📝 Convenciones de Nombres de Branches

Usa nombres descriptivos:

- ✅ `feature/arena-visual` - Para nuevas funcionalidades
- ✅ `fix/bug-tablero` - Para arreglar bugs
- ✅ `refactor/combat-system` - Para mejorar código existente
- ❌ `mi-trabajo` - Muy genérico
- ❌ `cambios` - No descriptivo

---

## 🎓 Ejemplo Práctico: Arena Visual

### Situación Actual
- Has creado `generate_arena.gd` para generar tiles
- Has modificado `GridAlly.gd` y `GridEnemy.gd` para usar sprites
- Hay archivos nuevos sin trackear

### Pasos que Vamos a Seguir

1. **Crear branch:** `feature/arena-visual`
2. **Mover cambios:** Todos los cambios van a ese branch
3. **Commit inicial:** Guardar el trabajo actual
4. **Trabajar:** Continuar mejorando en el branch
5. **PR:** Cuando esté listo, crear Pull Request

---

## ⚠️ Consejos Importantes

### ✅ **Haz Commits Pequeños y Frecuentes**
- No esperes días para hacer un commit
- Commits pequeños = más fácil de entender y revertir

### ✅ **Mensajes de Commit Descriptivos**
```bash
# ❌ Mal
git commit -m "cambios"

# ✅ Bien
git commit -m "Agregar script para generar tiles de arena desde Tiny Dungeons"
```

### ✅ **Mantén tu Branch Actualizado**
```bash
# Si master cambió mientras trabajabas
git checkout master
git pull origin master
git checkout feature/arena-visual
git merge master  # O git rebase master
```

### ✅ **No Trabajes Directamente en Master**
- Master debe ser estable
- Siempre crea un branch para trabajo nuevo

---

## 🔧 Comandos Útiles

```bash
# Ver en qué branch estás
git branch

# Cambiar de branch
git checkout nombre-del-branch

# Ver cambios sin commitear
git status

# Ver diferencias
git diff

# Ver historial de commits
git log --oneline

# Deshacer cambios no commiteados (¡cuidado!)
git restore archivo.gd
```

---

## 📖 Recursos Adicionales

- [Git Basics](https://git-scm.com/book/en/v2/Getting-Started-Git-Basics)
- [Git Branching](https://git-scm.com/book/en/v2/Git-Branching-Branches-in-a-Nutshell)

---

**¡Ahora vamos a ponerlo en práctica con tu trabajo de arena visual! 🎮**

