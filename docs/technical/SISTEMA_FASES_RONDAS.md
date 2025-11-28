# 🎮 Sistema de Fases y Rondas - Implementación

**Fecha:** Hoy  
**Estado:** ✅ Implementado (Día 1-2 Semana 2)

---

## 📋 Resumen

Se ha implementado el sistema completo de fases y rondas según el roadmap de la Semana 2 del MVP.

---

## 🎯 Componentes Implementados

### 1. GameManager.gd (Expandido)
**Ubicación:** `scripts/GameManager.gd`

**Nuevas funcionalidades:**
- ✅ Sistema de fases (Preparación vs Combate)
- ✅ Señales para cambios de fase
- ✅ Métodos para iniciar/terminar combate
- ✅ Lógica de victoria/derrota

**Nuevos métodos:**
- `start_combat()` - Inicia la fase de combate
- `end_combat(victory: bool)` - Termina el combate y calcula resultado
- `get_current_phase() -> Phase` - Obtiene la fase actual
- `is_preparation_phase() -> bool` - Verifica si estamos en preparación
- `is_combat_phase() -> bool` - Verifica si estamos en combate

**Nuevas señales:**
- `phase_changed(new_phase: int)` - Se emite cuando cambia la fase
- `combat_started()` - Se emite cuando inicia el combate
- `combat_ended(victory: bool)` - Se emite cuando termina el combate

**Enum de fases:**
```gdscript
enum Phase {
	PREPARATION,  # Fase de preparación (comprar, colocar unidades)
	COMBAT        # Fase de combate
}
```

---

### 2. ShopUI.gd (Expandido)
**Ubicación:** `scripts/ShopUI.gd`

**Nuevas funcionalidades:**
- ✅ Display de ronda actual
- ✅ Display de vidas restantes
- ✅ Display de fase actual (Preparación/Combate)
- ✅ Botón para iniciar combate
- ✅ Actualización automática de UI

**Nuevos elementos de UI:**
- `round_label` - Muestra la ronda actual
- `lives_label` - Muestra las vidas restantes
- `phase_label` - Muestra la fase actual (con color)
- `start_combat_button` - Botón para iniciar combate

**Nuevos métodos:**
- `update_round_display()` - Actualiza el display de ronda
- `update_lives_display()` - Actualiza el display de vidas
- `update_phase_display()` - Actualiza el display de fase
- `_on_round_changed()` - Callback para cambios de ronda
- `_on_lives_changed()` - Callback para cambios de vidas
- `_on_phase_changed()` - Callback para cambios de fase
- `_on_start_combat_pressed()` - Callback para botón de combate

---

## 🔄 Flujo de Fases

### Fase de Preparación
1. **Estado inicial:** El juego comienza en fase de preparación
2. **Acciones permitidas:**
   - Comprar unidades de la tienda
   - Colocar unidades en el tablero
   - Mover unidades entre bench y grid
   - Refrescar tienda
3. **UI:** Botón "Iniciar Combate" habilitado

### Fase de Combate
1. **Inicio:** Jugador presiona "Iniciar Combate"
2. **Acciones:**
   - Las unidades combaten automáticamente
   - Se detecta el fin del combate
3. **Fin del combate:**
   - **Victoria:** Se inicia nueva ronda (con oro adicional)
   - **Derrota:** Se pierde una vida, se inicia nueva ronda (si hay vidas)
4. **UI:** Botón "Iniciar Combate" deshabilitado

---

## 🎮 Cómo Usar

1. **Fase de Preparación:**
   - Comprar unidades de la tienda
   - Colocar unidades en el grid aliado
   - Presionar "Iniciar Combate" cuando estés listo

2. **Fase de Combate:**
   - El combate se ejecuta automáticamente
   - Se detecta el resultado (victoria/derrota)
   - Se actualiza el estado del juego

3. **Después del Combate:**
   - Si ganaste: Nueva ronda con oro adicional
   - Si perdiste: Pierdes una vida, nueva ronda (si hay vidas)
   - Si vidas = 0: Game Over

---

## 📊 Estado Actual

### ✅ Completado
- Sistema de fases (Preparación/Combate)
- UI para mostrar ronda, vidas y fase
- Botón para iniciar combate
- Lógica de victoria/derrota
- Sistema de oro por ronda

### ⏭️ Próximos Pasos
- IA predefinida para enemigos (Día 3-4)
- Sistema de combate con movimiento (Día 5-6)
- Detectar fin de combate automáticamente
- Pantalla de game over (Día 7)

---

## 🔗 Integración

El sistema está integrado con:
- `GameManager` - Gestión del estado del juego
- `ShopUI` - UI principal del juego
- `Board` - Tablero principal (preparado para combate)

---

**¡Sistema de fases y rondas completado! ✅**

