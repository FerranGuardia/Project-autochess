# 🔧 Troubleshooting: "Not a git repository" en PowerShell

## 🎯 Problema

Cuando ejecutas comandos git en PowerShell (fuera de Cursor), recibes el error:
```
fatal: not a git repository (or any of the parent directories): .git
```

---

## ✅ Solución Rápida

### Paso 1: Verificar que estás en el directorio correcto

```powershell
# Ver dónde estás
Get-Location
# O simplemente:
pwd

# Debe mostrar:
# C:\Users\Nitropc\Desktop\autochess
```

**Si NO estás en ese directorio:**
```powershell
# Cambiar al directorio del proyecto
cd C:\Users\Nitropc\Desktop\autochess
```

### Paso 2: Verificar que .git existe

```powershell
# Verificar que la carpeta .git existe
Test-Path .git

# Debe devolver: True

# Si devuelve False, verificar que estás en el directorio correcto
Get-ChildItem -Force | Select-Object Name
# Debes ver la carpeta .git en la lista
```

### Paso 3: Verificar que Git funciona

```powershell
# Verificar que git está instalado
git --version

# Debe mostrar algo como: git version 2.51.2.windows.1
```

---

## 🔍 Diagnóstico Completo

### Verificar Directorio Actual

```powershell
# Ver ruta completa
Get-Location

# Ver contenido del directorio
Get-ChildItem -Force

# Buscar carpeta .git
Get-ChildItem -Force -Directory | Where-Object { $_.Name -eq ".git" }
```

### Verificar que .git es válido

```powershell
# Verificar que .git existe y es una carpeta
Test-Path .git
Test-Path .git\config

# Ver contenido de .git
Get-ChildItem .git -Force | Select-Object -First 10
```

### Verificar Configuración de Git

```powershell
# Ver configuración del repositorio
git config --local --list

# Verificar remote
git remote -v
```

---

## 🚨 Problemas Comunes y Soluciones

### Problema 1: Estás en un subdirectorio

**Síntoma:** Ejecutas `git status` desde `C:\Users\Nitropc\Desktop\autochess\scripts\`

**Solución:**
```powershell
# Volver al directorio raíz del proyecto
cd C:\Users\Nitropc\Desktop\autochess

# Verificar
git status
```

### Problema 2: La carpeta .git está corrupta o eliminada

**Síntoma:** `Test-Path .git` devuelve `False`

**Solución:**
```powershell
# Verificar si existe
Test-Path .git

# Si no existe, verificar si el proyecto es realmente un repositorio git
# Si accidentalmente eliminaste .git, necesitarás:
# 1. Clonar el repositorio de nuevo, O
# 2. Inicializar un nuevo repositorio (perderás historial)
```

### Problema 3: PowerShell no encuentra git

**Síntoma:** `git --version` da error "git no se reconoce como comando"

**Solución:**
```powershell
# Verificar PATH
$env:PATH -split ';' | Select-String -Pattern 'git'

# Si no aparece, agregar Git al PATH:
# 1. Abrir "Variables de entorno" en Windows
# 2. Agregar: C:\Program Files\Git\cmd
# 3. Reiniciar PowerShell

# O usar la ruta completa:
& "C:\Program Files\Git\cmd\git.exe" --version
```

### Problema 4: Permisos insuficientes

**Síntoma:** No puedes leer la carpeta .git

**Solución:**
```powershell
# Verificar permisos
Get-Acl .git | Format-List

# Si hay problemas de permisos, ejecutar PowerShell como Administrador
```

---

## 🛠️ Comandos de Verificación Paso a Paso

Ejecuta estos comandos en orden para diagnosticar:

```powershell
# 1. Verificar ubicación actual
Write-Host "=== Ubicación Actual ===" -ForegroundColor Cyan
Get-Location

# 2. Verificar que .git existe
Write-Host "`n=== Verificando .git ===" -ForegroundColor Cyan
if (Test-Path .git) {
    Write-Host "✓ .git existe" -ForegroundColor Green
} else {
    Write-Host "✗ .git NO existe" -ForegroundColor Red
    Write-Host "Asegúrate de estar en: C:\Users\Nitropc\Desktop\autochess" -ForegroundColor Yellow
}

# 3. Verificar Git instalado
Write-Host "`n=== Verificando Git ===" -ForegroundColor Cyan
try {
    $version = git --version
    Write-Host "✓ Git instalado: $version" -ForegroundColor Green
} catch {
    Write-Host "✗ Git NO está instalado o no está en PATH" -ForegroundColor Red
}

