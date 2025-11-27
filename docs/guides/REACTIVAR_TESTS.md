# 🔄 Cómo Reactivar los Tests

**Fecha:** Hoy  
**Estado:** Tests deshabilitados (todos pasaron ✅)

---

## 📋 Estado Actual

Los tests unitarios están **deshabilitados** porque todos pasaron correctamente (18/18 ✅).

Los archivos de tests están guardados y listos para usar cuando los necesites.

---

## 🧪 Tests Disponibles

### 1. Tests del Sistema de Oro y Tienda
- **Archivo:** `scripts/tests/ShopTests.gd`
- **Total:** 18 tests (7 oro + 5 tienda + 6 compra)
- **Estado:** ✅ Todos pasaron

### 2. Tests del Sistema Click and Drag
- **Archivo:** `scripts/Tests.gd`
- **Total:** 14 tests (bench, grid, drag and drop)
- **Estado:** ✅ Todos pasaron

### 3. Tests de Integración
- **Archivo:** `scripts/tests/IntegrationTests.gd`
- **Total:** 4 tests
- **Estado:** ✅ Todos pasaron

---

## 🚀 Cómo Reactivar los Tests

### Opción 1: Tests de Oro y Tienda

En `scripts/Board.gd`, descomenta esta línea en `_ready()`:

```gdscript
func _ready():
	# ...
	# Ejecutar tests del sistema de oro y tienda
	run_shop_tests()  # Descomentar esta línea
```

### Opción 2: Todos los Tests

En `scripts/Board.gd`, descomenta estas líneas:

```gdscript
func _ready():
	# ...
	# Ejecutar todos los tests unitarios (bench, grid y drag and drop)
	run_all_tests()
	
	# Ejecutar tests de integración
	run_integration_tests()
	
	# Ejecutar tests del sistema de oro y tienda
	run_shop_tests()
```

### Opción 3: Ejecutar Manualmente

Puedes ejecutar los tests manualmente desde código:

```gdscript
# En cualquier script
var shop_tests = ShopTests.new()
add_child(shop_tests)
```

---

## 📊 Resultados Esperados

Cuando reactives los tests, deberías ver:

```
==================================================
🧪 INICIANDO TESTS DEL SISTEMA DE ORO Y TIENDA
==================================================

[... tests ejecutándose ...]

==================================================
📊 RESUMEN DE TESTS
✅ Tests pasados: 18
❌ Tests fallados: 0
==================================================
```

---

## 🔍 Cuándo Reactivar los Tests

Recomendado reactivar cuando:
- ✅ Modifiques el sistema de oro (`GameManager.gd`)
- ✅ Modifiques el sistema de tienda (`Shop.gd`)
- ✅ Modifiques el sistema de compra
- ✅ Agregues nuevas funcionalidades relacionadas
- ✅ Antes de hacer un commit importante
- ✅ Cuando encuentres un bug y quieras verificar que está arreglado

---

## 📝 Notas

- Los tests no afectan el juego real (se ejecutan en un entorno aislado)
- Los tests limpian su estado después de ejecutarse
- Puedes ejecutar solo los tests que necesites
- Los tests están documentados en `docs/guides/GUIA_TESTS_TIENDA.md`

---

**¡Los tests están listos para cuando los necesites! 🎉**

