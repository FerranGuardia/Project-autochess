# Script interactivo para crear Issues en GitHub
# Pide el token de forma segura
# Uso: .\scripts\create_issues_interactivo.ps1

param(
    [Parameter(Mandatory=$false)]
    [string]$Owner = "FerranGuardia",
    
    [Parameter(Mandatory=$false)]
    [string]$Repo = "Project-autochess"
)

Write-Host "`n🎯 Creador de Issues para AutoChess" -ForegroundColor Cyan
Write-Host "====================================`n" -ForegroundColor Cyan

# Pedir token de forma segura
Write-Host "📝 Necesito tu GitHub Personal Access Token" -ForegroundColor Yellow
Write-Host "   Si no lo tienes, sigue estas instrucciones:" -ForegroundColor Gray
Write-Host "   1. Ve a: https://github.com/settings/tokens" -ForegroundColor Gray
Write-Host "   2. Generate new token (classic)" -ForegroundColor Gray
Write-Host "   3. Marca solo 'repo' en los permisos" -ForegroundColor Gray
Write-Host "   4. Copia el token (empieza con ghp_...)" -ForegroundColor Gray
Write-Host "`n   O consulta: docs/OBTENER_TOKEN_GITHUB.md`n" -ForegroundColor Gray

$secureToken = Read-Host "🔑 Ingresa tu GitHub Token" -AsSecureString
$GitHubToken = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureToken)
)

if ([string]::IsNullOrWhiteSpace($GitHubToken)) {
    Write-Host "❌ Token no puede estar vacío" -ForegroundColor Red
    exit 1
}

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
        [int]$Milestone = $null
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
        if ($_.Exception.Response) {
            $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
            $responseBody = $reader.ReadToEnd()
            Write-Host "   Detalles: $responseBody" -ForegroundColor Red
        }
        return $null
    }
}

# Función para obtener Milestone ID por nombre
function Get-MilestoneId {
    param([string]$MilestoneName)
    
    try {
        $milestones = Invoke-RestMethod -Uri "$baseUrl/milestones?state=open" -Method Get -Headers $headers
        $milestone = $milestones | Where-Object { $_.title -eq $MilestoneName }
        if ($milestone) {
            return $milestone.number
        }
        Write-Host "⚠️  Milestone '$MilestoneName' no encontrado" -ForegroundColor Yellow
        Write-Host "   Asegúrate de crear el Milestone '🎨 Arte y Visuales' primero" -ForegroundColor Yellow
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
    Write-Host "   Asegúrate de que el token tenga permisos 'repo'" -ForegroundColor Yellow
    exit 1
}

# Obtener Milestone ID
Write-Host "`n🔍 Buscando Milestone '🎨 Arte y Visuales'..." -ForegroundColor Cyan
$milestoneId = Get-MilestoneId -MilestoneName "🎨 Arte y Visuales"
if (-not $milestoneId) {
    $continue = Read-Host "¿Continuar sin milestone? (s/n)"
    if ($continue -ne "s" -and $continue -ne "S") {
        Write-Host "❌ Operación cancelada. Crea el Milestone primero." -ForegroundColor Yellow
        exit 1
    }
    Write-Host "⚠️  Continuando sin milestone..." -ForegroundColor Yellow
}

# Verificar que las labels existen
Write-Host "`n🔍 Verificando labels..." -ForegroundColor Cyan
$requiredLabels = @("arte", "arte/unidades", "arte/unidades/mago", "arte/unidades/orco", "arte/unidades/elfo", "arte/unidades/enano", "arte/unidades/beastkin", "arte/unidades/demonio", "animacion/movimiento", "prioridad-media", "pendiente")

try {
    $existingLabels = Invoke-RestMethod -Uri "$baseUrl/labels" -Method Get -Headers $headers
    $existingLabelNames = $existingLabels | ForEach-Object { $_.name }
    $missingLabels = $requiredLabels | Where-Object { $_ -notin $existingLabelNames }
    
    if ($missingLabels.Count -gt 0) {
        Write-Host "⚠️  Faltan las siguientes labels:" -ForegroundColor Yellow
        $missingLabels | ForEach-Object { Write-Host "   - $_" -ForegroundColor Yellow }
        $continue = Read-Host "¿Continuar de todas formas? (s/n)"
        if ($continue -ne "s" -and $continue -ne "S") {
            Write-Host "❌ Operación cancelada. Crea las labels primero." -ForegroundColor Yellow
            Write-Host "   Consulta: docs/GITHUB_ISSUES_SETUP.md" -ForegroundColor Gray
            exit 1
        }
    } else {
        Write-Host "✅ Todas las labels existen" -ForegroundColor Green
    }
}
catch {
    Write-Host "⚠️  No se pudieron verificar las labels, continuando..." -ForegroundColor Yellow
}

# Issues a crear
$issues = @(
    @{
        Title = "Animar sprite de Mago para que camine por el tablero"
        Body = "## 🎯 Objetivo`nCrear animación de caminata para el sprite del Mago que se reproduzca cuando la unidad se mueve por el tablero durante el combate.`n`n## 📋 Checklist`n- [ ] Verificar/crear sprites de animación de caminata para Mago`n- [ ] Implementar sistema de animación en `Unit.gd` o crear `AnimationSystem.gd``n- [ ] Conectar animación con sistema de movimiento existente`n- [ ] Verificar que la animación se reproduce correctamente durante combate`n- [ ] Asegurar transición fluida entre idle y movimiento`n- [ ] Probar que no afecta el sistema de combate (targeting, ataque, etc.)`n- [ ] Verificar que el sprite se mueve adecuadamente durante la animación`n`n## 🔗 Archivos a Modificar`n- `scripts/Unit.gd` - Sistema de animaciones`n- Posiblemente crear `scripts/AnimationSystem.gd` si no existe`n`n## 📝 Notas`n- Solo animación de movimiento/caminata`n- El sprite debe moverse de forma fluida`n- No debe afectar el sistema de combate existente`n- Verificar que funciona tanto en grid aliado como enemigo`n`n## 🎨 Assets Necesarios`n- Sprites de animación de caminata para Mago (verificar si existen en `assets/sprites/units/`)`n- Si no existen, crear o buscar assets apropiados"
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

# Confirmar antes de crear
Write-Host "`n📝 Se crearán $($issues.Count) Issues:" -ForegroundColor Cyan
$issues | ForEach-Object { Write-Host "   - $($_.Title)" -ForegroundColor Gray }
Write-Host ""

$confirm = Read-Host "¿Continuar? (s/n)"
if ($confirm -ne "s" -and $confirm -ne "S") {
    Write-Host "❌ Operación cancelada" -ForegroundColor Yellow
    exit 0
}

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
    Start-Sleep -Seconds 1  # Rate limiting de GitHub
}

Write-Host "`n✅ Resumen:" -ForegroundColor Cyan
Write-Host "   Creados: $created" -ForegroundColor Green
Write-Host "   Fallidos: $failed" -ForegroundColor $(if ($failed -gt 0) { "Red" } else { "Green" })
Write-Host "`n🌐 Ve a https://github.com/$Owner/$Repo/issues para ver los Issues creados" -ForegroundColor Cyan
