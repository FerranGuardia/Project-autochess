## 🎯 Objetivo

Implementar sistema completo de barra de energía para todas las unidades (aliadas y enemigas) que se carga con ataques básicos y se activa cuando está llena, preparando el terreno para el futuro sistema de habilidades.

## 📝 Cambios Realizados

### Sistema de Energía (`Unit.gd`)
- ✅ Variables: `max_energy: int = 100`, `current_energy: int = 0`
- ✅ Señales: `energy_changed()`, `energy_full()`
- ✅ Funciones: `gain_energy()`, `reset_energy()`, `use_ability()` (preparado para futuro)
- ✅ Barra visual de energía debajo de la barra de vida
- ✅ Colores: Azul normal → Azul claro → Amarillo (cuando está llena)

### Integración con Combate (`CombatSystem.gd`)
- ✅ `ENERGY_PER_ATTACK = 50` (llenado en ~2 segundos)
- ✅ Cada ataque básico carga 50 de energía automáticamente
- ✅ Reset de energía al inicio de cada combate (todas las unidades empiezan en 0)
- ✅ Función `reset_all_units_energy()` llamada en `start_combat()`

### Tests Unitarios
- ✅ Nuevo archivo: `scripts/tests/EnergyTests.gd`
- ✅ 16 tests completos: sistema de energía, barra visual, integración con combate

## 🧪 Cómo Probar

1. Iniciar combate → Verificar que todas las unidades empiezan con 0 de energía
2. Observar combate → Cada ataque carga 50 de energía (barra azul se llena)
3. Después de 2 ataques → Energía llena (100), se activa habilidad, se resetea a 0
4. Nueva ronda → Todas las unidades empiezan con 0 de energía nuevamente

## ⚠️ Estado Actual

- ✅ Sistema completo funcional
- ✅ Barra visual implementada
- ✅ Integración con combate
- ✅ Tests unitarios pasando
- 🔮 Preparado para futuro sistema de habilidades

## 📊 Detalles Técnicos

- **Energía por ataque:** 50 puntos
- **Tiempo para llenar:** ~2 segundos (2 ataques)
- **Reset:** Automático al inicio de cada combate
- **Posición barra:** Y = -42 (debajo de barra de vida en Y = -50)

## 🔗 Archivos Modificados

- `scripts/Unit.gd` - Sistema de energía y barra visual
- `scripts/CombatSystem.gd` - Integración con combate
- `scripts/tests/EnergyTests.gd` - Tests unitarios (nuevo)

