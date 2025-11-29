# 🔧 Troubleshooting Gitflow: Branch feature/arena-visual

## 🎯 Problema Identificado

**Error común:** No puedes cambiar de branch porque tienes cambios sin commitear.

```
error: Your local changes to the following files would be overwritten by checkout:
        scripts/BoardTileHelper.gd
Please commit your changes or stash them before you switch branches.
```

---

## ✅ Soluciones Rápidas

### Opción 1: Commitear los Cambios (Recomendado)

Si los cambios en `scripts/BoardTileHelper.gd` son parte de tu trabajo en `feature/arena-visual`:

```powershell
# 1. Ver qué cambios tienes
git status

# 2. Agregar los cambios
git add scripts/BoardTileHelper.gd

# 3. Hacer commit
git commit -m "refactor: actualizar BoardTileHelper con cambios de tiles"

# 4. Ahora puedes cambiar de branch
git checkout master
```

### Opción 2: Guardar Cambios Temporalmente (Stash)

Si los cambios NO son parte de `feature/arena-visual` o quieres guardarlos para después:

```powershell
# 1. Guardar cambios temporalmente
git stash push -m "Cambios temporales en BoardTileHelper"

# 2. Ahora puedes cambiar de branch
git checkout master

# 3. Cuando vuelvas, recuperar los cambios
git checkout feature/arena-visual
git stash pop
```

### Opción 3: Descartar Cambios (¡Cuidado!)

Si los cambios NO son importantes y quieres descartarlos:

```powershell
# ⚠️ ADVERTENCIA: Esto elimina los cambios permanentemente
git restore scripts/BoardTileHelper.gd

# O para todos los archivos modificados
git restore .
```

---

## 🔍 Diagnóstico del Problema Actual

### Estado Actual del Repositorio

**Branch actual:** `feature/arena-visual`  
**Cambios sin commitear:**
- `scripts/BoardTileHelper.gd` (modificado)
- Muchos archivos eliminados (tiles del 1-108)

### Verificar Estado

```powershell
# Ver todos los cambios
git status

# Ver diferencias en archivos modificados
git diff scripts/BoardTileHelper.gd

# Ver archivos eliminados
git status | Select-String "deleted"
```

---

## 🚀 Operaciones Comunes de Gitflow y Cómo Resolverlas

### 1. Cambiar de Branch

**Problema:** No puedes cambiar porque hay cambios sin commitear.

**Solución:**
```powershell
# Opción A: Commitear primero
git add .
git commit -m "feat: mensaje descriptivo"
git checkout master

# Opción B: Guardar temporalmente
git stash
git checkout master
```

### 2. Actualizar Branch desde Master

**Problema:** Master cambió y quieres traer esos cambios a tu branch.

**Solución:**
```powershell
# 1. Asegúrate de tener todo commiteado o en stash
git stash  # Si hay cambios sin commitear

# 2. Cambiar a master y actualizar
git checkout master
git pull origin master

# 3. Volver a tu branch y mergear
git checkout feature/arena-visual
git merge master

# 4. Si hubo conflictos, resolverlos y commitear
git add .
git commit -m "merge: integrar cambios de master"

# 5. Recuperar cambios guardados (si usaste stash)
git stash pop
```

### 3. Crear Pull Request

**Problema:** Quieres crear un PR pero hay cambios sin commitear.

**Solución:**
```powershell
# 1. Commitear todos los cambios importantes
git add .
git commit -m "feat: descripción de cambios"

# 2. Subir el branch
git push origin feature/arena-visual

# 3. Ir a GitHub/GitLab y crear el PR
```

### 4. Fusionar Master en tu Branch

**Problema:** Quieres traer cambios de master sin cambiar de branch.

**Solución:**
```powershell
# 1. Asegúrate de estar en tu branch
git checkout feature/arena-visual

# 2. Actualizar master localmente
git fetch origin master

# 3. Mergear master en tu branch
git merge origin/master

# Si hay conflictos:
# - Resolver conflictos manualmente
# - git add .
# - git commit -m "merge: resolver conflictos con master"
```

---

## 📋 Checklist Antes de Operaciones Gitflow

Antes de hacer cualquier operación de gitflow, verifica:

- [ ] **¿Tienes cambios sin commitear?**
  ```powershell
  git status
  ```
  - Si hay cambios, decide: commitear, stash, o descartar

- [ ] **¿Estás en el branch correcto?**
  ```powershell
  git branch
  ```
  - Asegúrate de estar en `feature/arena-visual` antes de trabajar

- [ ] **¿Tu branch está actualizado?**
  ```powershell
  git fetch origin
  git status
  ```
  - Si dice "Your branch is behind", actualiza con `git pull`

