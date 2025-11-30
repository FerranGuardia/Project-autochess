# 🔑 Cómo Obtener un GitHub Personal Access Token

## Pasos Rápidos

1. **Ve a GitHub:**
   - https://github.com/settings/tokens
   - O: GitHub → Tu perfil (arriba derecha) → Settings → Developer settings → Personal access tokens → Tokens (classic)

2. **Genera nuevo token:**
   - Click en "Generate new token" → "Generate new token (classic)"
   - **Note:** Ponle un nombre como "AutoChess Issues Creator"
   - **Expiration:** Elige una duración (30 días, 90 días, o sin expiración)
   - **Scopes:** Marca solo `repo` (acceso completo a repositorios)
   - Click en "Generate token"

3. **Copia el token:**
   - ⚠️ **IMPORTANTE:** Solo se muestra una vez
   - Copia el token completo (empieza con `ghp_...`)

4. **Úsalo con el script:**
   ```powershell
   .\scripts\create_github_issues.ps1 -GitHubToken "ghp_tu_token_aqui"
   ```

---

## ⚠️ Seguridad

- **NUNCA** subas el token a Git
- **NUNCA** lo compartas públicamente
- Si se compromete, revócalo inmediatamente en GitHub Settings

---

## 🚀 Alternativa: Usar GitHub CLI (gh)

Si tienes GitHub CLI instalado, puedes autenticarte una vez:

```powershell
gh auth login
```

Y luego usar el script modificado para usar `gh` en lugar de tokens.





