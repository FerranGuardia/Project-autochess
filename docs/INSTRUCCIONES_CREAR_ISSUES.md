# 🚀 Instrucciones para Crear Issues en GitHub

Tienes dos opciones para crear los Issues:

---

## ✅ Opción 1: Crear Manualmente (Más Simple)

1. **Primero, crea Milestones y Labels:**
   - Ve a: https://github.com/FerranGuardia/Project-autochess/issues
   - Sigue las instrucciones en `docs/GITHUB_ISSUES_SETUP.md` (Pasos 1 y 2)

2. **Luego, crea los Issues:**
   - Ve a: https://github.com/FerranGuardia/Project-autochess/issues/new
   - Abre `docs/GITHUB_ISSUES_SETUP.md`
   - Copia y pega cada Issue (hay 6 en total)

---

## 🤖 Opción 2: Usar el Script (Requiere Token)

### Paso 1: Obtener Token de GitHub

1. Ve a: https://github.com/settings/tokens
2. Click en "Generate new token" → "Generate new token (classic)"
3. **Note:** "AutoChess Issues"
4. **Expiration:** Elige duración (30 días recomendado)
5. **Scopes:** Marca solo `repo`
6. Click "Generate token"
7. **Copia el token** (empieza con `ghp_...`)

### Paso 2: Ejecutar el Script

Abre PowerShell en la carpeta del proyecto y ejecuta:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\create_issues_interactivo.ps1
```

El script te pedirá:
- Tu token de GitHub (lo escribes de forma segura)
- Confirmación antes de crear los Issues

---

## ⚠️ Nota Importante

**Antes de ejecutar el script, asegúrate de:**
1. ✅ Haber creado el Milestone "🎨 Arte y Visuales"
2. ✅ Haber creado todas las Labels necesarias
3. ✅ Tener tu token de GitHub listo

Si no has creado Milestones y Labels, el script te avisará y te dará opción de continuar o cancelar.

---

## 🆘 Si el Script Falla

Si tienes problemas con el script, usa la **Opción 1 (Manual)** que es más confiable y te toma solo unos minutos.

---

## 📚 Documentación Completa

- `docs/GITHUB_ISSUES_SETUP.md` - Estructura completa de Labels, Milestones e Issues
- `docs/GUIA_RAPIDA_ISSUES.md` - Guía rápida de uso
- `docs/OBTENER_TOKEN_GITHUB.md` - Cómo obtener token de GitHub