- [ ] **¿Hay conflictos potenciales?**
  ```powershell
  git log master..feature/arena-visual --oneline
  ```
  - Revisa qué commits tienes que no están en master

---

## 🛠️ Comandos Útiles para Troubleshooting

### Ver Estado Completo
```powershell
# Estado del repositorio
git status

# Ver en qué branch estás
git branch -a

# Ver commits recientes
git log --oneline --graph --all -10

# Ver diferencias con master
git diff master..feature/arena-visual --stat
```

### Gestionar Cambios
```powershell
# Ver qué archivos cambiaron
git status

# Ver diferencias específicas
git diff scripts/BoardTileHelper.gd

# Agregar archivos específicos
git add scripts/BoardTileHelper.gd

# Agregar todos los cambios
git add .

# Ver qué está en staging
git status
```

### Gestionar Branches
```powershell
# Listar todos los branches
git branch -a

# Cambiar de branch (después de commitear o stash)
git checkout nombre-branch

# Crear nuevo branch
git checkout -b feature/nuevo-branch

# Ver diferencias entre branches
git diff master..feature/arena-visual
```

### Stash (Guardar Temporalmente)
```powershell
# Guardar cambios
git stash push -m "Descripción de cambios guardados"

# Ver stashes guardados
git stash list

# Recuperar último stash
git stash pop

# Recuperar stash específico
git stash apply stash@{0}

# Eliminar stash
git stash drop stash@{0}
```

---

## ⚠️ Problemas Comunes y Soluciones

### Problema 1: "Your local changes would be overwritten"

**Causa:** Tienes cambios sin commitear que entrarían en conflicto.

**Solución:**
```powershell
# Opción 1: Commitear
git add .
git commit -m "feat: cambios pendientes"

# Opción 2: Stash
git stash
# Hacer la operación que necesitas
git stash pop  # Recuperar después
```

### Problema 2: "Branch is behind origin"

**Causa:** El branch remoto tiene commits que no tienes localmente.

**Solución:**
```powershell
git pull origin feature/arena-visual
```

### Problema 3: "Merge conflicts"

**Causa:** Hay cambios conflictivos entre branches.

**Solución:**
```powershell
# 1. Ver archivos con conflictos
git status

# 2. Abrir archivos y resolver conflictos manualmente
# (busca marcadores <<<<<<< ======= >>>>>>>)

# 3. Después de resolver
git add .
git commit -m "merge: resolver conflictos"
```

### Problema 4: "Cannot switch branch, uncommitted changes"

**Causa:** Cambios sin commitear bloquean el cambio.

**Solución:**
```powershell
# Forzar cambio descartando cambios (¡cuidado!)
git checkout -f master

# O mejor: guardar cambios primero
git stash
git checkout master
```

---

## 🎯 Flujo de Trabajo Recomendado

### Trabajo Diario en feature/arena-visual

```powershell
# 1. Al empezar el día
git checkout feature/arena-visual
git pull origin feature/arena-visual

# 2. Trabajar en cambios
# ... hacer modificaciones ...

# 3. Antes de cambiar de branch o hacer merge
git status  # Verificar qué cambió
git add .   # Agregar cambios
git commit -m "feat: descripción clara"

# 4. Subir cambios
git push origin feature/arena-visual
```

### Actualizar desde Master

```powershell
# 1. Guardar trabajo actual
git stash

# 2. Actualizar master
git checkout master
git pull origin master

# 3. Volver a tu branch
git checkout feature/arena-visual

# 4. Mergear master
git merge master

# 5. Resolver conflictos si hay
# ... resolver conflictos ...
git add .
git commit -m "merge: integrar cambios de master"

# 6. Recuperar trabajo guardado
git stash pop
```

---

## 📚 Recursos Adicionales

- **Guía Gitflow Simple:** `docs/guides/GUIA_GITFLOW_SIMPLE.md`
- **Guía Pull Requests:** `docs/guides/GUIA_PULL_REQUEST.md`
- **Pasos Integrar Main:** `docs/guides/PASOS_INTEGRAR_MAIN.md`

---

## 🆘 Si Nada Funciona

1. **Verifica que Git esté funcionando:**
   ```powershell
   git --version
   git status
   ```

2. **Revisa los logs de Git:**
   ```powershell
   git log --oneline -10
   ```

3. **Verifica la configuración:**
   ```powershell
   git config --list
   ```

4. **Consulta la guía general de troubleshooting:**
   - `docs/TROUBLESHOOTING_GIT_CURSOR.md`

---

**Última actualización:** Basado en el estado actual del branch `feature/arena-visual`



