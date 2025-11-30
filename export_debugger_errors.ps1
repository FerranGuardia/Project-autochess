# Script para exportar errores del debugger de Godot
# Ejecuta este script mientras Godot está abierto

Write-Host "=== EXPORTADOR DE ERRORES DEL DEBUGGER ===" -ForegroundColor Cyan
Write-Host ""

# Instrucciones
Write-Host "INSTRUCCIONES:" -ForegroundColor Yellow
Write-Host "1. Abre Godot y ejecuta el proyecto" -ForegroundColor White
Write-Host "2. Ve a la pestaña 'Output' o 'Debugger' en la parte inferior" -ForegroundColor White
Write-Host "3. Selecciona todo el texto (Ctrl+A)" -ForegroundColor White
Write-Host "4. Copia el texto (Ctrl+C)" -ForegroundColor White
Write-Host "5. Pega el contenido aquí en el chat" -ForegroundColor White
Write-Host ""
Write-Host "ALTERNATIVA: Guardar en archivo" -ForegroundColor Yellow
Write-Host "Si prefieres guardar los errores en un archivo:" -ForegroundColor White
Write-Host "1. En Godot, ve a Output/Debugger" -ForegroundColor White
Write-Host "2. Selecciona todo (Ctrl+A) y copia (Ctrl+C)" -ForegroundColor White
Write-Host "3. Abre un editor de texto (Notepad, VS Code, etc.)" -ForegroundColor White
Write-Host "4. Pega el contenido (Ctrl+V)" -ForegroundColor White
Write-Host "5. Guarda como 'debugger_errors.txt'" -ForegroundColor White
Write-Host "6. Comparte el archivo o su contenido aquí" -ForegroundColor White
Write-Host ""

# Buscar archivos de log de Godot (si existen)
Write-Host "Buscando archivos de log de Godot..." -ForegroundColor Yellow
$godotLogs = @(
    "$env:APPDATA\Godot\app_userdata\AutoChess\logs",
    "$env:LOCALAPPDATA\Godot\app_userdata\AutoChess\logs",
    ".godot\logs"
)

foreach ($logPath in $godotLogs) {
    if (Test-Path $logPath) {
        Write-Host "✓ Encontrado: $logPath" -ForegroundColor Green
        $logFiles = Get-ChildItem -Path $logPath -Filter "*.log" -ErrorAction SilentlyContinue
        if ($logFiles) {
            Write-Host "  Archivos de log encontrados:" -ForegroundColor Cyan
            foreach ($logFile in $logFiles) {
                Write-Host "    - $($logFile.FullName)" -ForegroundColor Gray
            }
        }
    }
}

Write-Host ""
Write-Host "Si no encuentras logs, usa el metodo manual de copiar desde Godot." -ForegroundColor Yellow

