# 🎯 Configuración de GitHub Issues - AutoChess

Este documento contiene la estructura completa de Labels, Milestones e Issues para organizar el proyecto.

---

## 📋 Paso 1: Crear Milestones

Ve a tu repositorio en GitHub → **Milestones** → **New Milestone**

Crea estos milestones:

1. **🎨 Arte y Visuales**
   - Descripción: "Issues relacionados con arte, sprites, animaciones y elementos visuales"

2. **💻 Programación y Sistemas**
   - Descripción: "Issues relacionados con programación, sistemas de juego y mecánicas"

3. **🎮 UI/UX**
   - Descripción: "Issues relacionados con interfaz de usuario y experiencia de usuario"

4. **🐛 Bugs y Fixes**
   - Descripción: "Issues relacionados con corrección de errores y bugs"

5. **📋 Mejoras Generales**
   - Descripción: "Issues de mejoras generales y optimizaciones"

---

## 🏷️ Paso 2: Crear Labels

Ve a tu repositorio en GitHub → **Issues** → **Labels** → **New label**

### Categorías Principales

| Label | Color | Descripción |
|-------|-------|-------------|
| `arte` | `#FF6B9D` | Issues relacionados con arte |
| `programacion` | `#0052CC` | Issues relacionados con programación |
| `ui` | `#7CD197` | Issues relacionados con UI |
| `bug` | `#D73A4A` | Bugs y errores |

### Subcategorías de Arte

| Label | Color | Descripción |
|-------|-------|-------------|
| `arte/unidades` | `#FFB3D1` | Arte relacionado con unidades |
| `arte/enemigos` | `#FFB3D1` | Arte relacionado con enemigos |
| `arte/efectos` | `#FFB3D1` | Efectos visuales |
| `arte/animaciones` | `#FFB3D1` | Animaciones en general |

### Unidades Específicas

| Label | Color | Descripción |
|-------|-------|-------------|
| `arte/unidades/mago` | `#FFE5F0` | Issues del Mago |
| `arte/unidades/orco` | `#FFE5F0` | Issues del Orco |
| `arte/unidades/elfo` | `#FFE5F0` | Issues del Elfo |
| `arte/unidades/enano` | `#FFE5F0` | Issues del Enano |
| `arte/unidades/beastkin` | `#FFE5F0` | Issues del Beastkin |
| `arte/unidades/demonio` | `#FFE5F0` | Issues del Demonio |

### Tipos de Animación

| Label | Color | Descripción |
|-------|-------|-------------|
| `animacion/movimiento` | `#79B8FF` | Animaciones de movimiento/caminata |
| `animacion/ataque` | `#79B8FF` | Animaciones de ataque |
| `animacion/habilidad` | `#79B8FF` | Animaciones de habilidades |
| `animacion/idle` | `#79B8FF` | Animaciones idle |

### Prioridad

| Label | Color | Descripción |
|-------|-------|-------------|
| `prioridad-alta` | `#B60205` | Prioridad alta |
| `prioridad-media` | `#D93F0B` | Prioridad media |
| `prioridad-baja` | `#FBBA00` | Prioridad baja |

### Estado

| Label | Color | Descripción |
|-------|-------|-------------|
| `pendiente` | `#E4E669` | Pendiente de empezar |
| `en-progreso` | `#0E8A16` | En progreso |
| `bloqueado` | `#D73A4A` | Bloqueado |

---

## 📝 Paso 3: Crear Issues

A continuación están todos los Issues listos para copiar y pegar. Ve a **Issues** → **New Issue** y copia el contenido.

---

## 🎨 Issues de Animación de Movimiento

### Issue 1: Mago - Animación de Movimiento

**Título:**
```
Animar sprite de Mago para que camine por el tablero
```

**Descripción:**
```markdown
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
```

**Milestone:** 🎨 Arte y Visuales  
**Labels:** `arte`, `arte/unidades`, `arte/unidades/mago`, `animacion/movimiento`, `prioridad-media`, `pendiente`

---

### Issue 2: Orco - Animación de Movimiento

**Título:**
```
Animar sprite de Orco para que camine por el tablero
```

**Descripción:**
```markdown
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
```

**Milestone:** 🎨 Arte y Visuales  
**Labels:** `arte`, `arte/unidades`, `arte/unidades/orco`, `animacion/movimiento`, `prioridad-media`, `pendiente`

---

### Issue 3: Elfo - Animación de Movimiento

**Título:**
```
Animar sprite de Elfo para que camine por el tablero
```

**Descripción:**
```markdown
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
```

**Milestone:** 🎨 Arte y Visuales  
**Labels:** `arte`, `arte/unidades`, `arte/unidades/elfo`, `animacion/movimiento`, `prioridad-media`, `pendiente`

---

### Issue 4: Enano - Animación de Movimiento

**Título:**
```
Animar sprite de Enano para que camine por el tablero
```

**Descripción:**
```markdown
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
```

**Milestone:** 🎨 Arte y Visuales  
**Labels:** `arte`, `arte/unidades`, `arte/unidades/enano`, `animacion/movimiento`, `prioridad-media`, `pendiente`

---

### Issue 5: Beastkin - Animación de Movimiento

**Título:**
```
Animar sprite de Beastkin para que camine por el tablero
```

**Descripción:**
```markdown
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
```

**Milestone:** 🎨 Arte y Visuales  
**Labels:** `arte`, `arte/unidades`, `arte/unidades/beastkin`, `animacion/movimiento`, `prioridad-media`, `pendiente`

---

### Issue 6: Demonio - Animación de Movimiento

**Título:**
```
Animar sprite de Demonio para que camine por el tablero
```

**Descripción:**
```markdown
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
```

**Milestone:** 🎨 Arte y Visuales  
**Labels:** `arte`, `arte/unidades`, `arte/unidades/demonio`, `animacion/movimiento`, `prioridad-media`, `pendiente`

---

## 📌 Cómo Usar Este Documento

1. **Primero:** Crea los Milestones y Labels en GitHub siguiendo los pasos 1 y 2
2. **Luego:** Para cada Issue:
   - Ve a GitHub → Issues → New Issue
   - Copia el **Título** completo
   - Copia la **Descripción** completa
   - Selecciona el **Milestone** correspondiente
   - Selecciona todas las **Labels** listadas
   - Haz clic en "Submit new issue"

---

## 🔄 Flujo de Trabajo con Issues

Cuando estés listo para trabajar en un Issue:

1. **Actualizar estado del Issue:**
   - Cambiar label `pendiente` → `en-progreso`
   - Asignar el Issue a ti mismo

2. **Crear branch:**
   ```bash
   git checkout master
   git pull origin master
   git checkout -b feature/animacion-movimiento-mago
   ```

3. **Trabajar y hacer commits:**
   ```bash
   git commit -m "feat: Animación movimiento Mago

   - Implementa animación de caminata
   - Conecta con sistema de movimiento
   
   Refs #1"  # Reemplaza #1 con el número real del issue
   ```

4. **Crear Pull Request:**
   - Título: "Animación de movimiento - Mago"
   - Descripción: "Implementa animación de caminata para Mago. Closes #1"
   - El Issue se cerrará automáticamente cuando se haga merge

---

## 📝 Notas Adicionales

- Cada Issue es **pequeño y unitario** - fácil de completar
- Puedes trabajar en varios Issues en paralelo si son de diferentes unidades
- Los Issues están organizados jerárquicamente con labels para fácil filtrado
- Usa el Milestone para ver el progreso general de "Arte y Visuales"

