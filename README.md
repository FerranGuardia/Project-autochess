# 🎮 AutoChess - Proyecto Godot

**Fecha de creación:** Diciembre 2024  
**Última actualización:** Enero 2025  
**Motor:** Godot 4.5+  
**Estado del Proyecto:** En desarrollo activo - Core gameplay funcional

---

## 📋 Descripción

Juego AutoChess desarrollado en Godot 4.5+. Este proyecto busca crear un autochess completo con sistemas de combate, gestión de recursos, unidades y mecánicas estratégicas. El juego combina elementos de estrategia, gestión de recursos y combate automático en un formato de autochess.

---

## 🎯 Estado Actual

### ✅ Sistemas Completados

#### 🎮 Core Gameplay
- ✅ **Sistema de combate completo** - Movimiento, ataque, rango, cooldowns
- ✅ **Sistema de rondas** - 5 rondas con fases de preparación y combate
- ✅ **Sistema de oro** - Oro inicial, ganancias por ronda, gestión de recursos
- ✅ **Sistema de tienda** - Compra de unidades con UI funcional
- ✅ **Sistema de vidas** - 5 vidas iniciales, game over al perder todas
- ✅ **Sistema de enemigos** - IA que genera oleadas por ronda
- ✅ **Sistema de loot** - Enemigos otorgan oro al morir según tipo

#### 🎨 Interfaz y Visuales
- ✅ **Tablero visual completo** - Grid Enemigo, Grid Aliado, Banquillo
- ✅ **Sistema de drag & drop** - Movimiento fluido entre grid ↔ bench
- ✅ **Shop UI** - Interfaz de tienda con actualización en tiempo real
- ✅ **Barras de vida** - Visualización de salud en combate
- ✅ **Feedback visual** - Indicadores de fase, ronda, oro, vidas

#### ⚔️ Unidades y Combate
- ✅ **6 tipos de unidades aliadas** - Elfo, Enano, Beastkin, Mago, Orco, Demonio
- ✅ **Sistema de unidades enemigas** - Goblin Bow, Goblin Dagger, Goblin Shield
- ✅ **Sistema de resurrección** - Unidades reviven después de cada ronda
- ✅ **Sistema de curación** - Todas las unidades se curan completamente entre rondas
- ✅ **Sistema de posiciones iniciales** - Restauración automática de posiciones

#### 🧪 Testing
- ✅ **Tests unitarios** - Shop, Enemigos, Combate
- ✅ **Tests de integración** - Flujo completo de rondas, tienda, combate
- ✅ **Cobertura de sistemas principales**

### 📋 Próximos Pasos (Features en Desarrollo)

#### 🎮 Sistemas de Gameplay
- 📋 **Sistema de estrellas** - Mejora de unidades (3 unidades = 1 estrella)
- 📋 **Sistema de barra de energía** - Carga de energía con ataques
- 📋 **Sistema de habilidades** - Habilidades especiales para unidades
- 📋 **Refinamiento de movimiento** - Mejoras en pathfinding y reglas de movimiento

#### ⏱️ Sistemas de Tiempo
- 📋 **Timers de rondas e interfaz** - Sistema de timers visual
- 📋 **Límite de tiempo de rondas** - Límite de 1:30 minutos por ronda
- 📋 **Sistema de enrage** - Aceleración de combate después de tiempo estimulado

#### 🎨 Mejoras Visuales
- 📋 **Animaciones básicas** - Animaciones para todas las unidades
- 📋 **Mejoras de UI tienda** - Mejor diseño y UX de la tienda

#### 🧟 Expansión de Contenido
- 📋 **Expansión enemigos no muertos** - Nuevos enemigos para rondas 5-10 con boss final

---

## 🚀 Inicio Rápido

1. Abre el proyecto en Godot 4.5+
2. Abre la escena `scenes/Board.tscn`
3. Presiona `F5` para ejecutar
4. Los tests se ejecutan automáticamente

---

## 📚 Documentación

### 📖 Guía de Desarrollo

**`docs/GUIA_DESARROLLO.md`** ⭐ **EMPIEZA AQUÍ**
- Guía completa unificada de desarrollo
- Estructura del proyecto
- Flujo de trabajo
- Checklist diario
- Testing (unitarios e integración)
- Mejores prácticas y herramientas

### 🌿 Branches y Features

**`docs/BRANCHES_PRIORIDADES.md`**
- Lista completa de branches creados
- Prioridades y dependencias
- Estado de cada feature
- Orden de trabajo sugerido

### 🔧 Documentación Técnica

**Ubicación:** `docs/technical/`

- `SISTEMA_COMBATE.md` - Sistema de combate
- `SISTEMA_ORO_TIENDA.md` - Sistema de economía y tienda
- `SISTEMA_FASES_RONDAS.md` - Sistema de rondas y fases
- `SISTEMA_RESURRECCION.md` - Sistema de resurrección y curación
- `SISTEMA_BARRAS_VIDA.md` - Sistema de barras de vida
- `ESPECIFICACIONES_TABLERO.md` - Especificaciones del tablero
- `GUIA_CREAR_TABLERO.md` - Guía de creación del tablero
- `DESIGN_DECISIONS.md` - Decisiones de diseño
- `PLAN_ESPACIO_UI.md` - Plan de espacio para UI
- `LAYOUT_TIENDA.md` - Layout de la tienda

