# 🌿 Branches del Proyecto - Features de Gameplay

**Última actualización:** Enero 2025  
**Estado:** Todos los branches creados y listos para trabajar

---

## 📋 Branches Creados

### Prioridad 1: Barra de Energía ⚡
- **Branch:** `feature/barra-energia`
- **Estado:** ⏳ Pendiente
- **Descripción:** Sistema de barra de energía que se carga con ataques (base para habilidades)
- **Archivos a modificar:**
  - `scripts/Unit.gd` - Agregar variables y funciones de energía
  - `scripts/CombatSystem.gd` - Cargar energía en ataques
  - Posiblemente crear barra visual similar a health_bar

**Tareas principales:**
- [ ] Agregar `max_energy` y `current_energy` en `Unit.gd`
- [ ] Crear función `gain_energy(amount: int)` en `Unit.gd`
- [ ] Crear barra de energía visual (similar a health_bar)
- [ ] Modificar `attack_target()` en `CombatSystem.gd` para cargar energía
- [ ] Configurar valores de energía por tipo de unidad
- [ ] Emitir señal cuando energía esté llena

---

### Prioridad 2: Sistema de Habilidades 🎯
- **Branch:** `feature/sistema-habilidades`
- **Estado:** ⏳ Pendiente
- **Descripción:** Crear habilidades para las unidades que se activan con energía llena
- **Depende de:** `feature/barra-energia` (debe fusionarse primero)
- **Archivos a modificar:**
  - Crear `scripts/AbilitySystem.gd` o `scripts/Ability.gd`
  - `scripts/Unit.gd` - Integrar sistema de habilidades
  - `scripts/CombatSystem.gd` - Activar habilidades en combate
  - `scripts/UnitData.gd` - Definir habilidades por unidad

**Tareas principales:**
- [ ] Crear clase base `Ability` o `AbilitySystem`
- [ ] Definir tipos de habilidades (daño, curación, buff, debuff)
- [ ] Implementar activación automática cuando energía esté llena
- [ ] Crear habilidades específicas para cada tipo de unidad
- [ ] Agregar efectos visuales básicos para habilidades
- [ ] Integrar con sistema de combate

---

### Prioridad 3: Refinar Movimiento 🚶
- **Branch:** `feature/refinar-movimiento`
- **Estado:** ⏳ Pendiente
- **Descripción:** Mejorar las reglas de movimiento de las unidades (pathfinding, obstáculos, límites)
- **Archivos a modificar:**
  - `scripts/CombatSystem.gd` - Mejorar `move_towards_target()`
  - Posiblemente crear `scripts/Pathfinding.gd`
  - `scripts/GridAlly.gd` y `scripts/GridEnemy.gd` - Validaciones de movimiento

**Tareas principales:**
- [ ] Implementar pathfinding básico (evitar obstáculos)
- [ ] Agregar reglas de movimiento por tipo (melee vs ranged)
- [ ] Implementar límites de movimiento (no salir del grid)
- [ ] Mejorar detección de colisiones entre unidades
- [ ] Optimizar actualización de posiciones en grid
- [ ] Agregar validaciones para evitar que unidades se superpongan

---

### Prioridad 4: Animaciones Básicas 🎬
- **Branch:** `feature/animaciones-basicas`
- **Estado:** ⏳ Pendiente
- **Descripción:** Crear animaciones básicas para cada unidad (idle, ataque, movimiento, habilidad, muerte)
- **Archivos a modificar:**
  - `scripts/Unit.gd` - Agregar `AnimatedSprite2D` o `AnimationPlayer`
  - Crear animaciones en Godot para cada unidad
  - `scripts/CombatSystem.gd` - Triggers de animaciones

**Tareas principales:**
- [ ] Reemplazar `Sprite2D` por `AnimatedSprite2D` en `Unit.gd`
- [ ] Crear animación idle para cada unidad
- [ ] Crear animación de ataque
- [ ] Crear animación de movimiento
- [ ] Crear animación de habilidad (cuando se implemente)
- [ ] Crear animación de muerte
- [ ] Integrar triggers de animaciones en combate

---

### Prioridad 5: Mejorar UI Tienda 🛒
- **Branch:** `feature/mejorar-ui-tienda`
- **Estado:** ⏳ Pendiente
- **Descripción:** Mejorar el diseño visual y UX de la tienda
- **Archivos a modificar:**
  - `scripts/ShopUI.gd` - Mejoras visuales y de UX

**Tareas principales:**
- [ ] Mejorar diseño visual del panel de tienda
- [ ] Agregar iconos de unidades en las ofertas
- [ ] Mejorar feedback visual (hover, click, etc.)
- [ ] Agregar tooltips con información de unidades
- [ ] Mejorar layout y espaciado
- [ ] Agregar animaciones de compra
- [ ] Mejorar contraste y legibilidad

