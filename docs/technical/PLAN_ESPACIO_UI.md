# 📐 Plan de Espacio para Componentes UI

**Fecha de creación:** 26 de Diciembre 2024, 10:30 AM  
**Última actualización:** 26 de Diciembre 2024, 11:30 AM  
**Basado en estructura de Teamfight Tactics**

---

## 🗺️ Distribución Completa del Espacio (1920×1080)

```
┌─────────────────────────────────────────────────────────────┐
│                                                             │
│  ┌─────────────────────────────────────────────────────┐   │
│  │  UI SUPERIOR                                         │   │
│  │  Y: -540 a -460 (80px altura)                        │   │
│  │  Componentes: Oro, Vida, Ronda, Temporizador        │   │
│  └─────────────────────────────────────────────────────┘   │
│                                                             │
│  ┌─────────────────────────────────────────────────────┐   │
│  │                                                      │   │
│  │  ┌──────────────┐  GRID ENEMIGO  ┌──────────────┐   │   │
│  │  │              │  7×5 celdas     │              │   │   │
│  │  │  UI LATERAL  │  700×500px      │  UI LATERAL  │   │   │
│  │  │  IZQUIERDA   │  Y: -500 a 0   │  DERECHA     │   │   │
│  │  │              │                 │              │   │   │
│  │  └──────────────┘                 └──────────────┘   │   │
│  │                                                      │   │
│  │  ┌──────────────┐  GRID ALIADO   ┌──────────────┐   │   │
│  │  │              │  7×5 celdas     │              │   │   │
│  │  │  (610px)     │  700×500px      │  (610px)     │   │   │
│  │  │              │  Y: 0 a +500    │              │   │   │
│  │  └──────────────┘                 └──────────────┘   │   │
│  │                                                      │   │
│  └─────────────────────────────────────────────────────┘   │
│                                                             │
│  ┌─────────────────────────────────────────────────────┐   │
│  │  BANQUILLO ALIADO                                    │   │
│  │  Y: +350 a +470 (120px altura)                       │   │
│  │  10 slots × 100px = 1000px ancho                      │   │
│  └─────────────────────────────────────────────────────┘   │
│                                                             │
│  ┌─────────────────────────────────────────────────────┐   │
│  │  UI INFERIOR                                         │   │
│  │  Y: +470 a +540 (150px altura)                      │   │
│  │  Componentes: Tienda, Items, Botones                 │   │
│  └─────────────────────────────────────────────────────┘   │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 📊 Áreas Definidas

### 1. UI Superior
**Posición:** Y = -540px a -460px  
**Altura:** 80px  
**Ancho:** 1920px (pantalla completa)

**Componentes planificados:**
- **Oro del jugador** (esquina superior izquierda)
- **Vida/HP** (centro superior)
- **Ronda actual** (centro superior)
- **Temporizador de fase** (esquina superior derecha)
- **Información de enemigo** (si aplica)

**Espacio reservado:** ✅

---

### 2. Grid Enemigo
**Posición:** Centro en (0, -250px)  
**Dimensiones:** 700px (ancho) × 500px (alto)  
**Rango Y:** -500px a 0px  
**Rango X:** -350px a +350px

**Estado:** ✅ Implementado

---

### 3. Grid Aliado
**Posición:** Centro en (0, +250px)  
**Dimensiones:** 700px (ancho) × 500px (alto)  
**Rango Y:** 0px a +500px  
**Rango X:** -350px a +350px

**Estado:** ✅ Implementado

---

### 4. Espacios Laterales

#### Lado Izquierdo (610px de ancho)
**Posición:** X = -960px a -350px  
**Ancho disponible:** 610px  
**Altura:** Variable según componente

**Componentes planificados:**
- **Panel de Sinergias** (arriba)
  - Lista de sinergias activas
  - Progreso hacia siguiente nivel
  - Y: -400px a -200px (aprox)
  
- **Información de Unidades** (centro)
  - Stats de unidades seleccionadas
  - Descripción de habilidades
  - Y: -100px a +200px (aprox)
  
- **Log de Combate** (abajo, opcional)
  - Eventos importantes del combate
  - Y: +300px a +450px (aprox)

**Espacio reservado:** 📋 Pendiente

#### Lado Derecho (610px de ancho)
**Posición:** X = +350px a +960px  
**Ancho disponible:** 610px  
**Altura:** Variable según componente

**Componentes planificados:**
- **Estadísticas del Combate** (arriba)
  - Daño total infligido
  - Unidades eliminadas
  - Y: -400px a -200px (aprox)
  
- **Opciones y Configuración** (centro)
  - Ajustes de juego
  - Controles
  - Y: -100px a +200px (aprox)
  
- **Información de Items** (abajo, opcional)
  - Items disponibles
  - Combinaciones posibles
  - Y: +300px a +450px (aprox)

**Espacio reservado:** 📋 Pendiente

---

### 5. Banquillo Aliado
**Posición:** Centro en (0, +410px)  
**Dimensiones:** 1000px (ancho) × 120px (alto)  
**Rango Y:** +350px a +470px  
**Rango X:** -500px a +500px  
**Slots:** 10 slots horizontales

**Estado:** ✅ Implementado

---

### 6. UI Inferior
**Posición:** Y = +470px a +540px  
**Altura:** 150px  
**Ancho:** 1920px (pantalla completa)

**Componentes planificados:**
- **Tienda** (centro-izquierda)
  - 5 unidades disponibles
  - Precios
  - Botón de refrescar
  - Ancho: ~800px
  
- **Items/Equipamiento** (centro-derecha)
  - Items disponibles
  - Items equipados
  - Ancho: ~400px
  
- **Botones de Acción** (derecha)
  - Botón de comprar XP
  - Botón de vender unidad
  - Otros controles
  - Ancho: ~300px

**Espacio reservado:** 📋 Pendiente

---

## 📏 Resumen de Espacios

| Área | Posición Y | Altura | Ancho | Estado |
|------|-----------|--------|-------|--------|
| UI Superior | -540 a -460 | 80px | 1920px | 📋 Pendiente |
| Grid Enemigo | -500 a 0 | 500px | 700px | ✅ Implementado |
| Grid Aliado | 0 a +500 | 500px | 700px | ✅ Implementado |
| Espacios Laterales | Variable | Variable | 610px c/u | 📋 Pendiente |
| Banquillo | +350 a +470 | 120px | 1000px | ✅ Implementado |
| UI Inferior | +470 a +540 | 150px | 1920px | 📋 Pendiente |

---

## 🎯 Próximos Pasos

1. ✅ **Tablero base** - Completado
2. 📋 **UI Superior** - Siguiente prioridad
3. 📋 **UI Inferior (Tienda)** - Alta prioridad
4. 📋 **Espacios laterales** - Baja prioridad (puede ser opcional)

---

**Nota:** Todos los espacios están calculados para una resolución de 1920×1080. Los componentes pueden ajustarse según necesidad visual.

