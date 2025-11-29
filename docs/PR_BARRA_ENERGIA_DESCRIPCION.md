# ⚡ Sistema de Barra de Energía - Pull Request

## 🎯 Objetivo

Implementar un sistema completo de barra de energía para todas las unidades (aliadas y enemigas) que se carga con ataques básicos y se activa cuando está llena, preparando el terreno para el futuro sistema de habilidades.

---

## 📝 Cambios Realizados

### ✅ Sistema de Energía en Unit.gd

**Nuevas variables:**
- `max_energy: int = 100` - Energía máxima (configurable por unidad en el futuro)
- `current_energy: int = 0` - Energía actual (inicia en 0)

**Nuevas señales:**
- `energy_changed(current_energy, max_energy)` - Se emite cuando cambia la energía
- `energy_full(unit)` - Se emite cuando la energía llega a 100

**Nuevas funciones:**
- `get_energy()` / `get_max_energy()` - Getters para energía
- `gain_energy(amount)` - Aumenta energía y verifica si está llena
- `reset_energy()` - Resetea energía a 0 (usado después de habilidades)
- `on_energy_full()` - Se llama automáticamente cuando llega a 100
- `use_ability()` - Preparado para futuras habilidades (por ahora solo resetea)

### ✅ Barra Visual de Energía

**Características:**
- Barra visual posicionada debajo de la barra de vida (Y: -42)
- Mismo tamaño y estilo que la barra de vida (60x6px)
- Color azul que cambia a amarillo cuando está llena
- Se actualiza automáticamente cuando cambia la energía

**Funciones:**
- `create_energy_bar()` - Crea la barra visual de energía
- `update_energy_bar()` - Actualiza el ancho y color según la energía

### ✅ Integración con Sistema de Combate

**CombatSystem.gd:**
- `ENERGY_PER_ATTACK: int = 50` - Energía ganada por ataque (llenado en ~2 segundos)
- Cada ataque básico carga 50 de energía automáticamente
- Nueva función `reset_all_units_energy()` - Resetea energía al inicio de cada combate
- Se llama automáticamente en `start_combat()` después de recopilar unidades

**Comportamiento:**
- Todas las unidades (aliadas y enemigas) empiezan cada ronda con 0 de energía
- Cada ataque básico (melee o rango) carga 50 de energía
- La energía se llena en aproximadamente 2 segundos (2 ataques)
- Cuando la energía llega a 100, se activa la habilidad y se resetea a 0

### ✅ Tests Unitarios

**Nuevo archivo: `scripts/tests/EnergyTests.gd`**

**Tests implementados (16 tests total):**

**Sistema de Energía (8 tests):**
- ✅ Inicialización de energía
- ✅ Valores por defecto
- ✅ Ganar energía
- ✅ Límite máximo (no excede 100)
- ✅ Energía negativa (ignorada)
- ✅ Resetear energía
- ✅ Obtener energía actual
- ✅ Obtener energía máxima

**Barra Visual (4 tests):**
- ✅ Creación de barra
- ✅ Posicionamiento correcto
- ✅ Actualización de ancho
- ✅ Cambio de colores

**Integración con Combate (4 tests):**
- ✅ Carga de energía por ataque
- ✅ Reset de energía al inicio de combate
- ✅ Señal energy_full cuando está llena
- ✅ Reset después de usar habilidad

---

## 🧪 Cómo Probar

1. **Iniciar una ronda de combate**
   - Verificar que todas las unidades empiezan con 0 de energía (barra vacía)

2. **Observar carga de energía**
   - Durante el combate, cada ataque carga 50 de energía
   - La barra azul se llena progresivamente
   - Después de 2 ataques, la energía debería estar llena (100)

3. **Verificar activación de habilidad**
   - Cuando la energía llega a 100, se activa la habilidad
   - La barra cambia a color amarillo
   - Se imprime en consola: "[Nombre] usa su habilidad especial! (preparado para futuro)"
   - La energía se resetea a 0 automáticamente

4. **Verificar reset entre rondas**
   - Al iniciar una nueva ronda, todas las unidades deben empezar con 0 de energía

5. **Ejecutar tests**
   - Ejecutar `EnergyTests.gd` para verificar que todos los tests pasan

---

## ⚠️ Estado Actual

### ✅ Completado
- ✅ Sistema de energía completo (variables, funciones, señales)
- ✅ Barra visual de energía funcional
- ✅ Integración con sistema de combate
- ✅ Carga de energía por ataque (50 por ataque)
- ✅ Reset de energía al inicio de cada combate
- ✅ Activación automática cuando está llena
- ✅ Tests unitarios completos (16 tests)

### 🔮 Preparado para Futuro
- ⏳ Sistema de habilidades (función `use_ability()` lista para implementar)
- ⏳ Energía configurable por tipo de unidad (variable `max_energy` preparada)
- ⏳ Señal `energy_full` lista para conectar con sistema de habilidades

---

## 📊 Detalles Técnicos

### Cálculo de Energía
- **Energía por ataque:** 50 puntos
- **Tiempo de cooldown:** 1.0 segundo
- **Tiempo para llenar:** ~2 segundos (2 ataques × 50 = 100)
- **Configurable:** `ENERGY_PER_ATTACK` en `CombatSystem.gd`

### Posicionamiento Visual
- **Barra de vida:** Y = -50 (debajo del sprite)
- **Barra de energía:** Y = -42 (8px debajo de la barra de vida)
- **Tamaño:** 60x6px (fondo), 58x4px (relleno)

### Colores de Energía
- **Normal (<80%):** Azul `Color(0.2, 0.6, 0.9)`
- **Casi llena (80-99%):** Azul claro `Color(0.4, 0.7, 0.9)`
- **Llena (100%):** Amarillo `Color(0.9, 0.9, 0.2)`

---

## 🔗 Archivos Modificados

### Archivos Modificados
- `scripts/Unit.gd` - Sistema completo de energía y barra visual
- `scripts/CombatSystem.gd` - Integración con combate y reset al inicio

### Archivos Nuevos
- `scripts/tests/EnergyTests.gd` - Tests unitarios completos

---

## 📸 Capturas

*[Agregar capturas de pantalla si es necesario]*

---

## 🎓 Notas de Implementación

- El sistema está diseñado para ser extensible: la función `use_ability()` está lista para implementar habilidades específicas
- La señal `energy_full` permite que otros sistemas reaccionen cuando la energía está llena
- El reset automático al inicio de cada combate asegura que todas las unidades empiecen en igualdad de condiciones
- Los tests cubren todos los casos importantes y aseguran que el sistema funciona correctamente

---

## ✅ Checklist

- [x] Código funciona correctamente
- [x] No hay errores de compilación
- [x] Tests unitarios pasan (16/16)
- [x] Sistema integrado con combate
- [x] Barra visual funcional
- [x] Reset de energía al inicio de combate
- [x] Documentación en código
- [x] Preparado para futuro sistema de habilidades

---

**Branch:** `feature/barra-energia`  
**Estado:** ✅ Listo para revisión y merge

