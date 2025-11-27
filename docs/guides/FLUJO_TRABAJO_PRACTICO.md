# 🔄 Flujo de Trabajo Práctico - Desarrollo de Videojuegos

**Guía paso a paso para trabajar eficientemente**

---

## 📅 Flujo Semanal Recomendado

### Lunes: Planificación y Setup

**Mañana (2-3 horas)**
1. Revisar progreso de la semana anterior
2. Actualizar roadmap/progreso
3. Planificar objetivos de la semana
4. Identificar tareas y priorizarlas

**Tarde (4-5 horas)**
5. Setup del entorno de trabajo
6. Revisar código pendiente
7. Empezar con la tarea más importante

### Martes a Jueves: Desarrollo Intensivo

**Rutina Diaria:**
```
09:00 - 10:00  → Revisión y planificación del día
10:00 - 12:00  → Desarrollo (código nuevo)
12:00 - 13:00  → Descanso
13:00 - 15:00  → Desarrollo (integración)
15:00 - 16:00  → Testing y debugging
16:00 - 17:00  → Refactorización y limpieza
17:00 - 17:30  → Commit y documentación
```

### Viernes: Integración y Revisión

**Mañana**
- Integrar todas las features de la semana
- Testing completo del sistema
- Arreglar bugs encontrados

**Tarde**
- Revisión de código
- Documentación de cambios
- Preparar demo/build para probar
- Planificar siguiente semana

---

## 🎯 Flujo para Implementar una Feature Nueva

### Paso 1: Análisis y Diseño (30 min - 1 hora)

**Preguntas a responder:**
- ¿Qué necesito implementar exactamente?
- ¿Qué sistemas ya existen que puedo usar?
- ¿Qué necesito crear desde cero?
- ¿Hay dependencias con otras features?

**Documentar:**
```markdown
## Feature: Sistema de Inventario

### Objetivo
Permitir que el jugador almacene y gestione items.

### Componentes Necesarios
- [ ] Clase Inventory
- [ ] UI de inventario
- [ ] Sistema de items
- [ ] Drag and drop de items

### Dependencias
- Sistema de UI existente
- Sistema de items (crear)

### Estimación
2-3 días
```

### Paso 2: Crear Estructura Base (1-2 horas)

**Orden recomendado:**
1. Crear clases base (data structures)
2. Crear interfaces/señales necesarias
3. Crear estructura de archivos
4. Escribir stubs de funciones principales

**Ejemplo:**
```gdscript
# scripts/inventory/Inventory.gd
class_name Inventory
extends Node

signal item_added(item: Item)
signal item_removed(item: Item)

var items: Array[Item] = []
var max_size: int = 20

func add_item(item: Item) -> bool:
    # TODO: Implementar
    pass

func remove_item(item: Item) -> bool:
    # TODO: Implementar
    pass
```

### Paso 3: Implementar Funcionalidad Core (2-4 horas)

**Enfoque:**
- Implementar una función a la vez
- Probar cada función inmediatamente
- No preocuparse por edge cases todavía

**Ejemplo:**
```gdscript
func add_item(item: Item) -> bool:
    if items.size() >= max_size:
        return false
    
    items.append(item)
    item_added.emit(item)
    return true

# Probar inmediatamente
func _ready():
    var test_item = Item.new()
    assert(add_item(test_item), "Debería poder agregar item")
    assert(items.size() == 1, "Debería tener 1 item")
```

### Paso 4: Manejar Edge Cases (1-2 horas)

**Considerar:**
- ¿Qué pasa si el inventario está lleno?
- ¿Qué pasa si intento agregar el mismo item dos veces?
- ¿Qué pasa con valores null/inválidos?

```gdscript
func add_item(item: Item) -> bool:
    if not item:
        print("Error: Item es null")
        return false
    
    if items.size() >= max_size:
        print("Error: Inventario lleno")
        return false
    
    if items.has(item):
        print("Error: Item ya existe")
        return false
    
    items.append(item)
    item_added.emit(item)
    return true
```

### Paso 5: Integrar con Otros Sistemas (1-2 horas)

**Verificar:**
- ¿Funciona con el sistema de UI?
- ¿Se comunica correctamente con otros sistemas?
- ¿Las señales se conectan correctamente?

### Paso 6: Testing Completo (1 hora)

**Crear tests:**
```gdscript
# scripts/tests/InventoryTests.gd
func test_add_item():
    var inventory = Inventory.new()
    var item = Item.new()
    assert(inventory.add_item(item), "Debería agregar item")
    assert(inventory.items.size() == 1, "Debería tener 1 item")

func test_inventory_full():
    var inventory = Inventory.new()
    inventory.max_size = 2
    inventory.add_item(Item.new())
    inventory.add_item(Item.new())
    assert(not inventory.add_item(Item.new()), "No debería agregar si está lleno")
```

### Paso 7: Refactorización (30 min - 1 hora)

