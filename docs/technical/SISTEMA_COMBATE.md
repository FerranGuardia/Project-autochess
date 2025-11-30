# ⚔️ Sistema de Combate - Implementación

**Fecha:** Diciembre 2024  
**Estado:** ✅ Implementado

---

## 📋 Resumen

Sistema completo de combate con movimiento automático de unidades, detección de objetivos, ataques y fin de combate automático.

---

## 🎯 Componentes Implementados

### 1. CombatSystem.gd
**Ubicación:** `scripts/CombatSystem.gd`

**Responsabilidades:**
- Maneja el combate entre unidades aliadas y enemigas
- Controla el movimiento de unidades hacia objetivos
- Gestiona ataques y cooldowns
- Detecta el fin del combate (victoria/derrota)

**Características:**
- Movimiento automático hacia el enemigo más cercano
- Velocidad de movimiento: 200 píxeles/segundo
- Actualización cada 0.1 segundos
- Cooldown de ataque: 1 segundo
- Cálculo de daño: `ataque - defensa` (mínimo 1)

**Funciones principales:**
- `start_combat()` - Inicia el combate
- `stop_combate()` - Detiene el combate
- `update_combat()` - Actualiza movimiento y ataques
- `find_nearest_target()` - Encuentra el objetivo más cercano
- `attack_target()` - Ataca a un objetivo
- `check_combat_end()` - Verifica si el combate terminó

---

## 🔄 Flujo del Combate

### Inicio del Combate
1. `GameManager` emite señal `combat_started`
2. `CombatSystem` recopila todas las unidades vivas
3. Se conectan señales de muerte de enemigos para otorgar loot
4. Se inicia el timer de actualización

### Durante el Combate
1. Cada unidad busca el objetivo más cercano
2. Si está en rango de ataque → ataca
3. Si no está en rango → se mueve hacia el objetivo
4. Se actualiza cada 0.1 segundos

### Fin del Combate
- **Victoria:** No quedan enemigos vivos
- **Derrota:** No quedan aliados vivos
- Se notifica a `GameManager` con el resultado

---

## 🎮 Sistema de Movimiento

### Características
- Las unidades se mueven automáticamente durante el combate
- Solo se mueven si están en el grid (no en el banquillo)
- La posición del grid se actualiza automáticamente
- Movimiento suave hacia el objetivo

### Restricciones
- Solo durante la fase de combate
- No se mueven si están en el banquillo (`grid_position.y < 0`)
- Respetan las celdas ocupadas

---

## ⚔️ Sistema de Ataque

### Cálculo de Daño
```gdscript
daño_final = max(1, ataque - defensa)
```

### Rango de Ataque
- **Melee:** Rango 1 (debe acercarse)
- **Ranged:** Rango 3+ (puede atacar desde lejos)
- Se convierte de celdas a píxeles (1 celda = 100px)

### Cooldown
- 1 segundo entre ataques
- Se rastrea por unidad usando `attack_cooldowns` Dictionary

---

## 🔗 Integración

### Con GameManager
- Escucha `combat_started` para iniciar combate
- Notifica `end_combat(victory)` cuando termina

### Con GridAlly/GridEnemy
- Obtiene todas las unidades vivas
- Actualiza posiciones del grid durante el movimiento

### Con Sistema de Loot
- Conecta señales de muerte de enemigos
- Otorga oro automáticamente cuando mueren enemigos

---

## 📊 Estado Actual

### ✅ Completado
- Sistema de combate funcional
- Movimiento automático de unidades
- Detección de objetivos
- Sistema de ataque con cooldown
- Detección de fin de combate
- Integración con sistema de loot

### ⏭️ Próximos Pasos (Opcional)
- Animaciones de ataque
- Efectos visuales de daño
- Sonidos de combate
- Mejoras de IA (priorización de objetivos)
- Sistema de habilidades especiales

---

## 🔍 Detalles Técnicos

### Configuración
```gdscript
const MOVE_SPEED: float = 200.0  # Píxeles por segundo
const ATTACK_COOLDOWN: float = 1.0  # Segundos entre ataques
const COMBAT_UPDATE_INTERVAL: float = 0.1  # Actualizar cada 0.1s
```

### Tracking
- `ally_units: Array[Unit]` - Unidades aliadas en combate
- `enemy_units: Array[Unit]` - Unidades enemigas en combate
- `attack_cooldowns: Dictionary` - Cooldowns de ataque por unidad

---

**Sistema de combate completamente funcional y listo para usar**










