# 🚀 Guía Rápida - Crear Issues en GitHub

Esta guía te ayudará a crear los Issues de animación de movimiento para todas las unidades.

---

## 📋 Opción 1: Crear Issues Manualmente (Recomendado para empezar)

### Paso 1: Configurar Milestones y Labels

1. Ve a tu repositorio en GitHub: `https://github.com/FerranGuardia/Project-autochess`
2. Ve a **Issues** → **Milestones** → **New Milestone**
3. Crea el milestone: **🎨 Arte y Visuales**
4. Ve a **Issues** → **Labels** → **New label**
5. Crea todas las labels según `docs/GITHUB_ISSUES_SETUP.md` (Paso 2)

### Paso 2: Crear Issues

1. Ve a **Issues** → **New Issue**
2. Abre `docs/GITHUB_ISSUES_SETUP.md`
3. Para cada Issue (Mago, Orco, Elfo, Enano, Beastkin, Demonio):
   - Copia el **Título**
   - Copia la **Descripción** completa
   - Selecciona el **Milestone**: 🎨 Arte y Visuales
   - Selecciona todas las **Labels** listadas
   - Haz clic en "Submit new issue"

---

## 🤖 Opción 2: Crear Issues Automáticamente (Script)

### Requisitos

1. **GitHub Personal Access Token:**
   - Ve a GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
   - Genera un nuevo token con permisos: `repo` (acceso completo a repositorios)
   - Copia el token (solo se muestra una vez)

### Ejecutar el Script

```powershell
# Desde la raíz del proyecto
.\scripts\create_github_issues.ps1 -GitHubToken "tu_token_aqui"
```

El script:
- ✅ Verifica tu conexión
- ✅ Obtiene el Milestone ID automáticamente
- ✅ Crea los 6 Issues (uno por unidad)
- ✅ Asigna labels y milestone automáticamente

**Nota:** Asegúrate de haber creado primero el Milestone y las Labels manualmente, o el script fallará.

---

## ✅ Verificación

Después de crear los Issues, deberías ver:

- 6 Issues abiertos en la pestaña **Issues**
- Todos con el Milestone **🎨 Arte y Visuales**
- Todos con las labels correctas
- Filtrables por unidad usando las labels jerárquicas

---

## 🔄 Próximos Pasos

Una vez creados los Issues:

1. **Cuando quieras trabajar en uno:**
   - Cambia la label `pendiente` → `en-progreso`
   - Asigna el Issue a ti mismo
   - Crea un branch: `git checkout -b feature/animacion-movimiento-mago`
   - Menciona el Issue en tus commits: `Refs #1`

2. **Al terminar:**
   - Crea un Pull Request
   - En la descripción del PR: `Closes #1`
   - Cuando se haga merge, el Issue se cerrará automáticamente

---

## 📚 Documentación Completa

Para más detalles, consulta: `docs/GITHUB_ISSUES_SETUP.md`

---

## 🆘 Troubleshooting

**Error: "Label no existe"**
- Asegúrate de crear todas las labels primero (ver Paso 2 de la guía completa)

**Error: "Milestone no encontrado"**
- Crea el Milestone "🎨 Arte y Visuales" primero

**Error de autenticación en el script**
- Verifica que el token tenga permisos `repo`
- Asegúrate de copiar el token completo sin espacios