**Revisar:**
- ¿El código es legible?
- ¿Hay duplicación?
- ¿Puedo mejorar la estructura?

### Paso 8: Documentación (30 min)

**Documentar:**
- Cómo usar la feature
- Decisiones importantes
- APIs públicas

---

## 🐛 Flujo para Arreglar un Bug

### Paso 1: Reproducir el Bug (15 min)

**Importante:**
- ¿Puedo reproducirlo consistentemente?
- ¿Qué pasos específicos lo causan?
- ¿En qué condiciones ocurre?

**Documentar:**
```
Bug: Unidad desaparece al moverla del bench al grid

Pasos para reproducir:
1. Colocar unidad en bench slot 0
2. Arrastrar unidad al grid (3, 2)
3. Unidad desaparece

Condiciones:
- Solo ocurre cuando el grid está casi lleno
- Ocurre en 80% de los casos
```

### Paso 2: Identificar la Causa (30 min - 1 hora)

**Estrategias:**
- Revisar logs/consola
- Agregar prints de debug
- Usar debugger/breakpoints
- Revisar código relacionado

**Ejemplo:**
```gdscript
func handle_unit_drop(unit: Unit, pos: Vector2) -> bool:
    print("DEBUG: handle_unit_drop llamado")
    print("DEBUG: unit = ", unit)
    print("DEBUG: pos = ", pos)
    
    remove_unit_from_previous_position(unit)
    print("DEBUG: Después de remove_unit_from_previous_position")
    
    # ... resto del código
```

### Paso 3: Crear Fix (30 min - 1 hora)

**Enfoque:**
- Fix mínimo que resuelve el problema
- No refactorizar todo (eso es otro ticket)
- Asegurarse de no romper otras cosas

### Paso 4: Verificar el Fix (15 min)

**Checklist:**
- [ ] ¿El bug está arreglado?
- [ ] ¿No rompí otras funcionalidades?
- [ ] ¿Los tests pasan?
- [ ] ¿El código sigue siendo legible?

### Paso 5: Agregar Test (15 min)

**Prevenir regresiones:**
```gdscript
func test_unit_movement_bench_to_grid():
    # Test que reproduce el bug original
    var unit = Unit.new()
    bench.place_unit(unit, 0)
    
    # Llenar grid casi completamente
    for i in range(30):
        var u = Unit.new()
        grid.place_unit(u, i % 7, i / 7)
    
    # Intentar mover
    var success = board.handle_unit_drop(unit, grid.get_world_position(3, 2))
    assert(success, "Debería poder mover")
    assert(grid.get_unit_at(3, 2) == unit, "Unidad debería estar en grid")
```

---

## 🔄 Flujo de Refactorización

### Cuándo Refactorizar

**Señales de que necesitas refactorizar:**
- Código duplicado en múltiples lugares
- Funciones muy largas (>50 líneas)
- Clases con demasiadas responsabilidades
- Código difícil de entender
- Cambios pequeños requieren tocar muchos archivos

### Cómo Refactorizar Seguro

**Paso 1: Asegurar Tests (30 min)**
- Crear tests antes de refactorizar
- Asegurarse de que pasan
- Estos tests validarán que no rompiste nada

**Paso 2: Refactorizar en Pasos Pequeños (1-2 horas)**
- Un cambio a la vez
- Commit después de cada cambio
- Verificar que tests siguen pasando

**Paso 3: Verificar Funcionalidad (30 min)**
- Probar manualmente
- Ejecutar todos los tests
- Verificar que nada se rompió

**Ejemplo de Refactorización:**

```gdscript
# ANTES: Código duplicado
func attack_enemy1():
    enemy1.health -= player.attack
    if enemy1.health <= 0:
        enemy1.die()

func attack_enemy2():
    enemy2.health -= player.attack
    if enemy2.health <= 0:
        enemy2.die()

# DESPUÉS: Código reutilizable
func attack_enemy(enemy: Enemy):
    enemy.take_damage(player.attack)
    if enemy.is_dead():
        enemy.die()
```

---

## 📝 Flujo de Documentación

### Qué Documentar

1. **Decisiones de Diseño**
   - ¿Por qué elegiste esta solución?
   - ¿Qué alternativas consideraste?
   - ¿Qué trade-offs hay?

2. **Sistemas Complejos**
   - ¿Cómo funciona el sistema?
   - ¿Cómo se integra con otros sistemas?
   - ¿Qué APIs expone?

3. **Configuraciones Especiales**
   - ¿Hay configuraciones no obvias?
   - ¿Qué valores son importantes?

### Cuándo Documentar

**Idealmente:**
- Mientras desarrollas (no después)
- Cuando tomas una decisión importante
- Cuando creas un sistema complejo

**Mínimo:**
- Al finalizar una feature
- Al encontrar algo confuso
- Al hacer cambios importantes

### Formato de Documentación

