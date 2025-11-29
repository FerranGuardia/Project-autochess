# ❤️ Sistema de Barras de Vida - Implementación

**Fecha:** Diciembre 2024  
**Estado:** ✅ Implementado

---

## 📋 Resumen

Sistema de barras de vida visuales para todas las unidades (aliadas y enemigas) con actualización automática y cambio de color según la salud.

---

## 🎯 Características

### Visual
- Barra de 60x6 píxeles debajo del sprite
- Fondo negro semitransparente
- Barra de relleno que cambia de color según la salud
- Se actualiza automáticamente cuando cambia la salud

### Colores por Salud
- **Verde (>60%):** Salud buena
- **Amarillo (30-60%):** Salud media
- **Rojo (<30%):** Salud baja

### Funcionalidad
- Funciona para unidades aliadas y enemigas
- Se crea automáticamente al inicializar la unidad
- Se actualiza cuando la unidad recibe daño o cura

---

## 🔧 Implementación

### Unit.gd

**Nuevas propiedades:**
```gdscript
var max_health: int = 100
var current_health: int = 100
var health_bar: Node2D
var health_bar_background: ColorRect
var health_bar_fill: ColorRect
```

**Nuevas señales:**
- `health_changed(current_health, max_health)`
- `unit_died(unit)`

**Nuevas funciones:**
- `get_health()` / `get_max_health()`
- `take_damage(amount)`
- `heal(amount)`
- `die()`
- `is_alive()`
- `create_health_bar()`
- `update_health_bar()`

---

## 📊 Sistema de Salud

### Inicialización

**Unidades Aliadas:**
```gdscript
max_health = UnitData.get_unit_health(type)
current_health = max_health
```

**Enemigos:**
```gdscript
max_health = EnemyData.get_enemy_health(type)
current_health = max_health
```

### Valores de Salud por Tipo

**Unidades Aliadas:**
- Mago: 60 HP
- Orco: 100 HP (tanque)
- Elfo: 50 HP (ranged)
- Enano: 80 HP (mele)
- Beastkin: 70 HP (mele rápido)
- Demonio: 90 HP (tanque/DPS)

**Enemigos:**
- Goblin Arquero: 50 HP
- Goblin Asesino: 60 HP
- Goblin Defensor: 100 HP

---

## 🎨 Barra de Vida Visual

### Estructura
```
HealthBar (Node2D)
├── HealthBarBackground (ColorRect) - 60x6px, negro
└── HealthBarFill (ColorRect) - 58x4px, color variable
```

### Posicionamiento
- Posición: `Vector2(-30, -50)` (debajo del sprite)
- Se ajusta automáticamente con el sprite

### Actualización
- Se actualiza cuando cambia `current_health`
- Calcula porcentaje: `health_percentage = current_health / max_health`
- Ajusta ancho: `bar_width = 58.0 * health_percentage`
- Cambia color según porcentaje

---

## 🔄 Flujo de Actualización

### Cuando se Recibe Daño
1. `take_damage(amount)` reduce `current_health`
2. Se llama `update_health_bar()`
3. Se emite señal `health_changed()`
4. Si `current_health <= 0`, se llama `die()`

### Cuando se Cura
1. `heal(amount)` aumenta `current_health`
2. Se llama `update_health_bar()`
3. Se emite señal `health_changed()`

### Cuando Muere
1. `die()` establece `current_health = 0`
2. Actualiza barra de vida
3. Emite señal `unit_died()`

---

## ✅ Estado Actual

### Completado
- ✅ Sistema de salud completo
- ✅ Barras de vida visuales
- ✅ Actualización automática
- ✅ Cambio de color según salud
- ✅ Funciona para aliados y enemigos
- ✅ Integración con sistema de combate

### Integración
- Se usa en `CombatSystem` para calcular daño
- Se conecta con sistema de resurrección
- Se actualiza durante el combate

---

**Sistema completamente funcional y listo para usar**