---

### Prioridad 6: Sistema de Estrellas ⭐
- **Branch:** `feature/sistema-estrellas`
- **Estado:** ⏳ Pendiente
- **Descripción:** Sistema de mejora de unidades por estrellas (3 unidades = 1 estrella, mejora stats)
- **Archivos a modificar:**
  - `scripts/Unit.gd` - Agregar variable `star_level` (1, 2, 3 estrellas)
  - `scripts/GridAlly.gd` o `scripts/Bench.gd` - Detectar 3 unidades iguales
  - `scripts/UnitData.gd` - Definir multiplicadores de stats por estrella
  - Crear sistema de combinación automática

**Tareas principales:**
- [ ] Agregar `star_level: int` en `Unit.gd` (1, 2, 3)
- [ ] Implementar detección de 3 unidades del mismo tipo
- [ ] Crear función de combinación automática
- [ ] Aplicar multiplicadores de stats por nivel de estrella
- [ ] Crear visual de estrellas (iconos o indicadores)
- [ ] Actualizar UI para mostrar nivel de estrella
- [ ] Integrar con sistema de bench y grid

---

### Prioridad 7: Expansión Enemigos No Muertos 🧟
- **Branch:** `feature/expansion-enemigos-no-muertos`
- **Estado:** ⏳ Pendiente
- **Descripción:** Agregar nuevas unidades enemigas para rondas 5-10 con temática no muertos, incluyendo un boss final
- **Archivos a modificar:**
  - `scripts/EnemyData.gd` - Agregar nuevos tipos de enemigos
  - `scripts/EnemyAI.gd` - Lógica para rondas 5-10
  - Crear sprites/recursos para nuevos enemigos
  - `scripts/GameManager.gd` - Ajustar sistema de rondas

**Tareas principales:**
- [ ] Diseñar tipos de enemigos no muertos (Zombie, Esqueleto, Lich, etc.)
- [ ] Crear boss final especial para ronda 10
- [ ] Agregar datos de enemigos en `EnemyData.gd`
- [ ] Implementar lógica de spawn por ronda (5-10)
- [ ] Crear/obtener sprites para nuevos enemigos
- [ ] Balancear stats de nuevos enemigos
- [ ] Agregar mecánicas especiales para el boss

---

### Prioridad 8: Timers Rondas e Interfaz ⏱️
- **Branch:** `feature/timers-rondas-interfaz`
- **Estado:** ⏳ Pendiente
- **Descripción:** Crear sistema de timers para las rondas y mostrar en la interfaz
- **Archivos a modificar:**
  - `scripts/GameManager.gd` - Agregar timers
  - `scripts/ShopUI.gd` - Mostrar timers en UI
  - Crear componente de timer visual

**Tareas principales:**
- [ ] Crear timer para fase de preparación
- [ ] Crear timer para fase de combate
- [ ] Agregar visualización de timer en UI
- [ ] Implementar señales cuando timer llegue a 0
- [ ] Agregar feedback visual (cambiar color cuando queda poco tiempo)
- [ ] Integrar con sistema de fases existente

---

### Prioridad 9: Límite Tiempo Rondas ⏰
- **Branch:** `feature/limite-tiempo-rondas`
- **Estado:** ⏳ Pendiente
- **Descripción:** Limitar el tiempo de las rondas a 1:30 minutos (90 segundos)
- **Depende de:** `feature/timers-rondas-interfaz` (necesita sistema de timers)
- **Archivos a modificar:**
  - `scripts/GameManager.gd` - Implementar límite de tiempo
  - `scripts/CombatSystem.gd` - Forzar fin de combate al llegar al límite
  - `scripts/ShopUI.gd` - Mostrar tiempo restante

**Tareas principales:**
- [ ] Configurar límite de 90 segundos por ronda
- [ ] Implementar fin automático de combate al llegar al límite
- [ ] Decidir resultado si llega al límite (victoria/derrota por unidades vivas)
- [ ] Agregar advertencia visual cuando quede poco tiempo
- [ ] Integrar con sistema de timers

---

### Prioridad 10: Sistema de Enrage 🔥
- **Branch:** `feature/sistema-enrage`
- **Estado:** ⏳ Pendiente
- **Descripción:** Sistema de enrage que acelera el combate después de un tiempo estimulado (similar a TFT)
- **Depende de:** `feature/timers-rondas-interfaz` y `feature/limite-tiempo-rondas`
- **Archivos a modificar:**
  - `scripts/CombatSystem.gd` - Implementar sistema de enrage
  - `scripts/Unit.gd` - Aplicar efectos de enrage
  - `scripts/GameManager.gd` - Controlar activación de enrage