```markdown
## Sistema de Combate

### Propósito
Maneja todas las interacciones de combate entre unidades.

### Componentes
- `CombatSystem`: Coordina el combate
- `Unit`: Representa una unidad
- `CombatResolver`: Calcula resultados

### Flujo
1. Unidad encuentra objetivo
2. Calcula daño
3. Aplica daño
4. Verifica si muere

### Decisiones
- Usamos turnos por tiempo en lugar de por turno
- Daño = ataque - defensa (mínimo 1)
- Unidades muertas se remueven inmediatamente
```

---

## 🎮 Flujo de Testing

### Testing Durante Desarrollo

**Mientras codificas:**
```gdscript
# Prueba inmediata
func _ready():
    var result = my_function()
    print("Resultado: ", result)
    assert(result == expected, "Debería ser igual")
```

### Testing Después de Implementar

**Checklist:**
- [ ] ¿Funciona el caso normal?
- [ ] ¿Funciona con valores extremos?
- [ ] ¿Maneja errores correctamente?
- [ ] ¿Se integra bien con otros sistemas?

### Testing Manual

**Qué probar:**
1. Happy path (flujo normal)
2. Edge cases (valores límite)
3. Error cases (entrada inválida)
4. Integración (con otros sistemas)

**Ejemplo de Checklist:**
```
Sistema de Inventario:
[ ] Puedo agregar un item
[ ] Puedo remover un item
[ ] No puedo agregar si está lleno
[ ] No puedo agregar item null
[ ] Señales se emiten correctamente
[ ] UI se actualiza cuando agrego item
```

---

## 🚀 Flujo de Optimización

### Cuándo Optimizar

**NO optimices:**
- Antes de medir
- Si no hay problema de performance
- Si hace el código menos legible

**SÍ optimiza:**
- Después de identificar un cuello de botella
- Cuando el juego va lento
- Cuando hay memory leaks

### Cómo Optimizar

**Paso 1: Medir (30 min)**
```gdscript
# Usar profiling tools
func _process(delta):
    var start_time = Time.get_ticks_msec()
    
    # Código a medir
    process_all_units()
    
    var end_time = Time.get_ticks_msec()
    if end_time - start_time > 16:  # Más de 1 frame
        print("WARNING: process_all_units toma ", end_time - start_time, "ms")
```

**Paso 2: Identificar Problema (30 min)**
- ¿Qué función es lenta?
- ¿Hay loops innecesarios?
- ¿Hay allocaciones frecuentes?

**Paso 3: Optimizar (1-2 horas)**
- Usar object pooling
- Cachear cálculos
- Reducir allocaciones
- Optimizar algoritmos

**Paso 4: Verificar (15 min)**
- ¿Mejoró el performance?
- ¿No rompí funcionalidad?
- ¿El código sigue siendo legible?

---

## 📊 Métricas de Progreso

### Qué Medir

1. **Features Completadas**
   - ¿Cuántas features del roadmap están listas?
   - ¿Qué porcentaje del juego está completo?

2. **Bugs**
   - ¿Cuántos bugs hay?
   - ¿Cuántos críticos vs menores?
   - ¿Tendencia: aumentando o disminuyendo?

3. **Performance**
   - ¿Frame rate promedio?
   - ¿Memory usage?
   - ¿Load times?

4. **Código**
   - ¿Cobertura de tests?
   - ¿Líneas de código?
   - ¿Complejidad ciclomática?

### Revisión Semanal

**Preguntas:**
- ¿Qué completé esta semana?
- ¿Qué aprendí?
- ¿Qué problemas encontré?
- ¿Qué haré la próxima semana?

---

## 🎯 Priorización de Tareas

### Matriz de Priorización

```
URGENTE + IMPORTANTE → Hacer primero
URGENTE + NO IMPORTANTE → Delegar o hacer rápido
NO URGENTE + IMPORTANTE → Planificar
NO URGENTE + NO IMPORTANTE → Eliminar o postergar
```

### Criterios de Prioridad

**Alta Prioridad:**
- Bloquea otras features
- Es crítico para el core loop
- Es un bug crítico

**Media Prioridad:**
- Mejora experiencia significativamente
- Es necesario pero no urgente
- Bugs menores

**Baja Prioridad:**
- Nice to have
- Pulido visual
- Optimizaciones prematuras

---

## 💡 Tips de Productividad

1. **Time Boxing**: Asigna tiempo específico a cada tarea
2. **Pomodoro**: 25 min trabajo, 5 min descanso
3. **Elimina Distracciones**: Cierra redes sociales, notificaciones
4. **Trabaja en Bloques**: Features relacionadas juntas
5. **Descansa**: No trabajes 8 horas seguidas, toma breaks
6. **Aprende Constantemente**: Dedica tiempo a aprender nuevas técnicas
7. **Mantén el Código Limpio**: Es más rápido trabajar con código limpio

---

**¡Sigue este flujo y verás mejoras en tu productividad! 🚀**

