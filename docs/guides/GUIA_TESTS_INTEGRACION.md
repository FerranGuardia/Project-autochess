# 🧪 Guía Completa: Pruebas de Integración

**Para tu proyecto AutoChess**

---

## 📋 Tabla de Contenidos

1. [¿Qué son las Pruebas de Integración?](#qué-son-las-pruebas-de-integración)
2. [Diferencia con Tests Unitarios](#diferencia-con-tests-unitarios)
3. [Cuándo Usar Tests de Integración](#cuándo-usar-tests-de-integración)
4. [Tipos de Tests de Integración](#tipos-de-tests-de-integración)
5. [Cómo Implementarlas en tu Proyecto](#cómo-implementarlas-en-tu-proyecto)
6. [Ejemplos Prácticos para AutoChess](#ejemplos-prácticos-para-autochess)
7. [Estrategia de Testing Completa](#estrategia-de-testing-completa)

---

## 🔍 ¿Qué son las Pruebas de Integración?

### Definición

Las **pruebas de integración** verifican que **múltiples componentes del sistema funcionen correctamente juntos**. A diferencia de los tests unitarios que prueban componentes individuales aislados, los tests de integración prueban la **interacción entre componentes**.

### Analogía Simple

**Tests Unitarios:**
- Verifican que cada pieza de un motor funcione individualmente
- "¿El pistón se mueve correctamente?"
- "¿La válvula abre y cierra bien?"

**Tests de Integración:**
- Verifican que las piezas trabajen juntas
- "¿El pistón y la válvula funcionan juntos correctamente?"
- "¿Todo el motor arranca y funciona?"

### En tu Proyecto AutoChess

**Tests Unitarios (que ya tienes):**
```gdscript
# Prueba que Bench.place_unit() funciona
func test_bench_place_unit():
    var unit = Unit.new()
    var success = bench.place_unit(unit, 0)
    assert(success, "Debería colocar unidad")
```

**Tests de Integración (lo que necesitas):**
```gdscript
# Prueba que el flujo completo Bench → Grid funciona
func test_complete_bench_to_grid_flow():
    # 1. Crear unidad
    # 2. Colocar en bench
    # 3. Mover a grid
    # 4. Verificar que está en grid
    # 5. Verificar que NO está en bench
    # 6. Verificar que puede atacar desde grid
```

---

## ⚖️ Diferencia con Tests Unitarios

### Comparación Visual

| Aspecto | Tests Unitarios | Tests de Integración |
|---------|----------------|---------------------|
| **Alcance** | Un componente | Múltiples componentes |
| **Aislamiento** | Total (mocks/stubs) | Parcial (componentes reales) |
| **Velocidad** | Muy rápidos | Más lentos |
| **Propósito** | Verificar lógica individual | Verificar interacción |
| **Cuándo fallan** | Bug en un componente | Bug en la integración |
| **Mantenimiento** | Fácil | Más complejo |

### Ejemplo Concreto

**Test Unitario:**
```gdscript
# Solo prueba Bench aislado
func test_bench_place_unit():
    var bench = Bench.new()
    var unit = Unit.new()
    bench.place_unit(unit, 0)
    assert(bench.get_unit_at(0) == unit)
```

**Test de Integración:**
```gdscript
# Prueba Bench + Board + Grid trabajando juntos
func test_bench_board_grid_integration():
    var board = Board.new()
    var unit = Unit.new()
    
    # Colocar en bench (usa Board.bench)
    board.bench.place_unit(unit, 0)
    
    # Mover a grid (usa Board.handle_unit_drop)
    var grid_pos = board.grid_ally.get_world_position(3, 2)
    board.handle_unit_drop(unit, grid_pos)
    
    # Verificar integración completa
    assert(board.grid_ally.get_unit_at(3, 2) == unit)
    assert(board.bench.get_unit_at(0) == null)
```

---

## 🎯 Cuándo Usar Tests de Integración

### ✅ Usa Tests de Integración Cuando:

1. **Múltiples Sistemas Interactúan**
   ```
   Ejemplo: Bench → Grid → Combate
   - Unidad se mueve del bench al grid
   - Unidad en grid puede atacar
   - Sistema de combate funciona con unidades del grid
   ```

2. **Flujos Completos de Usuario**
   ```
   Ejemplo: Compra → Bench → Grid → Combate
   - Jugador compra unidad
   - Unidad va al bench
   - Jugador mueve unidad al grid
   - Combate inicia
   - Unidad ataca
   ```

3. **Comunicación Entre Componentes**
   ```
   Ejemplo: Señales entre sistemas
   - Bench emite señal cuando se coloca unidad
   - Board escucha y actualiza UI
   - UI muestra unidad en bench
   ```

4. **Persistencia de Estado**
   ```
   Ejemplo: Estado compartido
   - Unidad en bench tiene stats
   - Al mover a grid, stats se mantienen
   - Al combinar unidades, stats se calculan correctamente
   ```

5. **Casos de Uso Reales**
   ```
   Ejemplo: Escenarios completos
   - Ronda completa: compra → colocación → combate → resultado
   - Combinación de unidades: 3 unidades → 1 unidad mejorada
   ```

### ❌ NO Uses Tests de Integración Para:

1. **Lógica Simple Individual**
   - Si solo pruebas una función, usa test unitario

2. **Cálculos Matemáticos**
   - `calculate_damage()` → Test unitario

3. **Validaciones Básicas**
   - `is_valid_position()` → Test unitario

4. **Cuando los Tests Unitarios Son Suficientes**
   - Si el componente es independiente, no necesitas integración

---

## 📦 Tipos de Tests de Integración

### 1. Tests de Integración de Componentes

**Prueban que 2-3 componentes trabajen juntos**

```gdscript
# Bench + Grid
func test_bench_grid_integration():
    # Prueba que mover unidad entre bench y grid funciona
    pass

# Grid + Combat System
func test_grid_combat_integration():
    # Prueba que unidades en grid pueden combatir
    pass
```

### 2. Tests de Integración de Sistemas

**Prueban que sistemas completos funcionen juntos**

```gdscript
# Shop + Bench + Grid + Combat
func test_complete_game_round():
    # 1. Comprar unidad
    # 2. Colocar en bench
    # 3. Mover a grid
    # 4. Iniciar combate
    # 5. Verificar resultado
    pass
```

### 3. Tests de Flujo End-to-End

**Prueban escenarios completos de usuario**

```gdscript
# Flujo completo de una ronda
func test_complete_round_flow():
    # Setup: jugador tiene oro
    # 1. Tienda muestra ofertas
    # 2. Jugador compra unidad
    # 3. Unidad aparece en bench
    # 4. Jugador mueve unidad a grid
    # 5. Ronda inicia
    # 6. Combate ocurre
    # 7. Resultado se muestra
    pass
```

### 4. Tests de Integración de Datos

**Prueban que datos fluyan correctamente entre sistemas**

```gdscript
# Stats de unidad se mantienen al mover
func test_unit_stats_persistence():
    var unit = Unit.new()
    unit.attack = 50
    unit.health = 100
    
    bench.place_unit(unit, 0)
    assert(unit.attack == 50)  # Stats se mantienen
    
    grid.place_unit(unit, 3, 2)
    assert(unit.attack == 50)  # Stats se mantienen
```

---

## 🛠️ Cómo Implementarlas en tu Proyecto

### Estructura de Archivos

```
scripts/
├── tests/
│   ├── unit/                    # Tests unitarios (ya tienes)
│   │   └── Tests.gd
│   │
│   └── integration/            # Tests de integración (nuevo)
│       ├── IntegrationTests.gd
│       ├── BenchGridTests.gd
│       ├── CombatTests.gd
│       └── GameFlowTests.gd
```

### Patrón Básico de Test de Integración

```gdscript
extends Node
class_name IntegrationTests

var tests_passed: int = 0
var tests_failed: int = 0

func _ready():
    print("==================================================")
    print("🧪 INICIANDO TESTS DE INTEGRACIÓN")
    print("==================================================")
    
    run_all_integration_tests()
    
    print("==================================================")
    print("📊 RESUMEN DE TESTS DE INTEGRACIÓN")
    print("✅ Tests pasados: ", tests_passed)
    print("❌ Tests fallados: ", tests_failed)
    print("==================================================")

func run_all_integration_tests():
    test_bench_grid_integration()
    test_combat_system_integration()
    test_complete_round_flow()
    # ... más tests
```

### Setup y Teardown

```gdscript
var board: Board
var bench: Bench
var grid_ally: GridAlly

func setup_test_environment():
    """Prepara el entorno para cada test"""
    board = Board.new()
    add_child(board)
    bench = board.bench
    grid_ally = board.grid_ally
    
    # Esperar un frame para que todo se inicialice
    await get_tree().process_frame

func teardown_test_environment():
    """Limpia después de cada test"""
    if board:
        board.queue_free()
    board = null
    bench = null
    grid_ally = null
```

---

## 🎮 Ejemplos Prácticos para AutoChess

### Ejemplo 1: Integración Bench ↔ Grid

```gdscript
func test_bench_grid_complete_flow():
    """Test: Flujo completo de mover unidad entre bench y grid"""
    print("\n📋 Test: Integración Bench ↔ Grid")
    
    setup_test_environment()
    
    # Crear unidad
    var unit = Unit.new()
    unit.initialize(UnitData.UnitType.MAGO)
    
    # Paso 1: Colocar en bench
    var bench_success = bench.place_unit(unit, 0)
    assert(bench_success, "Debería poder colocar en bench")
    assert(bench.get_unit_at(0) == unit, "Unidad debería estar en bench")
    
    # Paso 2: Mover a grid usando Board (integración real)
    var grid_world_pos = grid_ally.get_world_position(3, 2)
    var drop_success = board.handle_unit_drop(unit, grid_world_pos)
    
    # Paso 3: Verificar integración completa
    assert(drop_success, "Drop debería ser exitoso")
    assert(grid_ally.get_unit_at(3, 2) == unit, "Unidad debería estar en grid")
    assert(bench.get_unit_at(0) == null, "Unidad NO debería estar en bench")
    
    # Paso 4: Verificar que unidad puede hacer cosas en grid
    assert(unit.is_placed(), "Unidad debería estar colocada")
    var grid_pos = unit.get_grid_position()
    assert(grid_pos.x == 3 and grid_pos.y == 2, "Posición de grid correcta")
    
    print("✅ PASÓ: Integración Bench ↔ Grid funciona correctamente")
    tests_passed += 1
    
    teardown_test_environment()
```

### Ejemplo 2: Integración Shop → Bench

```gdscript
func test_shop_to_bench_integration():
    """Test: Comprar unidad y que aparezca en bench"""
    print("\n📋 Test: Integración Shop → Bench")
    
    setup_test_environment()
    
    # Setup: Crear shop y dar oro al jugador
    var shop = Shop.new()
    var player_gold = 100
    shop.generate_offers()
    
    # Paso 1: Comprar unidad (integración Shop → Bench)
    var offer = shop.offers[0]
    var purchase_success = shop.purchase_unit(offer, player_gold)
    
    assert(purchase_success.success, "Compra debería ser exitosa")
    
    # Paso 2: Verificar que unidad está en bench
    var purchased_unit = purchase_success.unit
    var bench_slot = find_empty_bench_slot()
    
    bench.place_unit(purchased_unit, bench_slot)
    assert(bench.get_unit_at(bench_slot) == purchased_unit, 
           "Unidad comprada debería estar en bench")
    
    # Paso 3: Verificar que oro se descontó
    var new_gold = player_gold - offer.cost
    assert(new_gold == purchase_success.remaining_gold, 
           "Oro debería descontarse correctamente")
    
    print("✅ PASÓ: Integración Shop → Bench funciona correctamente")
    tests_passed += 1
    
    teardown_test_environment()
```

### Ejemplo 3: Integración Grid → Combat

```gdscript
func test_grid_combat_integration():
    """Test: Unidades en grid pueden combatir"""
    print("\n📋 Test: Integración Grid → Combat")
    
    setup_test_environment()
    
    # Paso 1: Colocar unidades aliadas en grid
    var ally1 = Unit.new()
    ally1.initialize(UnitData.UnitType.MAGO)
    grid_ally.place_unit(ally1, 3, 2)
    
    var ally2 = Unit.new()
    ally2.initialize(UnitData.UnitType.ORCO)
    grid_ally.place_unit(ally2, 4, 2)
    
    # Paso 2: Colocar unidades enemigas (grid enemigo)
    var enemy1 = Unit.new()
    enemy1.initialize(UnitData.UnitType.ELFO)
    grid_enemy.place_unit(enemy1, 3, 0)
    
    # Paso 3: Iniciar combate (integración)
    board.start_combat()
    
    # Paso 4: Verificar que unidades encuentran objetivos
    await get_tree().create_timer(0.5).timeout  # Esperar un poco
    
    var target1 = ally1.find_target()
    assert(target1 != null, "Unidad aliada debería encontrar objetivo")
    
    # Paso 5: Verificar que pueden atacar
    var initial_enemy_health = enemy1.health
    ally1.attack_target(target1)
    
    await get_tree().create_timer(0.1).timeout
    assert(enemy1.health < initial_enemy_health, 
           "Enemigo debería recibir daño")
    
    print("✅ PASÓ: Integración Grid → Combat funciona correctamente")
    tests_passed += 1
    
    teardown_test_environment()
```

### Ejemplo 4: Flujo Completo de Ronda

```gdscript
func test_complete_round_flow():
    """Test: Flujo completo de una ronda de juego"""
    print("\n📋 Test: Flujo Completo de Ronda")
    
    setup_test_environment()
    
    # Setup inicial
    var player_gold = 50
    var shop = Shop.new()
    shop.generate_offers()
    
    # FASE 1: PREPARACIÓN
    # Paso 1: Comprar unidad
    var offer = shop.offers[0]
    var purchase = shop.purchase_unit(offer, player_gold)
    assert(purchase.success, "Debería poder comprar")
    
    # Paso 2: Unidad va a bench
    var unit = purchase.unit
    var bench_slot = find_empty_bench_slot()
    bench.place_unit(unit, bench_slot)
    assert(bench.get_unit_at(bench_slot) == unit, 
           "Unidad debería estar en bench")
    
    # Paso 3: Mover unidad a grid
    var grid_pos = grid_ally.get_world_position(3, 2)
    board.handle_unit_drop(unit, grid_pos)
    assert(grid_ally.get_unit_at(3, 2) == unit, 
           "Unidad debería estar en grid")
    
    # FASE 2: COMBATE
    # Paso 4: Iniciar combate
    board.start_combat()
    assert(board.current_phase == Phase.COMBAT, 
           "Fase debería ser COMBAT")
    
    # Paso 5: Esperar que combate ocurra
    await get_tree().create_timer(2.0).timeout
    
    # Paso 6: Verificar que combate terminó
    var combat_ended = board.check_combat_end()
    # (combat_ended puede ser true o false dependiendo del resultado)
    
    # FASE 3: POST-COMBATE
    # Paso 7: Verificar transición a fase de preparación
    if combat_ended:
        board.end_combat()
        assert(board.current_phase == Phase.PREPARATION, 
               "Debería volver a PREPARATION")
    
    print("✅ PASÓ: Flujo completo de ronda funciona")
    tests_passed += 1
    
    teardown_test_environment()
```

### Ejemplo 5: Integración de Señales

```gdscript
func test_signal_integration():
    """Test: Señales entre sistemas funcionan correctamente"""
    print("\n📋 Test: Integración de Señales")
    
    setup_test_environment()
    
    var signal_received = false
    var received_unit = null
    
    # Conectar señal de bench
    bench.unit_placed.connect(func(unit: Unit, slot: int):
        signal_received = true
        received_unit = unit
    )
    
    # Paso 1: Colocar unidad (debería emitir señal)
    var unit = Unit.new()
    unit.initialize(UnitData.UnitType.MAGO)
    bench.place_unit(unit, 0)
    
    # Esperar un frame para que señales se procesen
    await get_tree().process_frame
    
    # Paso 2: Verificar que señal se recibió
    assert(signal_received, "Señal debería haberse emitido")
    assert(received_unit == unit, "Señal debería contener unidad correcta")
    
    print("✅ PASÓ: Integración de señales funciona correctamente")
    tests_passed += 1
    
    teardown_test_environment()
```

### Ejemplo 6: Integración de Combinación de Unidades

```gdscript
func test_unit_combination_integration():
    """Test: Combinar 3 unidades funciona en bench y grid"""
    print("\n📋 Test: Integración de Combinación de Unidades")
    
    setup_test_environment()
    
    # Paso 1: Colocar 3 unidades del mismo tipo en bench
    var unit1 = Unit.new()
    unit1.initialize(UnitData.UnitType.MAGO)
    bench.place_unit(unit1, 0)
    
    var unit2 = Unit.new()
    unit2.initialize(UnitData.UnitType.MAGO)
    bench.place_unit(unit2, 1)
    
    var unit3 = Unit.new()
    unit3.initialize(UnitData.UnitType.MAGO)
    bench.place_unit(unit3, 2)
    
    # Paso 2: Sistema debería detectar y combinar
    var combination_system = CombinationSystem.new()
    var result = combination_system.check_and_combine(bench.units.values())
    
    # Paso 3: Verificar que se creó unidad mejorada
    assert(result.combined, "Debería combinar 3 unidades")
    assert(result.new_unit.star_level == 2, 
           "Unidad combinada debería ser 2 estrellas")
    
    # Paso 4: Verificar que unidades originales se removieron
    assert(bench.get_unit_at(0) == null, 
           "Unidad original debería removerse")
    assert(bench.get_unit_at(1) == null, 
           "Unidad original debería removerse")
    assert(bench.get_unit_at(2) == null, 
           "Unidad original debería removerse")
    
    # Paso 5: Verificar que unidad mejorada está en bench
    var combined_unit = result.new_unit
    bench.place_unit(combined_unit, 0)
    assert(bench.get_unit_at(0) == combined_unit, 
           "Unidad combinada debería estar en bench")
    
    print("✅ PASÓ: Integración de combinación funciona correctamente")
    tests_passed += 1
    
    teardown_test_environment()
```

---

## 📊 Estrategia de Testing Completa

### Pirámide de Testing

```
        /\
       /  \      Tests End-to-End (pocos)
      /____\
     /      \    Tests de Integración (algunos)
    /________\
   /          \  Tests Unitarios (muchos)
  /____________\
```

### Distribución Recomendada

**Para tu proyecto AutoChess:**

1. **Tests Unitarios (70%)**
   - Bench.place_unit()
   - Grid.place_unit()
   - Unit.calculate_damage()
   - CombatSystem.find_target()
   - etc.

2. **Tests de Integración (25%)**
   - Bench ↔ Grid
   - Shop → Bench
   - Grid → Combat
   - Combinación de unidades
   - Flujos de ronda

3. **Tests End-to-End (5%)**
   - Ronda completa
   - Partida completa (si aplica)
   - Flujos de usuario completos

### Cuándo Escribir Cada Tipo

**Tests Unitarios:**
- ✅ Siempre que creas una función nueva
- ✅ Cuando arreglas un bug
- ✅ Cuando refactorizas

**Tests de Integración:**
- ✅ Cuando conectas 2 sistemas
- ✅ Cuando implementas un flujo completo
- ✅ Antes de hacer cambios grandes

**Tests End-to-End:**
- ✅ Para features críticas
- ✅ Antes de releases importantes
- ✅ Para regresiones importantes

---

## 🎯 Plan de Implementación para tu Proyecto

### Fase 1: Tests de Integración Básicos (Ahora)

**Prioridad Alta:**
1. ✅ Bench ↔ Grid (ya parcialmente cubierto)
2. ⬜ Shop → Bench (cuando implementes shop)
3. ⬜ Grid → Combat (cuando implementes combate completo)

### Fase 2: Tests de Integración Avanzados

**Cuando tengas más sistemas:**
1. ⬜ Combinación de unidades
2. ⬜ Sistema de niveles/estrellas
3. ⬜ Sistema de sinergias
4. ⬜ Sistema de items

### Fase 3: Tests End-to-End

**Cuando el juego esté más completo:**
1. ⬜ Ronda completa
2. ⬜ Partida completa (si aplica)
3. ⬜ Flujos de usuario críticos

---

## 💡 Mejores Prácticas

### 1. Setup y Teardown Claros

```gdscript
func setup_test_environment():
    # Crea entorno limpio para cada test
    pass

func teardown_test_environment():
    # Limpia después de cada test
    pass
```

### 2. Tests Independientes

```gdscript
# ❌ MAL: Test depende de otro
func test_2():
    # Asume que test_1() ya corrió
    pass

# ✅ BIEN: Cada test es independiente
func test_2():
    setup_test_environment()
    # Hace su propio setup
    pass
```

### 3. Nombres Descriptivos

```gdscript
# ❌ MAL
func test_1():
    pass

# ✅ BIEN
func test_bench_to_grid_moves_unit_and_removes_from_bench():
    pass
```

### 4. Un Test, Un Flujo

```gdscript
# ❌ MAL: Test hace muchas cosas
func test_everything():
    test_bench()
    test_grid()
    test_combat()

# ✅ BIEN: Un test, un flujo
func test_bench_to_grid_flow():
    # Solo prueba bench → grid
    pass
```

### 5. Verificaciones Múltiples

```gdscript
# ✅ BIEN: Verifica múltiples aspectos
func test_complete_flow():
    # Verifica que unidad se mueve
    assert(grid.get_unit_at(3, 2) == unit)
    # Verifica que se remueve del origen
    assert(bench.get_unit_at(0) == null)
    # Verifica que stats se mantienen
    assert(unit.health == 100)
    # Verifica que puede hacer cosas en nuevo lugar
    assert(unit.can_attack())
```

---

## 🚀 Siguiente Paso

**Recomendación inmediata:**

1. Crea carpeta `scripts/tests/integration/`
2. Crea archivo `IntegrationTests.gd`
3. Implementa estos tests primero:
   - `test_bench_grid_complete_flow()` (mejorar el que ya tienes)
   - `test_grid_combat_integration()` (cuando tengas combate)
   - `test_signal_integration()` (verificar señales)

**Ejecuta tests de integración:**
- Después de tests unitarios
- Antes de probar manualmente
- En CI/CD si lo tienes configurado

---

**¡Ahora tienes una guía completa para implementar tests de integración en tu proyecto! 🎮**

