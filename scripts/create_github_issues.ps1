# Script para crear Issues en GitHub usando la API
# Requiere: GitHub Personal Access Token con permisos de repo
# Uso: .\scripts\create_github_issues.ps1

param(
    [Parameter(Mandatory=$true)]
    [string]$GitHubToken,
    
    [Parameter(Mandatory=$false)]
    [string]$Owner = "FerranGuardia",
    
    [Parameter(Mandatory=$false)]
    [string]$Repo = "Project-autochess"
)

# Configuración
$baseUrl = "https://api.github.com/repos/$Owner/$Repo"
$headers = @{
    "Authorization" = "token $GitHubToken"
    "Accept" = "application/vnd.github.v3+json"
}

# Función para crear un Issue
function Create-Issue {
    param(
        [string]$Title,
        [string]$Body,
        [string[]]$Labels,
        [string]$Milestone = $null
    )
    
    $issueData = @{
        title = $Title
        body = $Body
        labels = $Labels
    }
    
    if ($Milestone) {
        $issueData.milestone = $Milestone
    }
    
    $json = $issueData | ConvertTo-Json -Depth 10
    
    try {
        $response = Invoke-RestMethod -Uri "$baseUrl/issues" -Method Post -Headers $headers -Body $json -ContentType "application/json"
        Write-Host "✅ Issue creado: $($response.html_url)" -ForegroundColor Green
        return $response
    }
    catch {
        Write-Host "❌ Error al crear issue: $_" -ForegroundColor Red
        Write-Host "Respuesta: $($_.Exception.Response)" -ForegroundColor Red
        return $null
    }
}

# Función para obtener Milestone ID por nombre
function Get-MilestoneId {
    param([string]$MilestoneName)
    
    try {
        $milestones = Invoke-RestMethod -Uri "$baseUrl/milestones" -Method Get -Headers $headers
        $milestone = $milestones | Where-Object { $_.title -eq $MilestoneName }
        if ($milestone) {
            return $milestone.number
        }
        Write-Host "⚠️  Milestone '$MilestoneName' no encontrado" -ForegroundColor Yellow
        return $null
    }
    catch {
        Write-Host "❌ Error al obtener milestones: $_" -ForegroundColor Red
        return $null
    }
}

# Verificar que el token funciona
Write-Host "`n🔍 Verificando conexión con GitHub..." -ForegroundColor Cyan
try {
    $user = Invoke-RestMethod -Uri "https://api.github.com/user" -Method Get -Headers $headers
    Write-Host "✅ Conectado como: $($user.login)" -ForegroundColor Green
}
catch {
    Write-Host "❌ Error de autenticación. Verifica tu token." -ForegroundColor Red
    exit 1
}

# Obtener Milestone ID
$milestoneId = Get-MilestoneId -MilestoneName "🎨 Arte y Visuales"
if (-not $milestoneId) {
    Write-Host "⚠️  Continuando sin milestone..." -ForegroundColor Yellow
}

