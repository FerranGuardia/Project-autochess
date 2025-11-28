# 🔀 Pasos para Integrar Branch en Main

**Branch actual:** `feature/arena-visual`  
**Fecha:** 26 de Diciembre 2024

---

## 📋 Checklist Antes de Hacer Push

### ✅ Código
- [x] El código funciona correctamente
- [x] No hay errores de compilación
- [x] Los tests pasan
- [x] Prints de debug limpiados

### ✅ Archivos
- [x] Solo archivos relacionados con la funcionalidad
- [x] No hay archivos temporales o basura
- [x] Assets necesarios incluidos

---

## 🚀 Pasos para Integrar en Main

### Paso 1: Verificar Estado Actual

```bash
# Ver en qué branch estás
git branch

# Ver qué archivos han cambiado
git status

# Ver los commits que has hecho
git log --oneline -10
```

**Debes estar en:** `feature/arena-visual`

### Paso 2: Asegurarse de que Todo Está Commiteado

```bash
# Ver si hay cambios sin commitear
git status

# Si hay cambios, agregarlos y commitearlos
git add .
git commit -m "feat: configurar sistema de tiles del tablero con tile_board_borde y tile_board_combat"
```

### Paso 3: Subir el Branch al Repositorio Remoto

```bash
# Si es la primera vez que subes este branch
git push -u origin feature/arena-visual

# Si ya lo subiste antes, solo necesitas:
git push
```

**¿Qué hace esto?**
- Sube todos tus commits al repositorio remoto (GitHub/GitLab)
- El `-u` establece la conexión para futuros `git push`

### Paso 4: Crear el Pull Request (PR)

#### En GitHub:

1. **Ve a tu repositorio en el navegador**
   - Ejemplo: `https://github.com/tu-usuario/autochess`

2. **Verás un banner amarillo** que dice:
   ```
   feature/arena-visual had recent pushes
   [Compare & pull request]
   ```
   - Haz clic en **"Compare & pull request"**

3. **O manualmente:**
   - Haz clic en la pestaña **"Pull requests"**
   - Haz clic en **"New pull request"**
   - Selecciona:
     - **Base:** `main` (o `master`, según tu repo)
     - **Compare:** `feature/arena-visual`

#### En GitLab:

1. Ve a tu repositorio
2. Haz clic en **"Merge requests"** → **"New merge request"**
3. Selecciona:
   - **Source branch:** `feature/arena-visual`
   - **Target branch:** `main` (o `master`)

### Paso 5: Escribir la Descripción del PR

Usa este template:

```markdown
## 🎯 Objetivo
Implementar sistema de tiles visuales para el tablero completo usando dos sprites base (tile_board_borde y tile_board_combat).

## 📝 Cambios Realizados

### Sistema de Tiles
- [x] Script `setup_board_tiles.ps1` para configurar tiles automáticamente
- [x] Sistema de numeración de 108 tiles (9×12) para tablero completo
- [x] Tiles de borde: 38 tiles usando `tile_board_borde.png`
- [x] Tiles de interior: 70 tiles usando `tile_board_combat.png`

### Código
- [x] `BoardTileHelper.gd` - Helper para calcular índices de tiles
- [x] `Board.gd` - Sistema de carga de tiles del borde decorativo
- [x] `GridAlly.gd` - Carga tiles del interior para grid aliado
- [x] `GridEnemy.gd` - Carga tiles del interior para grid enemigo
- [x] Ajuste de posicionamiento para alinear tiles del grid con tiles del borde

### Tests
- [x] `BoardTilesTests.gd` - Tests unitarios para verificar carga y posicionamiento de tiles

### Documentación
- [x] `CONFIGURACION_TILES_TABLERO.md` - Documentación del sistema de tiles
- [x] `DIMENSIONES_TABLERO.md` - Actualizado con información del tablero simple
- [x] `TABLA_TILES_TABLERO_COMPLETO.md` - Tabla completa de mapeo de tiles

## 🧪 Cómo Probar

1. **Configurar tiles:**
   ```powershell
   powershell -ExecutionPolicy Bypass -File scripts/setup_board_tiles.ps1
   ```

2. **Ejecutar el juego:**
   - Presionar F5 en Godot
   - Verificar que todos los tiles se cargan correctamente
   - Verificar que los bordes están alineados con los grids

3. **Ejecutar tests:**
   - Los tests se ejecutan automáticamente al iniciar el juego
   - Verificar que todos los tests pasan en la consola

## ✅ Estado Actual

- ✅ Sistema de tiles configurado y funcionando
- ✅ 108 tiles numerados correctamente (1-108)
- ✅ Bordes y grids alineados correctamente
- ✅ Tests unitarios pasando
- ✅ Documentación completa

## 📸 Capturas

[Agregar capturas de pantalla del tablero si es necesario]

## 🔗 Issues Relacionados

[Si hay issues de GitHub/GitLab, mencionarlos aquí]
```

### Paso 6: Revisar el PR

**Antes de crear el PR, revisa:**

- ✅ ¿El código compila sin errores?
- ✅ ¿Los tests pasan?
- ✅ ¿La descripción es clara?
- ✅ ¿Hay archivos que no deberían estar?

### Paso 7: Fusionar el PR

**Cuando estés listo para fusionar:**

1. **Revisa los cambios** en la pestaña "Files changed"
2. **Si todo está bien**, haz clic en **"Merge pull request"** (GitHub) o **"Merge"** (GitLab)
3. **Opciones de merge:**
   - **Create a merge commit**: Crea un commit de merge (recomendado)
   - **Squash and merge**: Combina todos los commits en uno solo
   - **Rebase and merge**: Aplica los commits directamente
4. **Confirma el merge**
5. **Opcional:** Elimina el branch después de fusionar (botón que aparece)

### Paso 8: Actualizar Localmente

Después de fusionar en GitHub/GitLab:

```bash
# Cambiar a main
git checkout main

# Actualizar main con los cambios fusionados
git pull origin main

# Opcional: Eliminar el branch local (ya está fusionado)
git branch -d feature/arena-visual
```

---

## 📊 Resumen de Comandos

```bash
# 1. Verificar estado
git status
git branch

# 2. Commitear cambios finales (si hay)
git add .
git commit -m "feat: mensaje descriptivo"

# 3. Subir branch
git push -u origin feature/arena-visual

# 4. Crear PR en GitHub/GitLab (navegador)

# 5. Después de fusionar, actualizar localmente
git checkout main
git pull origin main
```

---

## ⚠️ Si Hay Conflictos

Si `main` cambió mientras trabajabas y hay conflictos:

```bash
# Actualizar tu branch con cambios de main
git checkout feature/arena-visual
git fetch origin
git merge origin/main

# O con rebase (más limpio):
git rebase origin/main

# Resolver conflictos si los hay
# Luego:
git push --force-with-lease  # Solo si usaste rebase
```

---

## ✅ Checklist Final

Antes de crear el PR, asegúrate de:

- [ ] Código funciona correctamente
- [ ] Tests pasan
- [ ] No hay errores de compilación
- [ ] Prints de debug limpiados
- [ ] Documentación actualizada
- [ ] Commits con mensajes descriptivos
- [ ] Branch subido al remoto
- [ ] Descripción del PR lista

---

**¡Listo para integrar en main! 🚀**