# 4. Verificar repositorio
Write-Host "`n=== Verificando Repositorio ===" -ForegroundColor Cyan
try {
    $topLevel = git rev-parse --show-toplevel
    Write-Host "✓ Repositorio válido en: $topLevel" -ForegroundColor Green
} catch {
    Write-Host "✗ No es un repositorio git válido" -ForegroundColor Red
}

# 5. Verificar estado
Write-Host "`n=== Estado del Repositorio ===" -ForegroundColor Cyan
try {
    git status
} catch {
    Write-Host "✗ Error al obtener estado" -ForegroundColor Red
}
```

---

## 📋 Checklist de Diagnóstico

Ejecuta estos comandos y verifica cada punto:

- [ ] **¿Estás en el directorio correcto?**
  ```powershell
  Get-Location
  # Debe ser: C:\Users\Nitropc\Desktop\autochess
  ```

- [ ] **¿Existe la carpeta .git?**
  ```powershell
  Test-Path .git
  # Debe devolver: True
  ```

- [ ] **¿Git está instalado?**
  ```powershell
  git --version
  # Debe mostrar una versión
  ```

- [ ] **¿Git está en el PATH?**
  ```powershell
  $env:PATH -split ';' | Select-String -Pattern 'git'
  # Debe mostrar rutas con "git"
  ```

- [ ] **¿El repositorio es válido?**
  ```powershell
  git rev-parse --show-toplevel
  # Debe mostrar la ruta del proyecto
  ```

---

## 🎯 Solución Paso a Paso

### Si NADA funciona, sigue estos pasos:

1. **Abrir PowerShell como Administrador**
   - Click derecho en PowerShell → "Ejecutar como administrador"

2. **Navegar al directorio del proyecto**
   ```powershell
   cd C:\Users\Nitropc\Desktop\autochess
   ```

3. **Verificar que estás en el lugar correcto**
   ```powershell
   Get-Location
   Get-ChildItem -Force | Select-Object Name
   ```

4. **Verificar Git**
   ```powershell
   git --version
   where.exe git
   ```

5. **Intentar comando git simple**
   ```powershell
   git status
   ```

6. **Si sigue fallando, verificar .git manualmente**
   ```powershell
   Test-Path .git
   Get-ChildItem .git -Force | Select-Object -First 5
   ```

---

## 🔄 Comparar con Terminal de Cursor

Si funciona en Cursor pero no en PowerShell:

1. **Verificar PATH en Cursor:**
   - En Cursor, abre la terminal integrada
   - Ejecuta: `$env:PATH`
   - Compara con PowerShell externo

2. **Verificar directorio de trabajo:**
   - En Cursor: `Get-Location`
   - En PowerShell: `Get-Location`
   - Deben ser iguales

3. **Verificar versión de Git:**
   - En Cursor: `git --version`
   - En PowerShell: `git --version`
   - Deben ser iguales

---

## 💡 Tips

1. **Usa siempre la ruta completa:**
   ```powershell
   cd "C:\Users\Nitropc\Desktop\autochess"
   ```

2. **Verifica antes de ejecutar:**
   ```powershell
   Get-Location
   git status
   ```

3. **Si trabajas desde subdirectorios, usa:**
   ```powershell
   # Desde cualquier subdirectorio
   git -C "C:\Users\Nitropc\Desktop\autochess" status
   ```

4. **Crea un alias útil:**
   ```powershell
   # Agregar a tu perfil de PowerShell
   function goto-autochess {
       cd "C:\Users\Nitropc\Desktop\autochess"
   }
   
   # Luego solo ejecuta:
   goto-autochess
   ```

---

## 🆘 Si Nada Funciona

1. **Verificar que el proyecto es realmente un repositorio git:**
   ```powershell
   # Desde el directorio del proyecto
   Test-Path .git
   Get-ChildItem .git -Force
   ```

2. **Reinicializar el repositorio (¡CUIDADO!):**
   ```powershell
   # SOLO si .git no existe y quieres empezar de nuevo
   # Esto eliminará todo el historial local
   git init
   git remote add origin https://github.com/FerranGuardia/Project-autochess.git
   git fetch origin
   ```

3. **Clonar de nuevo (si es necesario):**
   ```powershell
   # Si todo falla, clonar de nuevo
   cd C:\Users\Nitropc\Desktop
   Remove-Item -Recurse -Force autochess  # ¡CUIDADO! Elimina todo
   git clone https://github.com/FerranGuardia/Project-autochess.git autochess
   ```

---

**Última actualización:** Basado en el problema reportado con PowerShell externo



