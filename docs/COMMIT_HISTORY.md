# 📝 Historial de Commits

**Última actualización:** Diciembre 2024

---

## 🎮 [Sesión Actual] - Sistema de Combate Completo

**Fecha:** Diciembre 2024

### ✨ Nuevas Funcionalidades

#### Sistema de Combate
- ✅ **CombatSystem.gd** - Sistema completo de combate con movimiento automático
- ✅ Movimiento de unidades hacia objetivos durante el combate
- ✅ Detección de objetivos más cercanos
- ✅ Sistema de ataque con cooldown (1 segundo)
- ✅ Cálculo de daño: `ataque - defensa` (mínimo 1)
- ✅ Detección automática de fin de combate (victoria/derrota)
- ✅ Integración con sistema de loot

#### Sistema de Rondas Mejorado
- ✅ Temporizador de 30 segundos de preparación entre rondas
- ✅ Auto-inicio de combate después de 30 segundos
- ✅ Detección de victoria después de ronda 5
- ✅ Señal `preparation_time_changed` para UI
- ✅ Señal `victory` cuando se completa el juego

#### Sistema de Barras de Vida
- ✅ Barras de vida visuales para todas las unidades
- ✅ Sistema de salud completo (max_health, current_health)
- ✅ Actualización automática de barras
- ✅ Cambio de color según salud (verde/amarillo/rojo)
- ✅ Funciona para unidades aliadas y enemigas
- ✅ Datos de salud agregados a UnitData

#### Sistema de Resurrección
- ✅ Resurrección automática de unidades aliadas después de cada ronda
- ✅ Restauración a posiciones iniciales
- ✅ Guardado de posiciones al inicio del combate
- ✅ Límite de 10 unidades en el grid aliado
- ✅ Validación en `place_unit()`

#### Sistema de Loot
- ✅ Oro por matar enemigos:
  - Goblin Arquero: 1 oro
  - Goblin Asesino: 2 oro
  - Goblin Defensor: 3 oro
- ✅ Integración con GridEnemy y GameManager
- ✅ Otorga loot automáticamente cuando mueren enemigos

#### Tests de Enemigos
- ✅ Tests detallados para las 5 rondas de combate
- ✅ Verificación de composiciones exactas por ronda
- ✅ Tests de spawn de enemigos

### 📝 Archivos Modificados

**Nuevos:**
- `scripts/CombatSystem.gd`
- `scripts/EnemyAI.gd` - Sistema de IA para enemigos
- `scripts/EnemyData.gd` - Datos de enemigos (goblins)
- `scripts/tests/EnemyTests.gd` - Tests de enemigos
- `docs/technical/SISTEMA_COMBATE.md`
- `docs/technical/SISTEMA_BARRAS_VIDA.md`
- `docs/technical/SISTEMA_RESURRECCION.md`
- `docs/technical/SISTEMA_FASES_RONDAS.md`
- `assets/sprites/units/goblinbow_idle.png`
- `assets/sprites/units/goblindagger_idle.png`
- `assets/sprites/units/goblinshield_idle.png`

**Modificados:**
- `scripts/GameManager.gd` - Temporizador de preparación, señales de victoria
- `scripts/Unit.gd` - Sistema de salud y barras de vida
- `scripts/UnitData.gd` - Datos de salud, ataque, defensa para unidades
- `scripts/EnemyData.gd` - Valores de loot para enemigos
- `scripts/GridAlly.gd` - Sistema de resurrección, límite de 10 unidades
- `scripts/GridEnemy.gd` - Sistema de loot, función `on_enemy_died()`
- `scripts/Board.gd` - Integración de CombatSystem, guardado/restauración de posiciones
- `scripts/EnemyAI.gd` - Composiciones mejoradas de las 5 rondas
- `scripts/tests/EnemyTests.gd` - Tests detallados de composiciones
- `docs/technical/README.md` - Actualizado con nuevos sistemas

### 🎯 Estado del Proyecto

**Sistemas Completos:**
- ✅ Sistema de combate funcional
- ✅ Sistema de rondas con temporizador
- ✅ Sistema de salud y barras de vida
- ✅ Sistema de resurrección
- ✅ Sistema de loot
- ✅ 5 rondas de combate diseñadas y testeadas

**Listo para:**
- Jugar las 5 rondas completas
- Ver combate con movimiento automático
- Ver barras de vida en acción
- Recibir loot por matar enemigos
- Revivir unidades después de cada ronda

---

## Commits Anteriores

### Commit 1: Sistema de oro y tienda completo - Semana 1 MVP

**Fecha:** Diciembre 2024  
**Hash:** (ver con `git log`)

**Descripción:**
Implementación completa del sistema de oro y tienda para el MVP.

**Cambios principales:**
- ✅ Sistema de oro (`GameManager.gd`) con validaciones
- ✅ Sistema de tienda (`Shop.gd`) con ofertas aleatorias
- ✅ UI de tienda (`ShopUI.gd`) funcional
- ✅ Tests unitarios completos (18 tests, todos pasan ✅)
- ✅ Integración compra → bench
- ✅ Documentación completa
- ✅ Tests deshabilitados (listos para reactivar)

**Archivos nuevos:**
- `scripts/GameManager.gd` - Gestor del estado del juego
- `scripts/Shop.gd` - Sistema de tienda
- `scripts/ShopUI.gd` - UI de la tienda
- `scripts/tests/ShopTests.gd` - Tests unitarios (18 tests)
- `docs/guides/GUIA_TESTS_TIENDA.md` - Guía de tests
- `docs/guides/REACTIVAR_TESTS.md` - Cómo reactivar tests
- `docs/technical/SISTEMA_ORO_TIENDA.md` - Documentación técnica

**Archivos modificados:**
- `scripts/Board.gd` - Integración de GameManager y Shop
- `scripts/Bench.gd` - Método `is_bench_full()` agregado

**Estado:**
- ✅ Todos los tests pasan (18/18)
- ✅ Sistema funcional y probado
- ✅ Listo para Semana 2 del MVP

---

## Próximos Pasos (Planificado)

### Mejoras Futuras
- Animaciones de combate
- Efectos visuales de daño
- Sonidos de combate
- Mejoras de IA (priorización de objetivos)
- Sistema de habilidades especiales

---

**Nota:** Este archivo se actualiza manualmente. Para ver el historial completo, usa `git log`.
