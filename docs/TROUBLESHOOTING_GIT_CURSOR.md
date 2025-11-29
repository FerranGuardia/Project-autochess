# Guía de Troubleshooting: Git en Cursor

## Diagnóstico Inicial

### ✅ Verificaciones Básicas (Ya Completadas)

1. **Git está instalado**: ✅ Versión 2.51.2.windows.1
2. **Git está en el PATH**: ✅ `C:\Program Files\Git\cmd`
3. **Repositorio inicializado**: ✅ `.git` existe
4. **Comandos funcionan en terminal**: ✅ `git status` funciona

## Problemas Comunes y Soluciones

### 1. Comandos Git no funcionan desde la Terminal Integrada de Cursor

**Síntomas:**
- Los comandos git no se ejecutan en la terminal integrada de Cursor
- Aparecen errores como "git no se reconoce como comando"

**Soluciones:**

#### A. Verificar PATH en Cursor
```powershell
# En la terminal de Cursor, ejecuta:
$env:PATH
```

Si no aparece `C:\Program Files\Git\cmd`, necesitas agregarlo:

1. Abre **Configuración de Cursor** (Ctrl + ,)
2. Busca `terminal.integrated.env.windows`
3. Agrega:
```json
{
  "PATH": "${env:PATH};C:\\Program Files\\Git\\cmd"
}
```

#### B. Reiniciar Cursor
Después de cambiar la configuración, reinicia Cursor completamente.

#### C. Verificar Shell por Defecto
1. Abre Configuración (Ctrl + ,)
2. Busca `terminal.integrated.defaultProfile.windows`
3. Asegúrate de que esté configurado como `PowerShell` o `Git Bash`

### 2. Panel de Source Control no funciona

**Síntomas:**
- El panel de Source Control (Ctrl + Shift + G) no muestra cambios
- Los botones de commit/push no funcionan

**Soluciones:**

#### A. Verificar que el workspace esté abierto correctamente
- Asegúrate de abrir la carpeta del proyecto (no un archivo individual)
- El archivo `.git` debe estar en la raíz del workspace

#### B. Recargar la ventana
- Presiona `Ctrl + Shift + P`
- Ejecuta: `Developer: Reload Window`

#### C. Verificar configuración de Git en Cursor
1. Abre Configuración (Ctrl + ,)
2. Busca `git.enabled`
3. Asegúrate de que esté en `true`

#### D. Verificar ruta de Git
1. Abre Configuración (Ctrl + ,)
2. Busca `git.path`
3. Debería estar vacío (auto-detecta) o apuntar a: `C:\\Program Files\\Git\\cmd\\git.exe`

### 3. Comandos específicos fallan

**Síntomas:**
- Algunos comandos git funcionan, otros no
- Errores de permisos o autenticación

**Soluciones:**

#### A. Verificar permisos
```powershell
# Verificar permisos de escritura en el repositorio
Test-Path .git
Get-Acl .git | Format-List
```

#### B. Verificar autenticación
```powershell
# Verificar configuración de usuario
git config user.name
git config user.email

# Si no están configurados:
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"
```

#### C. Verificar credenciales de GitHub/GitLab
```powershell
# Verificar si hay credenciales guardadas
git config --global credential.helper

# Si necesitas reconfigurar:
git config --global credential.helper manager-core
```

### 4. Problemas con Git LFS (Large File Storage)

**Síntomas:**
- Errores relacionados con archivos grandes
- Mensajes sobre `git-lfs`

**Soluciones:**

#### A. Verificar si Git LFS está instalado
```powershell
git lfs version
```

#### B. Si no está instalado:
1. Descarga Git LFS desde: https://git-lfs.github.com/
2. Instálalo
3. Reinicia Cursor

### 5. Problemas con la integración de Git en la UI

**Síntomas:**
- Los indicadores de cambios (+, M, D) no aparecen junto a los archivos
- El panel de Source Control está vacío

**Soluciones:**

#### A. Verificar configuración de archivos
1. Abre Configuración (Ctrl + ,)
2. Busca `files.exclude`
3. Asegúrate de que `.git` no esté excluido

#### B. Verificar configuración de Git
1. Abre Configuración (Ctrl + ,)
2. Busca `git.ignoreLimitWarning`
3. Si tienes muchos archivos ignorados, aumenta el límite

#### C. Limpiar caché de Git
```powershell
# Limpiar caché de Git
git gc --prune=now
```

## Comandos de Diagnóstico

Ejecuta estos comandos en la terminal de Cursor para diagnosticar:

```powershell
# 1. Verificar instalación de Git
git --version

# 2. Verificar ubicación de Git
where.exe git

# 3. Verificar PATH
$env:PATH -split ';' | Select-String -Pattern 'git'

# 4. Verificar repositorio
git status
git remote -v

# 5. Verificar configuración
git config --list --show-origin

# 6. Verificar permisos
Test-Path .git
Get-ChildItem .git -ErrorAction SilentlyContinue

# 7. Verificar integración de Cursor
# Abre la paleta de comandos (Ctrl + Shift + P) y busca:
# - "Git: Show Git Output"
# - "Git: Show Git Log"
```

## Soluciones Avanzadas

### Reinstalar Git

Si nada funciona, puedes reinstalar Git:

1. Descarga Git desde: https://git-scm.com/download/win
2. Durante la instalación, asegúrate de:
   - ✅ "Git from the command line and also from 3rd-party software"
   - ✅ "Use bundled OpenSSH"
   - ✅ "Use the native Windows Secure Channel library"
3. Reinicia Cursor después de la instalación

### Resetear configuración de Git en Cursor

1. Cierra Cursor
2. Elimina la carpeta de configuración (si es necesario):
   - `%APPDATA%\Cursor\User\settings.json` (backup primero)
3. Abre Cursor nuevamente

### Usar Git Bash en lugar de PowerShell

1. Abre Configuración (Ctrl + ,)
2. Busca `terminal.integrated.defaultProfile.windows`
3. Cámbialo a: `Git Bash`

## Obtener Ayuda Adicional

Si el problema persiste:

1. **Revisa los logs de Cursor:**
   - `Ctrl + Shift + P` → "Developer: Toggle Developer Tools"
   - Ve a la pestaña "Console" para ver errores

2. **Revisa los logs de Git:**
   - `Ctrl + Shift + P` → "Git: Show Git Output"

3. **Verifica la versión de Cursor:**
   - `Help` → `About` para ver la versión

4. **Reporta el problema:**
   - Incluye los resultados de los comandos de diagnóstico
   - Incluye mensajes de error específicos
   - Incluye la versión de Cursor y Git

## Checklist de Verificación Rápida

- [ ] Git está instalado (`git --version`)
- [ ] Git está en el PATH
- [ ] Repositorio está inicializado (`.git` existe)
- [ ] `git status` funciona en la terminal
- [ ] Configuración de usuario está establecida
- [ ] Cursor tiene permisos para acceder al directorio
- [ ] Panel de Source Control está habilitado
- [ ] No hay errores en la consola de desarrollador