**Tareas principales:**
- [ ] Investigar mecánica de enrage en TFT (referencia)
- [ ] Definir tiempo de activación de enrage (ej: después de 60 segundos)
- [ ] Implementar aceleración de combate (aumentar velocidad de ataque, daño, etc.)
- [ ] Agregar efectos visuales de enrage
- [ ] Aplicar multiplicadores de stats durante enrage
- [ ] Asegurar que el combate termine rápidamente durante enrage

---

## 🔄 Orden de Trabajo Sugerido

### Fase 1: Sistemas Core de Gameplay
1. **`feature/barra-energia`** → Base para habilidades
2. **`feature/sistema-habilidades`** → Usa la barra de energía
3. **`feature/sistema-estrellas`** → Sistema core de autochess
4. **`feature/refinar-movimiento`** → Mejora gameplay core

### Fase 2: Sistemas de Tiempo
5. **`feature/timers-rondas-interfaz`** → Base para sistemas de tiempo
6. **`feature/limite-tiempo-rondas`** → Usa timers
7. **`feature/sistema-enrage`** → Usa timers y límite de tiempo

### Fase 3: Mejoras Visuales y Contenido
8. **`feature/animaciones-basicas`** → Mejora visual
9. **`feature/mejorar-ui-tienda`** → Mejora UX
10. **`feature/expansion-enemigos-no-muertos`** → Contenido nuevo

**Nota:** El orden es solo una guía. Puedes trabajar en el orden que prefieras según tus necesidades. Las dependencias están marcadas claramente.

---

## ✅ Branches Completados

- [x] `feature/arena-visual` (En progreso, no fusionado aún)

---

## 📝 Notas Importantes

- **Los branches son independientes** hasta que los fusiones
- **Puedes cambiar el orden de trabajo** en cualquier momento
- **Puedes agregar nuevos branches** cuando quieras
- **La prioridad es solo una guía**, ajústala según necesites
- **Cada branch debe fusionarse a master** antes de trabajar en dependencias

---

## 🚀 Comandos Útiles

### Cambiar entre branches
```bash
git checkout feature/barra-energia
git checkout feature/sistema-habilidades
# etc...
```

### Ver todos los branches
```bash
git branch          # Locales
git branch -a       # Locales y remotos
```

### Subir branch al remoto
```bash
git push -u origin feature/barra-energia
```

### Ver diferencias con master
```bash
git diff master..feature/barra-energia
```

---

## 📊 Estado Actual

| Branch | Prioridad | Estado | Depende de |
|--------|-----------|--------|------------|
| `feature/barra-energia` | 1 | ⏳ Pendiente | - |
| `feature/sistema-habilidades` | 2 | ⏳ Pendiente | `feature/barra-energia` |
| `feature/refinar-movimiento` | 3 | ⏳ Pendiente | - |
| `feature/animaciones-basicas` | 4 | ⏳ Pendiente | - |
| `feature/mejorar-ui-tienda` | 5 | ⏳ Pendiente | - |
| `feature/sistema-estrellas` | 6 | ⏳ Pendiente | - |
| `feature/expansion-enemigos-no-muertos` | 7 | ⏳ Pendiente | - |
| `feature/timers-rondas-interfaz` | 8 | ⏳ Pendiente | - |
| `feature/limite-tiempo-rondas` | 9 | ⏳ Pendiente | `feature/timers-rondas-interfaz` |
| `feature/sistema-enrage` | 10 | ⏳ Pendiente | `feature/timers-rondas-interfaz`, `feature/limite-tiempo-rondas` |

---

## 📝 Notas sobre Nuevos Branches

### Sistema de Estrellas
- **Importante:** Este es un sistema core de autochess. Puede tener alta prioridad si quieres implementarlo temprano.
- **Complejidad:** Media-Alta (requiere lógica de detección y combinación)

### Expansión Enemigos No Muertos
- **Contenido:** Nuevo contenido, puede implementarse en paralelo con otros sistemas
- **Boss Final:** Requiere diseño especial y mecánicas únicas

### Sistemas de Tiempo (Timers, Límite, Enrage)
- **Dependencias:** Los tres están relacionados. Timers es la base.
- **Enrage:** Inspirado en TFT, acelera combate para evitar empates largos
- **Referencia TFT:** El enrage en TFT aumenta daño y velocidad de ataque progresivamente

---

**¡Todos los branches están listos para trabajar! 🎉**

**Total de branches:** 11 (incluyendo `feature/arena-visual`)

