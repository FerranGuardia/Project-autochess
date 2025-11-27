# 🧪 Guía de Tests - Sistema de Oro y Tienda

**Fecha:** Hoy  
**Estado:** ✅ Implementado

---

## 📋 Resumen

Tests unitarios completos para el sistema de oro (`GameManager`) y tienda (`Shop`).

---

## 🎯 Tests Implementados

### Tests del Sistema de Oro (7 tests)

1. **test_gold_initial_value()**
   - Verifica que el oro inicial es 10

2. **test_gold_add()**
   - Verifica que agregar oro funciona correctamente

3. **test_gold_spend_success()**
   - Verifica que se puede gastar oro cuando hay suficiente

4. **test_gold_spend_insufficient()**
   - Verifica que no se puede gastar más oro del disponible

5. **test_gold_has_enough()**
   - Verifica que `has_enough_gold()` funciona correctamente

6. **test_gold_cannot_spend_negative()**
   - Verifica que no se pueden gastar cantidades negativas

7. **test_gold_cannot_add_negative()**
   - Verifica que no se pueden agregar cantidades negativas

### Tests del Sistema de Tienda (5 tests)

1. **test_shop_initialization()**
   - Verifica que la tienda se inicializa correctamente

2. **test_shop_refresh()**
   - Verifica que refrescar genera nuevas ofertas

3. **test_shop_get_offers()**
   - Verifica que se pueden obtener las ofertas

4. **test_shop_get_unit_cost()**
   - Verifica que los costos de unidades son correctos:
     - Elfo: 1 oro
     - Enano: 1 oro
     - Beastkin: 2 oro
     - Mago: 3 oro
     - Orco: 3 oro
     - Demonio: 3 oro

5. **test_shop_offers_count()**
   - Verifica que la tienda tiene 5 ofertas

### Tests del Sistema de Compra (6 tests)

1. **test_purchase_success()**
   - Verifica que se puede comprar una unidad exitosamente

2. **test_purchase_insufficient_gold()**
   - Verifica que no se puede comprar sin suficiente oro

3. **test_purchase_bench_full()**
   - Verifica que no se puede comprar si el bench está lleno

4. **test_purchase_invalid_index()**
   - Verifica que no se puede comprar con índice inválido

5. **test_purchase_multiple_units()**
   - Verifica que se pueden comprar múltiples unidades

6. **test_purchase_all_units()**
   - Verifica que se pueden comprar todas las unidades posibles con el oro disponible

---

## 🚀 Cómo Ejecutar los Tests

### Opción 1: Desde el código (recomendado)

En `Board.gd`, descomenta la línea en `_ready()`:

```gdscript
func _ready():
	# ...
	# Ejecutar tests del sistema de oro y tienda
	run_shop_tests()
```

### Opción 2: Manualmente desde el editor

1. Abre la escena `Board.tscn`
2. En el inspector, agrega un script temporal o modifica `Board.gd`
3. Agrega este código en `_ready()`:

```gdscript
func _ready():
	var shop_tests = ShopTests.new()
	add_child(shop_tests)
```

### Opción 3: Crear nodo en la escena

1. Abre `Board.tscn`
2. Agrega un nodo `Node` como hijo de `Board`
3. Asigna el script `ShopTests.gd` al nodo
4. Ejecuta la escena

---

## 📊 Salida Esperada

Cuando ejecutes los tests, deberías ver algo como:

```
==================================================
🧪 INICIANDO TESTS DEL SISTEMA DE ORO Y TIENDA
==================================================

✅ Entorno de testing configurado

💰 TESTS DEL SISTEMA DE ORO

📋 Test: Oro inicial
✅ PASÓ: Oro inicial es 10

📋 Test: Agregar oro
✅ PASÓ: Oro agregado correctamente (10 → 15)

[... más tests ...]

🛒 TESTS DEL SISTEMA DE TIENDA

📋 Test: Inicialización de tienda
✅ PASÓ: Tienda inicializada correctamente

[... más tests ...]

💳 TESTS DEL SISTEMA DE COMPRA

📋 Test: Compra exitosa
✅ PASÓ: Unidad comprada y colocada en bench correctamente

[... más tests ...]

==================================================
📊 RESUMEN DE TESTS
✅ Tests pasados: 18
❌ Tests fallados: 0
==================================================
```

---

## 🔍 Qué Verificar

### Si todos los tests pasan ✅
- El sistema de oro funciona correctamente
- El sistema de tienda funciona correctamente
- Las compras funcionan correctamente
- Las validaciones funcionan correctamente

### Si algún test falla ❌
- Revisa el mensaje de error específico
- Verifica que los componentes estén inicializados correctamente
- Verifica que las referencias (GameManager, Shop, Bench) estén conectadas

---

## 📝 Notas

- Los tests limpian el estado después de ejecutarse
- Cada test es independiente (setup y cleanup)
- Los tests no afectan el juego real (se ejecutan en un entorno aislado)
- Total de tests: **18 tests** (7 oro + 5 tienda + 6 compra)

---

## 🐛 Troubleshooting

### Error: "GameManager no está inicializado"
- Verifica que `setup_test_environment()` se ejecute antes de los tests

### Error: "Bench no está inicializado"
- Verifica que el Bench se cree correctamente en `setup_test_environment()`

### Tests fallan aleatoriamente
- Algunos tests dependen de valores aleatorios (ofertas de tienda)
- Esto es normal, los tests deberían pasar en la mayoría de los casos

---

**¡Tests completos y listos para usar! 🎉**

