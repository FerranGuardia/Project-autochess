# 🧪 Guía: Ejecutar Tests Unitarios

**Fecha de creación:** 26 de Diciembre 2024, 12:00 PM

---

## 📋 Cómo Ejecutar los Tests

### Opción 1: Desde el Editor de Godot

1. Abre la escena `Board.tscn`
2. Agrega un nodo `Node` como hijo de `Board`
3. Renombra el nodo a `Tests`
4. En el Inspector, carga el script `scripts/Tests.gd`
5. Ejecuta el juego (F5)
6. Los tests se ejecutarán automáticamente y verás los resultados en la consola

### Opción 2: Desde Código (Llamar Manualmente)

Puedes llamar las funciones de test desde cualquier script:

```gdscript
# En Board.gd, por ejemplo
func test_drag_drop():
    var tests = Tests.new()
    tests.test_place_unit_in_grid()
    tests.test_place_unit_in_bench()
```

---

## 📊 Tests Incluidos

### Tests del Banquillo (Bench)
1. **test_bench_place_unit()** - Verifica que se puede colocar una unidad en el banquillo
2. **test_bench_remove_unit()** - Verifica que se puede remover una unidad del banquillo
3. **test_bench_slot_occupation()** - Verifica que no se pueden colocar dos unidades en el mismo slot
4. **test_bench_get_unit_at()** - Verifica que se puede obtener una unidad de un slot específico
5. **test_bench_is_slot_occupied()** - Verifica la función de ocupación de slots
6. **test_bench_get_world_position()** - Verifica la conversión de índice de slot a posición mundial
7. **test_bench_get_slot_index()** - Verifica la conversión de posición mundial a índice de slot

### Tests del Grid
8. **test_grid_place_unit()** - Verifica que se puede colocar una unidad en el grid
9. **test_grid_cell_occupation()** - Verifica que no se pueden colocar dos unidades en la misma celda
10. **test_grid_get_unit_at()** - Verifica que se puede obtener una unidad de una celda específica
11. **test_grid_is_cell_occupied()** - Verifica la función de ocupación de celdas

### Tests de Drag and Drop
12. **test_bench_to_grid_movement()** - Verifica movimiento de banquillo a grid
13. **test_grid_to_bench_movement()** - Verifica movimiento de grid a banquillo
14. **test_invalid_drop_returns_to_original()** - Verifica que un drop inválido restaura la posición original

**Total: 14 tests** (7 del banquillo + 4 del grid + 3 de drag and drop)

---

## ✅ Interpretar los Resultados

- **✅ PASÓ:** El test funcionó correctamente
- **❌ FALLÓ:** El test encontró un problema

Al final verás un resumen con el total de tests pasados y fallados.

---

**Nota:** Los tests se ejecutan automáticamente cuando se carga el nodo Tests.


