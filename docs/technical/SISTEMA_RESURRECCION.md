# 🔄 Sistema de Resurrección - Implementación

**Fecha:** Diciembre 2024  
**Estado:** ✅ Implementado

---

## 📋 Resumen

Sistema que revive automáticamente todas las unidades aliadas después de cada ronda y las restaura a sus posiciones iniciales.

---

## 🎯 Reglas Implementadas

### 1. Resurrección Automática
- **Cuándo:** Después de cada ronda de combate
- **Qué:** Todas las unidades aliadas muertas reviven
- **Salud:** Se restaura a salud completa (100%)

### 2. Restauración de Posiciones
- Las unidades vuelven a la misma posición donde empezaron la ronda
- Se guardan las posiciones al inicio del combate
- Se restauran automáticamente al final

### 3. Límite de Unidades
- **Máximo:** 10 unidades en el grid aliado
- **Validación:** Se aplica al colocar nuevas unidades
- **Excepción:** No cuenta unidades que ya están en el grid (permite moverlas)

### 4. Recolocación Durante Preparación
- Durante la fase de preparación, el jugador puede mover unidades
- El drag and drop funciona normalmente
- El límite de 10 unidades se respeta

---

## 🔧 Implementación

### GridAlly.gd

**Nuevas propiedades:**
```gdscript
const MAX_UNITS_ON_GRID: int = 10
var initial_positions: Dictionary = {}  # Key: Unit, Value: Vector2i
```

**Nuevas funciones:**
- `save_initial_positions()` - Guarda posiciones antes del combate
- `resurrect_all_units()` - Revive y restaura posiciones
- `get_units_count_on_grid()` - Cuenta unidades en el grid

**Modificaciones:**
- `place_unit()` - Valida máximo 10 unidades antes de colocar

### Board.gd

**Integración:**
- Guarda posiciones al iniciar combate (`_on_combat_started()`)
- Revive unidades al terminar combate (`_on_combat_ended_system()`)

### Unit.gd

**Nueva función:**
- `resurrect()` - Revive la unidad con salud completa

---

## 🔄 Flujo del Sistema

### 1. Fase de Preparación
- Jugador puede colocar/recolocar unidades (máximo 10 en grid)
- Unidades pueden moverse entre grid y banquillo
- No hay restricciones de movimiento

### 2. Inicio del Combate
- Se guardan las posiciones iniciales de todas las unidades en el grid
- Se almacenan en `GridAlly.initial_positions`
- Comienza el combate

### 3. Durante el Combate
- Las unidades se mueven y combaten
- Pueden morir durante el combate
- Las posiciones pueden cambiar

### 4. Fin del Combate
- Todas las unidades aliadas reviven automáticamente
- Se restauran a salud completa
- Se devuelven a sus posiciones iniciales
- Vuelven a la fase de preparación

---

## 📊 Validación de Límite

### Cómo Funciona
1. Al intentar colocar una unidad nueva en el grid
2. Se cuenta cuántas unidades ya están en el grid (`y >= 0`)
3. Si hay 10 o más, se rechaza la colocación
4. Si la unidad ya está en el grid, se permite moverla

### Ejemplo
```gdscript
# Intentar colocar unidad 11
if units_on_grid >= MAX_UNITS_ON_GRID:
    print("Error: Máximo 10 unidades permitidas")
    return false
```

---

## 🔍 Detalles Técnicos

### Guardado de Posiciones
- Se guardan solo unidades en el grid (`grid_position.y >= 0`)
- Se almacenan en un Dictionary: `Unit -> Vector2i`
- Se limpian después de resucitar

### Resurrección
- Itera sobre todas las unidades guardadas
- Revive las que están muertas
- Restaura posiciones incluso si están vivas
- Actualiza barras de vida visualmente

### Restauración de Posiciones
- Si la unidad está en otra posición, se mueve
- Si ya está en la posición correcta, solo actualiza visual
- Mantiene la unidad en el grid

---

## ✅ Estado Actual

### Completado
- ✅ Guardado de posiciones iniciales
- ✅ Resurrección automática de unidades
- ✅ Restauración de posiciones
- ✅ Límite de 10 unidades
- ✅ Validación en `place_unit()`
- ✅ Recolocación durante preparación

### Características
- Las unidades muertas no se eliminan, solo se marcan
- La resurrección restaura salud completa
- Las posiciones se restauran exactamente
- El límite previene sobrepoblación

---

**Sistema completamente funcional y listo para usar**






