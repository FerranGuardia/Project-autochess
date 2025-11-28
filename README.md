# 🎮 AutoChess - Proyecto Godot

**Fecha de creación:** Diciembre 2024  
**Última actualización:** Enero 2025  
**Motor:** Godot 4.5+  
**Estado del Proyecto:** En desarrollo activo - Core gameplay funcional

---

## 📋 Descripción

Juego AutoChess simplificado desarrollado en Godot 4.5+. El proyecto está enfocado en crear un **MVP jugable y completo** en lugar de intentar replicar juegos complejos como TFT.

**Filosofía:** Simple, completo y divertido > Complejo e incompleto

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

### 📋 Próximos Pasos
- 📋 Sistema de combinación de unidades (3 unidades = 1 estrella)
- 📋 Sistema de sinergias (Dark Path, For the Light, Absolute Balance)
- 📋 Mejoras visuales y feedback
- 📋 Balanceo de unidades y enemigos

---

## 🚀 Inicio Rápido

1. Abre el proyecto en Godot 4.5+
2. Abre la escena `scenes/Board.tscn`
3. Presiona `F5` para ejecutar
4. Los tests se ejecutan automáticamente

---

## 📚 Documentación

### 🎯 Para Planificar tu MVP (Empieza Aquí)

**Ubicación:** `docs/mvp/`

1. **`RESUMEN_PLANIFICACION.md`** ⭐ **LEE ESTO PRIMERO**
   - Resumen ejecutivo
   - Qué hacer ahora
   - Checklist de preparación

2. **`PLANIFICACION_MVP.md`**
   - Análisis de estado actual
   - Definición de MVP
   - Priorización de tareas

3. **`CUESTIONARIO_MVP.md`** ⭐ **RESPONDE ESTO**
   - Preguntas para definir tu MVP
   - Te ayuda a tomar decisiones

4. **`MI_ROADMAP_PERSONALIZADO.md`** ⭐ **LLENA ESTO**
   - Template de roadmap personalizado
   - Tracking de progreso

5. **`MVP_REALISTA.md`**
   - Por qué simplificar
   - Comparación TFT vs MVP

6. **`PLAN_SIMPLIFICACION.md`**
   - Plan práctico de simplificación

### 🔧 Documentación Técnica

**Ubicación:** `docs/technical/`

- `ESPECIFICACIONES_TABLERO.md` - Especificaciones del tablero
- `RESUMEN_CREACION_TABLERO.md` - Resumen de creación del tablero
- `GUIA_CREAR_TABLERO.md` - Guía rápida del tablero
- `DESIGN_DECISIONS.md` - Decisiones de diseño
- `PLAN_ESPACIO_UI.md` - Plan de espacio para UI
- `SISTEMA_COMBATE.md` - Documentación del sistema de combate
- `SISTEMA_ORO_TIENDA.md` - Sistema de economía y tienda
- `SISTEMA_FASES_RONDAS.md` - Sistema de rondas y fases
- `SISTEMA_RESURRECCION.md` - Sistema de resurrección y curación
- `SISTEMA_BARRAS_VIDA.md` - Sistema de barras de vida

### 📖 Guías de Desarrollo

**Ubicación:** `docs/guides/`

- `GUIA_TESTS.md` - Guía de tests unitarios
- `GUIA_TESTS_INTEGRACION.md` - Guía de tests de integración
- `GUIA_DESARROLLADOR_VIDEOJUEGOS.md` - Guía general de desarrollo
- `FLUJO_TRABAJO_PRACTICO.md` - Flujo de trabajo práctico
- `CHECKLIST_DESARROLLADOR.md` - Checklist rápido

---

## 🗂️ Estructura del Proyecto

```
autochess/
├── assets/
│   └── sprites/
│       └── units/          # Sprites de unidades (idle animations)
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

## 💡 Filosofía del Proyecto

**No intentamos hacer TFT.** Intentamos hacer **TU autochess**:
- Simple y completo
- Jugable y divertido
- Aprendizaje en el proceso
- Algo de lo que estar orgulloso

---

**¡Buena suerte con tu desarrollo! 🎮**