### 🎨 Recursos

- `docs/PROMPTS_ENEMIGOS_GOBLIN.md` - Prompts para crear sprites de enemigos

---

## 🗂️ Estructura del Proyecto

```
autochess/
├── assets/
│   └── sprites/
│       ├── units/          # Sprites de unidades
│       └── arena/          # Sprites de tablero y tiles
├── docs/                   # Documentación organizada
│   ├── mvp/               # Planificación MVP
│   ├── technical/         # Documentación técnica
│   └── guides/            # Guías de desarrollo
├── scenes/
│   └── Board.tscn         # Escena principal del juego
├── scripts/
│   ├── Board.gd           # Script principal - Orquesta todos los sistemas
│   ├── GameManager.gd     # Gestor de estado (oro, rondas, vidas, fases)
│   ├── Shop.gd            # Sistema de tienda y compra de unidades
│   ├── ShopUI.gd          # Interfaz visual de la tienda
│   ├── CombatSystem.gd    # Sistema de combate (movimiento, ataque, targeting)
│   ├── GridAlly.gd        # Grid aliado (colocación, resurrección, curación)
│   ├── GridEnemy.gd       # Grid enemigo (spawning, loot)
│   ├── Bench.gd           # Banquillo (almacenamiento temporal)
│   ├── EnemyAI.gd         # IA que genera composiciones de enemigos
│   ├── Unit.gd            # Clase base de unidades
│   ├── UnitData.gd        # Datos de unidades aliadas
│   ├── EnemyData.gd       # Datos de unidades enemigas
│   └── tests/
│       ├── ShopTests.gd       # Tests de tienda y oro
│       ├── EnemyTests.gd     # Tests de enemigos y loot
│       ├── CombatTests.gd    # Tests de combate y resurrección
│       └── IntegrationTests.gd  # Tests de integración completa
├── project.godot          # Configuración del proyecto
└── README.md              # Este archivo
```

---

## 🎮 Cómo Jugar

### Flujo del Juego
1. **Fase de Preparación (30 segundos)**
   - Compra unidades en la tienda con tu oro
   - Coloca unidades desde el banquillo al grid aliado
   - Reorganiza tu formación arrastrando unidades

2. **Fase de Combate**
   - Las unidades se mueven automáticamente hacia los enemigos
   - Atacan según su rango (melee o ranged)
   - Los enemigos otorgan oro al morir

3. **Entre Rondas**
   - Todas las unidades se curan completamente
   - Las unidades muertas se resucitan
   - Se restauran las posiciones iniciales
   - Ganas oro adicional al comenzar la nueva ronda

4. **Victoria**
   - Completa las 5 rondas para ganar
   - Pierdes si te quedas sin vidas (5 vidas iniciales)

### Controles
- **Click y arrastrar** - Mover unidades entre banquillo y grid
- **Click en botones de compra** - Comprar unidades en la tienda
- El juego avanza automáticamente entre fases

---

## 👥 Unidades Disponibles

### Unidades Aliadas (6 tipos)
| Unidad | Costo | Tipo | Descripción |
|--------|-------|------|-------------|
| **Elfo** | 1 | Ranged | Unidad ranged asequible |
| **Enano** | 1 | Melee | Unidad melee asequible |
| **Beastkin** | 2 | Especial | Mecánicas inusuales, risk/reward |
| **Mago** | 3 | Ranged | Unidad ranged poderosa |
| **Orco** | 3 | Melee | Unidad melee poderosa |
| **Demonio** | 3 | Especial | Habilidades especiales, escalado |

### Unidades Enemigas (3 tipos)
- **Goblin Bow** - Enemigo ranged
- **Goblin Dagger** - Enemigo melee rápido
- **Goblin Shield** - Enemigo melee defensivo

## 📝 Especificaciones Técnicas

- **Resolución:** 1920×1080 (Full HD)
- **Tamaño de celda:** 100px × 100px
- **Grids:** 7 columnas × 5 filas cada uno (Grid Aliado y Grid Enemigo)
- **Banquillo:** 10 slots horizontales
- **Oro inicial:** 10
- **Oro por ronda:** 5
- **Vidas iniciales:** 5
- **Rondas totales:** 5
- **Tiempo de preparación:** 30 segundos por ronda

---

## 🔧 Tecnologías y Herramientas

- **Motor:** Godot 4.5+
- **Lenguaje:** GDScript
- **Control de Versiones:** Git con Gitflow
- **Testing:** Tests unitarios e integración incluidos

## 📈 Progreso del Proyecto

El proyecto está en desarrollo activo con sistemas core completados y nuevas features planificadas. Para ver el estado detallado de cada feature y sus prioridades, consulta `docs/BRANCHES_PRIORIDADES.md`.

---

**¡Disfruta desarrollando tu autochess! 🎮**