# Issues a crear
$issues = @(
    @{
        Title = "Animar sprite de Mago para que camine por el tablero"
        Body = @"
## 🎯 Objetivo
Crear animación de caminata para el sprite del Mago que se reproduzca cuando la unidad se mueve por el tablero durante el combate.

## 📋 Checklist
- [ ] Verificar/crear sprites de animación de caminata para Mago
- [ ] Implementar sistema de animación en `Unit.gd` o crear `AnimationSystem.gd`
- [ ] Conectar animación con sistema de movimiento existente
- [ ] Verificar que la animación se reproduce correctamente durante combate
- [ ] Asegurar transición fluida entre idle y movimiento
- [ ] Probar que no afecta el sistema de combate (targeting, ataque, etc.)
- [ ] Verificar que el sprite se mueve adecuadamente durante la animación

## 🔗 Archivos a Modificar
- `scripts/Unit.gd` - Sistema de animaciones
- Posiblemente crear `scripts/AnimationSystem.gd` si no existe

## 📝 Notas
- Solo animación de movimiento/caminata
- El sprite debe moverse de forma fluida
- No debe afectar el sistema de combate existente
- Verificar que funciona tanto en grid aliado como enemigo

## 🎨 Assets Necesarios
- Sprites de animación de caminata para Mago (verificar si existen en `assets/sprites/units/`)
- Si no existen, crear o buscar assets apropiados
"@
        Labels = @("arte", "arte/unidades", "arte/unidades/mago", "animacion/movimiento", "prioridad-media", "pendiente")
        Milestone = $milestoneId
    },
    @{
        Title = "Animar sprite de Orco para que camine por el tablero"
        Body = @"
## 🎯 Objetivo
Crear animación de caminata para el sprite del Orco que se reproduzca cuando la unidad se mueve por el tablero durante el combate.

## 📋 Checklist
- [ ] Verificar/crear sprites de animación de caminata para Orco
- [ ] Implementar animación en sistema de movimiento
- [ ] Verificar que la animación se reproduce correctamente durante combate
- [ ] Asegurar transición fluida entre idle y movimiento
- [ ] Probar que no afecta el sistema de combate
- [ ] Verificar que el sprite se mueve adecuadamente durante la animación

## 🔗 Archivos a Modificar
- `scripts/Unit.gd` - Sistema de animaciones
- Posiblemente `scripts/AnimationSystem.gd` si existe

## 📝 Notas
- Solo animación de movimiento/caminata
- El sprite debe moverse de forma fluida
- No debe afectar el sistema de combate existente

## 🎨 Assets Necesarios
- Sprites de animación de caminata para Orco (verificar si existen en `assets/sprites/units/`)
"@
        Labels = @("arte", "arte/unidades", "arte/unidades/orco", "animacion/movimiento", "prioridad-media", "pendiente")
        Milestone = $milestoneId
    },
    @{
        Title = "Animar sprite de Elfo para que camine por el tablero"
        Body = @"
## 🎯 Objetivo
Crear animación de caminata para el sprite del Elfo que se reproduzca cuando la unidad se mueve por el tablero durante el combate.

## 📋 Checklist
- [ ] Verificar/crear sprites de animación de caminata para Elfo
- [ ] Implementar animación en sistema de movimiento
- [ ] Verificar que la animación se reproduce correctamente durante combate
- [ ] Asegurar transición fluida entre idle y movimiento
- [ ] Probar que no afecta el sistema de combate
- [ ] Verificar que el sprite se mueve adecuadamente durante la animación

## 🔗 Archivos a Modificar
- `scripts/Unit.gd` - Sistema de animaciones
- Posiblemente `scripts/AnimationSystem.gd` si existe

## 📝 Notas
- Solo animación de movimiento/caminata
- El sprite debe moverse de forma fluida
- No debe afectar el sistema de combate existente

## 🎨 Assets Necesarios
- Sprites de animación de caminata para Elfo (verificar si existen en `assets/sprites/units/`)
"@
        Labels = @("arte", "arte/unidades", "arte/unidades/elfo", "animacion/movimiento", "prioridad-media", "pendiente")
        Milestone = $milestoneId
    },
    @{
        Title = "Animar sprite de Enano para que camine por el tablero"
        Body = @"
## 🎯 Objetivo
Crear animación de caminata para el sprite del Enano que se reproduzca cuando la unidad se mueve por el tablero durante el combate.

## 📋 Checklist
- [ ] Verificar/crear sprites de animación de caminata para Enano
- [ ] Implementar animación en sistema de movimiento
- [ ] Verificar que la animación se reproduce correctamente durante combate
- [ ] Asegurar transición fluida entre idle y movimiento
- [ ] Probar que no afecta el sistema de combate
- [ ] Verificar que el sprite se mueve adecuadamente durante la animación

## 🔗 Archivos a Modificar
- `scripts/Unit.gd` - Sistema de animaciones
- Posiblemente `scripts/AnimationSystem.gd` si existe

## 📝 Notas
- Solo animación de movimiento/caminata
- El sprite debe moverse de forma fluida
- No debe afectar el sistema de combate existente

## 🎨 Assets Necesarios
- Sprites de animación de caminata para Enano (verificar si existen en `assets/sprites/units/`)
"@
        Labels = @("arte", "arte/unidades", "arte/unidades/enano", "animacion/movimiento", "prioridad-media", "pendiente")
        Milestone = $milestoneId
    },
    @{
        Title = "Animar sprite de Beastkin para que camine por el tablero"
        Body = @"
## 🎯 Objetivo
Crear animación de caminata para el sprite del Beastkin que se reproduzca cuando la unidad se mueve por el tablero durante el combate.

## 📋 Checklist
- [ ] Verificar/crear sprites de animación de caminata para Beastkin
- [ ] Implementar animación en sistema de movimiento
- [ ] Verificar que la animación se reproduce correctamente durante combate
- [ ] Asegurar transición fluida entre idle y movimiento
- [ ] Probar que no afecta el sistema de combate
- [ ] Verificar que el sprite se mueve adecuadamente durante la animación

## 🔗 Archivos a Modificar
- `scripts/Unit.gd` - Sistema de animaciones
- Posiblemente `scripts/AnimationSystem.gd` si existe

## 📝 Notas
- Solo animación de movimiento/caminata
- El sprite debe moverse de forma fluida
- No debe afectar el sistema de combate existente

## 🎨 Assets Necesarios
- Sprites de animación de caminata para Beastkin (verificar si existen en `assets/sprites/units/`)
"@
        Labels = @("arte", "arte/unidades", "arte/unidades/beastkin", "animacion/movimiento", "prioridad-media", "pendiente")
        Milestone = $milestoneId
    },
    @{
        Title = "Animar sprite de Demonio para que camine por el tablero"
        Body = @"
## 🎯 Objetivo
Crear animación de caminata para el sprite del Demonio que se reproduzca cuando la unidad se mueve por el tablero durante el combate.

## 📋 Checklist
- [ ] Verificar/crear sprites de animación de caminata para Demonio
- [ ] Implementar animación en sistema de movimiento
- [ ] Verificar que la animación se reproduce correctamente durante combate
- [ ] Asegurar transición fluida entre idle y movimiento
- [ ] Probar que no afecta el sistema de combate
- [ ] Verificar que el sprite se mueve adecuadamente durante la animación

## 🔗 Archivos a Modificar
- `scripts/Unit.gd` - Sistema de animaciones
- Posiblemente `scripts/AnimationSystem.gd` si existe

## 📝 Notas
- Solo animación de movimiento/caminata
- El sprite debe moverse de forma fluida
- No debe afectar el sistema de combate existente

## 🎨 Assets Necesarios
- Sprites de animación de caminata para Demonio (verificar si existen en `assets/sprites/units/`)
"@
        Labels = @("arte", "arte/unidades", "arte/unidades/demonio", "animacion/movimiento", "prioridad-media", "pendiente")
        Milestone = $milestoneId
    }
)

# Crear Issues
Write-Host "`n📝 Creando Issues..." -ForegroundColor Cyan
$created = 0
$failed = 0

foreach ($issue in $issues) {
    Write-Host "`nCreando: $($issue.Title)" -ForegroundColor Yellow
    $result = Create-Issue -Title $issue.Title -Body $issue.Body -Labels $issue.Labels -Milestone $issue.Milestone
    if ($result) {
        $created++
    } else {
        $failed++
    }
    Start-Sleep -Seconds 1  # Rate limiting
}

Write-Host "`n✅ Resumen:" -ForegroundColor Cyan
Write-Host "   Creados: $created" -ForegroundColor Green
Write-Host "   Fallidos: $failed" -ForegroundColor $(if ($failed -gt 0) { "Red" } else { "Green" })
Write-Host "`n🌐 Ve a https://github.com/$Owner/$Repo/issues para ver los Issues creados" -ForegroundColor Cyan




