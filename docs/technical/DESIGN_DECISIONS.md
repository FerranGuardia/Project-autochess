# 🎨 Decisiones de Diseño - AutoChess Project

**Fecha de creación:** Diciembre 2024  
**Última actualización:** 26 de Diciembre 2024, 11:40 AM  
**Proyecto:** AutoChess (estilo Teamfight Tactics)  
**Motor:** Godot 4.5+

---

## 📋 Índice

1. [Visión del Proyecto](#visión-del-proyecto)
2. [Decisiones Visuales](#decisiones-visuales)
3. [Decisiones de Mecánicas](#decisiones-de-mecánicas)
4. [Decisiones Técnicas](#decisiones-técnicas)
5. [Herramientas y Assets](#herramientas-y-assets)
6. [Problemas Resueltos](#problemas-resueltos)
7. [Roadmap de Implementación](#roadmap-de-implementación)

---

## 🎯 Visión del Proyecto

### Objetivo Principal
Crear un juego autochess completo estilo Teamfight Tactics (TFT) con mecánicas sólidas, visuales atractivos y potencial comercial para Steam.

### Filosofía de Desarrollo
- **Construcción incremental:** Implementar mecánicas base primero, pulir después
- **Flexibilidad arquitectónica:** Código preparado para migración 2D → 3D
- **Calidad sobre velocidad:** Mejor hacerlo bien que rápido
- **Documentación continua:** Registrar decisiones para portfolio y futuro

---

## 🎨 Decisiones Visuales

### 1. Enfoque Visual: 2D Isométrico Primero, 3D Después

**Decisión:** Comenzar con sprites 2D isométricos, migrar a 3D opcionalmente en el futuro.

**Razones:**
- ✅ Menor complejidad inicial (primer proyecto)
- ✅ Desarrollo más rápido de assets
- ✅ Arquitectura del código permite migración fácil
- ✅ Permite validar mecánicas antes de invertir en 3D
- ✅ Experiencia del desarrollador en dibujo/modelado puede aprovecharse

**Fecha de decisión:** Diciembre 2024

**Estado:** En progreso - Generando sprites 2D con Sloyd AI

---

### 2. Herramienta de Generación de Assets: Sloyd AI

**Decisión:** Usar Sloyd AI para generar tanto sprites 2D como modelos 3D.

**Razones:**
- ✅ **Text to Image:** Genera sprites 2D isométricos
- ✅ **Text to 3D:** Permite migración futura a 3D
- ✅ **Consistencia visual:** Misma herramienta para todo
- ✅ **Flexibilidad:** Puede iterar rápidamente
- ✅ **Control:** Prompts específicos para cada unidad

**Características:**
- Sprites 2D: 64x64 o 128x128 píxeles, isométricos, fondo transparente
- Modelos 3D: Low-poly, estilizados, T-pose, game-ready
- Estilo: Autochess/TFT, pixel art para 2D, low-poly para 3D

**Fecha de decisión:** Diciembre 2024

**Estado:** En progreso - Prompts creados, generación en curso

**Archivos relacionados:**
- `PROMPTS_SLOYD_AI_2D.md` - Prompts para sprites 2D
- `PROMPTS_SLOYD_AI.md` - Prompts para modelos 3D

---

### 3. Paleta de Colores por Unidad

**Decisión:** Cada unidad tiene un color principal distintivo para identificación rápida.

| Unidad | Color | RGB | Hex |
|--------|-------|-----|-----|
| Mago | Azul | (0.2, 0.4, 0.9) | #3366E6 |
| Orco | Rojo | (0.9, 0.2, 0.2) | #E63333 |
| Elfo | Verde | (0.2, 0.9, 0.4) | #33E666 |
| Enano | Marrón | (0.6, 0.4, 0.2) | #996633 |
| Beastkin | Amarillo | (0.9, 0.9, 0.2) | #E6E633 |
| Demonio | Magenta | (0.9, 0.2, 0.7) | #E633B3 |

**Razones:**
- Identificación visual rápida
- Consistencia con sistema de colores en código
- Facilita diferenciación en combate

---

### 4. Estilo de Sprites: Pixel Art Isométrico

**Decisión:** Sprites en estilo pixel art isométrico, vista top-down.

**Características:**
- Tamaño: 64x64 o 128x128 píxeles
- Vista: Isométrica/top-down
- Estilo: Pixel art, simple y limpio
- Fondo: Transparente (PNG con alpha)

**Razones:**
- Compatible con autochess
- Fácil de generar con IA
- Escalable a diferentes resoluciones
- Estilo reconocible y atractivo

---

## ⚔️ Decisiones de Mecánicas

### 1. Sistema de Combate

**Decisión:** Combate automático por turnos con sistema de rango, daño y defensa.

**Características implementadas:**
- ✅ Búsqueda automática de objetivos
- ✅ Priorización: siempre el enemigo más cercano (modificable por habilidades)
- ✅ Cálculo de daño: `daño = ataque - defensa`
- ✅ Sistema de rango (melee vs ranged)
- ✅ Velocidad de ataque (cooldowns)
- ✅ Energía y habilidades especiales
- ✅ Terminación automática de combate

**Razones:**
- Mecánica core de autochess
- Permite estrategia en posicionamiento
- Base sólida para expandir

---

### 2. Sistema de Movimiento (Estilo TFT)

**Decisión:** Implementar movimiento suave estilo Teamfight Tactics.

**Características:**
- ✅ Movimiento suave (2 celdas/segundo)
- ✅ Bodyblock: unidades no pueden superponerse
- ✅ Pathfinding implícito hacia objetivo más cercano
- ✅ Lógica de posicionamiento: melee se acerca, ranged mantiene distancia
- ✅ Sistema de espera: unidades bloqueadas esperan hasta que haya espacio

**Razones:**
- Mejora la experiencia visual
- Añade profundidad táctica
- Similar a TFT (referencia conocida)

---

### 3. Sistema de Niveles/Estrellas

**Decisión:** Sistema de combinación automática (3 unidades = 1 unidad de nivel superior).

**Características:**
- ✅ 3 unidades del mismo tipo/nivel → 1 unidad de nivel superior
- ✅ Niveles: 1 estrella, 2 estrellas, 3 estrellas
- ✅ Multiplicadores de stats por nivel:
  - 1 estrella: 1.0x
  - 2 estrellas: 1.8x
  - 3 estrellas: 2.8x
- ✅ Indicadores visuales de estrellas
- ✅ Combinación automática desde bench y tablero

**Razones:**
- Mecánica core de autochess
- Añade profundidad estratégica
- Progresión satisfactoria

---

### 4. Sistema de Tienda y Bench

**Decisión:** Tienda con ofertas aleatorias y bench (inventario) para unidades.

**Características:**
- ✅ Tienda con 5 ofertas aleatorias por ronda
- ✅ Bench con capacidad de 10 unidades
- ✅ Drag and drop entre bench y tablero
- ✅ Combinación automática desde bench
- ✅ Posicionamiento visual del bench

**Razones:**
- Gestión de recursos estratégica
- Permite planificación de composiciones
- Base para economía futura

---

## 🔧 Decisiones Técnicas

### 1. Arquitectura del Código

**Decisión:** Separación de responsabilidades con scripts modulares.

**Estructura:**
- `Main.gd` - Controlador principal, gestión de fases, bench
- `Board.gd` - Gestión del tablero, grid, posicionamiento
- `Unit.gd` - Lógica de unidades individuales, combate, movimiento
- `UnitData.gd` - Datos estáticos de unidades (stats, colores, nombres)
- `Shop.gd` - Gestión de tienda y ofertas
- `GameManager.gd` - Gestión de estado del juego (futuro)

**Razones:**
- Mantenibilidad
- Escalabilidad
- Facilita testing
- Permite migración 2D → 3D

---

### 2. Sistema de Grid

**Decisión:** Grid 2D basado en celdas para posicionamiento.

**Características:**
- Grid bidimensional (x, y)
- Cada celda puede contener una unidad
- Validación de posiciones
- Conversión grid ↔ posición mundial

**Razones:**
- Simple y eficiente
- Fácil de visualizar
- Base para pathfinding futuro

---

### 3. Sistema de Señales (Signals)

**Decisión:** Usar señales de Godot para comunicación entre nodos.

**Señales implementadas:**
- `unit_purchased(unit_type)` - Compra de unidad
- `phase_changed(phase)` - Cambio de fase
- `round_started(round)` - Inicio de ronda
- `unit_died(unit)` - Muerte de unidad

**Razones:**
- Desacoplamiento de componentes
- Fácil de extender
- Patrón estándar de Godot

---

## 🛠️ Herramientas y Assets

### Herramientas Utilizadas

1. **Godot Engine 4.5+**
   - Motor del juego
   - GDScript como lenguaje principal

2. **Sloyd AI**
   - Generación de sprites 2D (Text to Image)
   - Generación de modelos 3D (Text to 3D)
   - Prompts específicos por unidad

3. **GIMP/Photoshop** (opcional)
   - Post-procesamiento de sprites
   - Ajuste de colores
   - Limpieza de assets

### Estructura de Assets

```
assets/
├── sprites/
│   └── units/
│       ├── mago_idle.png
│       ├── orco_idle.png
│       ├── elfo_idle.png
│       ├── enano_idle.png
│       ├── beastkin_idle.png
│       └── demonio_idle.png
└── models/ (futuro)
    └── units/
        └── [modelos 3D]
```

---

## 🐛 Problemas Resueltos

### 1. Overlap de Unidades al Comprar
**Problema:** Unidades se superponían al comprarlas.  
**Solución:** Validación doble en `place_unit()` y búsqueda de celda disponible.

### 2. Dead Units No Removidas
**Problema:** Unidades muertas permanecían en arrays.  
**Solución:** Implementado `on_unit_died()` que llama a `remove_unit()`.

### 3. Combate No Terminaba
**Problema:** Combate continuaba indefinidamente.  
**Solución:** Implementado `check_combat_end()` que verifica unidades vivas.

### 4. Grid Position Validation
**Problema:** `Vector2(0,0)` evaluado como `false`.  
**Solución:** Cambio a `grid_position.x >= 0 and grid_position.y >= 0`.

### 5. Duplicate Drag Events
**Problema:** `_on_unit_drag_started` llamado dos veces.  
**Solución:** Removido call duplicado y añadido check `if dragged_unit == unit: return`.

---

## 📊 Roadmap de Implementación

Ver `ROADMAP.md` para detalles completos.

### Fases Completadas ✅
- Fase Base: Estructura del proyecto
- Fase 1.1-1.6: Sistema de combate completo
- Fase 1.7: Priorización de objetivos
- Fase 2.2: Sistema de niveles/estrellas

### Fase Actual 🚧
- **1.8 Assets Visuales 2D Isométricos**
  - Generación de sprites con Sloyd AI
  - Integración en Godot
  - Reemplazo de ColorRects por Sprite2D

### Próximas Fases 📋
- 1.9: UI de combate mejorada
- 1.10: IA para colocar unidades enemigas
- 2.3: Sistema de sinergias
- 3.1: Sistema de oro mejorado
- 3.2: Sistema de items/equipamiento

---

## 📝 Notas para Portfolio

### Puntos Destacables

1. **Arquitectura Flexible:** Código preparado para migración 2D → 3D
2. **Decisiones Documentadas:** Registro completo de decisiones técnicas
3. **Iteración Rápida:** Uso de IA para generación de assets
4. **Mecánicas Sólidas:** Sistema de combate, movimiento, y progresión implementados
5. **Enfoque Incremental:** Desarrollo por fases con validación continua

### Tecnologías y Conceptos

- Godot Engine 4.5+
- GDScript
- Sistemas de señales
- Grid-based gameplay
- Pathfinding básico
- IA generativa para assets
- Game design de autochess

---

## 🔄 Cambios Futuros Potenciales

### Migración a 3D (Opcional)
- Reemplazar sprites 2D por modelos 3D
- Ajustar cámara y perspectiva
- Adaptar animaciones

### Expansión de Mecánicas
- Sistema de sinergias
- Items y equipamiento
- Más tipos de unidades
- Habilidades más complejas

---

**Documento vivo:** Este archivo se actualiza continuamente con nuevas decisiones y cambios.

