# 🎮 AutoChess - Proyecto Godot

**Fecha de creación:** Diciembre 2024  
**Última actualización:** Diciembre 2024  
**Motor:** Godot 4.5+  
**Estado del Proyecto:** En desarrollo - MVP en planificación

---

## 📋 Descripción

Juego AutoChess simplificado desarrollado en Godot 4.5+. El proyecto está enfocado en crear un **MVP jugable y completo** en lugar de intentar replicar juegos complejos como TFT.

**Filosofía:** Simple, completo y divertido > Complejo e incompleto

---

## 🎯 Estado Actual

### ✅ Completado
- ✅ Tablero visual completo (Grid Enemigo, Grid Aliado, Banquillo)
- ✅ Sistema de drag & drop funcional (grid ↔ bench)
- ✅ Sistema de combate básico
- ✅ 6 tipos de unidades definidos
- ✅ Tests unitarios (14 tests pasando)
- ✅ Tests de integración (base creada)
- ✅ Código bien estructurado

### 📋 Próximos Pasos (MVP)
- 📋 Sistema de oro
- 📋 Sistema de compra (UI de tienda)
- 📋 Sistema de rondas completo
- 📋 IA simple para enemigos
- 📋 Sistema de combinación de unidades

**Tiempo estimado para MVP:** 3-4 semanas

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
│       └── units/          # Sprites de unidades ✅
├── docs/                   # Documentación organizada
│   ├── mvp/               # Planificación MVP
│   ├── technical/         # Documentación técnica
│   └── guides/            # Guías de desarrollo
├── scenes/
│   └── Board.tscn         # Escena principal ✅
├── scripts/
│   ├── Board.gd           # Script principal ✅
│   ├── GridEnemy.gd       # Grid enemigo ✅
│   ├── GridAlly.gd        # Grid aliado ✅
│   ├── Bench.gd           # Banquillo ✅
│   ├── Unit.gd            # Sistema de unidades ✅
│   ├── UnitData.gd        # Datos de unidades ✅
│   └── tests/
│       ├── Tests.gd       # Tests unitarios ✅
│       └── IntegrationTests.gd  # Tests integración ✅
├── project.godot          # Configuración del proyecto
└── README.md              # Este archivo
```

---

## 🎯 Próximos Pasos

### 1. Planificación (Haz esto primero)
1. Lee `docs/mvp/RESUMEN_PLANIFICACION.md`
2. Responde `docs/mvp/CUESTIONARIO_MVP.md`
3. Crea tu `docs/mvp/MI_ROADMAP_PERSONALIZADO.md`

### 2. Desarrollo
Una vez definido tu MVP, empieza con:
- Sistema de oro
- Sistema de compra
- Sistema de rondas

---

## 📝 Notas de Desarrollo

- **Resolución:** 1920×1080 (Full HD)
- **Tamaño de celda:** 100px × 100px
- **Grids:** 7 columnas × 5 filas cada uno
- **Banquillo:** 10 slots horizontales

---

## 💡 Filosofía del Proyecto

**No intentamos hacer TFT.** Intentamos hacer **TU autochess**:
- Simple y completo
- Jugable y divertido
- Aprendizaje en el proceso
- Algo de lo que estar orgulloso

---

**¡Buena suerte con tu desarrollo! 🎮**
