# 📖 Guía Completa de Desarrollo - AutoChess

**Última actualización:** Enero 2025  
**Para:** Desarrolladores del proyecto AutoChess

---

## 📋 Tabla de Contenidos

1. [Estructura del Proyecto](#estructura-del-proyecto)
2. [Flujo de Trabajo](#flujo-de-trabajo)
3. [Checklist Diario](#checklist-diario)
4. [Testing](#testing)
5. [Herramientas y Mejores Prácticas](#herramientas-y-mejores-prácticas)

---

## 🏗️ Estructura del Proyecto

### Organización de Carpetas

```
autochess/
├── assets/                    # Recursos del juego
│   └── sprites/               # Imágenes 2D
│       ├── units/             # Sprites de unidades
│       └── arena/             # Sprites de tablero y tiles
│
├── scenes/                    # Escenas del juego
│   └── Board.tscn            # Escena principal
│
├── scripts/                   # Código fuente
│   ├── Board.gd               # Script principal
│   ├── GameManager.gd         # Gestor de estado
│   ├── Shop.gd                # Sistema de tienda
│   ├── CombatSystem.gd        # Sistema de combate
│   ├── GridAlly.gd            # Grid aliado
│   ├── GridEnemy.gd           # Grid enemigo
│   ├── Bench.gd               # Banquillo
│   ├── Unit.gd                # Clase base de unidades
│   └── tests/                 # Tests unitarios e integración
│
└── docs/                      # Documentación
    ├── technical/             # Documentación técnica
    ├── guides/                # Guías de desarrollo
    └── BRANCHES_PRIORIDADES.md # Branches y features
```

### Principios de Organización

1. **Separación por Responsabilidad**: Cada carpeta tiene un propósito claro
2. **Escalabilidad**: Estructura que crece sin volverse caótica
3. **Encontrar Rápido**: Cualquier archivo debe ser fácil de localizar
4. **Convenciones de Nombres**: Consistencia en todo el proyecto

---

## 🔄 Flujo de Trabajo

### Flujo Diario Recomendado

**Mañana (Enfoque en Código Nuevo)**
- Revisar tareas del día
- Implementar nuevas funcionalidades
- Crear tests para código nuevo

**Tarde (Integración y Pruebas)**
- Integrar cambios
- Probar funcionalidades completas
- Arreglar bugs encontrados

**Final del Día (Limpieza)**
- Commit de cambios
- Actualizar documentación
- Planificar el siguiente día

### Flujo para Implementar una Feature Nueva

#### Paso 1: Análisis y Diseño (30 min - 1 hora)
- ¿Qué necesito implementar exactamente?
- ¿Qué sistemas ya existen que puedo usar?
- ¿Qué necesito crear desde cero?
- ¿Hay dependencias con otras features?

#### Paso 2: Crear Estructura Base (1-2 horas)
1. Crear clases base (data structures)
2. Crear interfaces/señales necesarias
3. Crear estructura de archivos
4. Escribir stubs de funciones principales

#### Paso 3: Implementar Funcionalidad Core (2-4 horas)
- Implementar una función a la vez
- Probar cada función inmediatamente
- No preocuparse por edge cases todavía

#### Paso 4: Manejar Edge Cases (1-2 horas)
- ¿Qué pasa si está lleno?
- ¿Qué pasa con valores null/inválidos?
- ¿Qué pasa con casos extremos?

#### Paso 5: Integrar con Otros Sistemas (1-2 horas)
- Verificar que funciona con sistemas existentes
- Conectar señales correctamente
- Probar integración completa

#### Paso 6: Testing Completo (1 hora)
- Crear tests unitarios
- Crear tests de integración si aplica
- Verificar que todos pasan

#### Paso 7: Refactorización (30 min - 1 hora)
- Revisar código
- Eliminar duplicación
- Mejorar legibilidad

#### Paso 8: Documentación (30 min)
- Documentar cómo usar la feature
- Documentar decisiones importantes
- Actualizar README si es necesario

### Flujo para Arreglar un Bug

1. **Reproducir el Bug** (15 min)
   - ¿Puedo reproducirlo consistentemente?
   - ¿Qué pasos específicos lo causan?

2. **Identificar la Causa** (30 min - 1 hora)
   - Revisar logs/consola
   - Agregar prints de debug
   - Usar debugger/breakpoints

3. **Crear Fix** (30 min - 1 hora)
   - Fix mínimo que resuelve el problema
   - Asegurarse de no romper otras cosas

4. **Verificar el Fix** (15 min)
   - ¿El bug está arreglado?
   - ¿No rompí otras funcionalidades?
   - ¿Los tests pasan?

5. **Agregar Test** (15 min)
   - Prevenir regresiones futuras

---

## ✅ Checklist Diario

### 🌅 Inicio del Día

- [ ] Revisar tareas del día
- [ ] Verificar estado del proyecto (git pull si trabajas en equipo)
- [ ] Revisar bugs/issues pendientes
- [ ] Planificar qué vas a hacer hoy
- [ ] Setup del entorno (abrir editor, cargar proyecto)

### 💻 Antes de Empezar a Codear

- [ ] ¿Entiendo completamente qué voy a implementar?
- [ ] ¿Tengo todos los assets/recursos necesarios?
- [ ] ¿Hay documentación que deba leer primero?
- [ ] ¿Conozco las dependencias de esta feature?
- [ ] ¿Hay tests existentes que deba revisar?

### 🔨 Mientras Desarrollas

**Código:**
- [ ] ¿El código es legible y fácil de entender?
- [ ] ¿Estoy siguiendo las convenciones del proyecto?
- [ ] ¿Estoy probando mientras desarrollo?
- [ ] ¿Estoy documentando código complejo?

**Funcionalidad:**
- [ ] ¿La feature funciona como se espera?
- [ ] ¿Manejo casos de error apropiadamente?
- [ ] ¿La feature se integra bien con sistemas existentes?
- [ ] ¿No rompí funcionalidad existente?

### 🧪 Antes de Hacer Commit

- [ ] ¿El código compila sin errores?
- [ ] ¿Los tests pasan?
- [ ] ¿Probé la funcionalidad manualmente?
- [ ] ¿No hay código comentado/debug que deba remover?
- [ ] ¿El mensaje de commit es descriptivo?

**Formato de Commit:**
```
tipo: descripción breve

- Detalle 1
- Detalle 2
```

**Tipos:**
- `feat`: Nueva funcionalidad
- `fix`: Corrección de bug
- `refactor`: Refactorización
- `test`: Tests
- `docs`: Documentación
- `style`: Formato (espacios, etc.)
- `chore`: Mantenimiento

### 🐛 Al Encontrar un Bug

- [ ] ¿Puedo reproducirlo consistentemente?
- [ ] ¿Documenté los pasos para reproducirlo?
- [ ] ¿Identifiqué la causa raíz?
- [ ] ¿Creé un fix que resuelve el problema?
- [ ] ¿Verifiqué que el fix funciona?
- [ ] ¿Agregué un test para prevenir regresión?

---

## 🧪 Testing

### Tests Unitarios

**Qué son:** Prueban componentes individuales aislados.

**Cómo ejecutar:**
1. Abre la escena `Board.tscn`
2. Agrega un nodo `Node` como hijo de `Board`
3. Renombra el nodo a `Tests`
4. En el Inspector, carga el script `scripts/Tests.gd`
5. Ejecuta el juego (F5)
6. Los tests se ejecutarán automáticamente

**Tests disponibles:**
- Tests del Banquillo (Bench) - 7 tests
- Tests del Grid - 4 tests
- Tests de Drag and Drop - 3 tests
- Tests del Sistema de Oro y Tienda - 18 tests
- Tests de Integración - 4 tests

**Total: 36+ tests**

### Tests de Integración

**Qué son:** Prueban que múltiples componentes funcionen correctamente juntos.

**Cuándo usar:**
- Cuando conectas 2 sistemas
- Cuando implementas un flujo completo
- Antes de hacer cambios grandes

**Ejemplos:**
- Bench ↔ Grid
- Shop → Bench
- Grid → Combat
- Flujo completo de ronda

### Estrategia de Testing

**Distribución recomendada:**
- **Tests Unitarios (70%)** - Componentes individuales
- **Tests de Integración (25%)** - Interacción entre sistemas
- **Tests End-to-End (5%)** - Flujos completos

**Cuándo escribir tests:**
- ✅ Siempre que creas una función nueva
- ✅ Cuando arreglas un bug
- ✅ Cuando refactorizas
- ✅ Cuando conectas 2 sistemas

### Mejores Prácticas de Testing

1. **Tests Independientes**: Cada test debe poder ejecutarse solo
2. **Nombres Descriptivos**: `test_bench_to_grid_moves_unit()` no `test_1()`
3. **Un Test, Un Flujo**: Cada test prueba un flujo específico
4. **Verificaciones Múltiples**: Verifica todos los aspectos relevantes
5. **Setup y Teardown**: Prepara y limpia el entorno para cada test

---

## 🛠️ Herramientas y Mejores Prácticas

### Control de Versiones (Git)

**Siempre:**
- ✅ Commits pequeños y frecuentes
- ✅ Mensajes de commit descriptivos
- ✅ Branches para features grandes
- ✅ No commitees código que no compila

**Estructura de branches:**
- `master` - Código estable
- `feature/nombre-feature` - Features nuevas
- Ver `docs/BRANCHES_PRIORIDADES.md` para lista completa

### Código

**Convenciones de nombres:**
```gdscript
# Variables: snake_case
var player_health: int = 100

# Funciones: snake_case
func calculate_damage() -> int:

# Clases: PascalCase
class_name GameManager

# Constantes: UPPER_SNAKE_CASE
const MAX_UNITS: int = 10
```

**Principios:**
- **DRY (Don't Repeat Yourself)**: No duplicar código
- **Single Responsibility**: Una clase, una responsabilidad
- **Legibilidad**: Código debe ser fácil de entender

### Arquitectura

**Separación de Concerns:**
- **Model**: Datos y lógica de negocio
- **View**: Presentación (UI, sprites)
- **Controller**: Coordinación entre Model y View

**Sistemas vs Entidades:**
- **Sistema**: Maneja múltiples entidades (ej: `CombatSystem`)
- **Entidad**: Representa un objeto del juego (ej: `Unit`)

**Event-Driven:**
- Usar señales en lugar de referencias directas
- `signal unit_died(unit: Unit)`

### Documentación

**Documenta:**
- Decisiones de diseño importantes
- Sistemas complejos
- APIs públicas
- Configuraciones especiales

**Cuándo documentar:**
- Mientras desarrollas (idealmente)
- Al finalizar una feature (mínimo)
- Al encontrar algo confuso

### Herramientas UI

**Godot Editor (Built-in):**
- Control nodes: Panel, MarginContainer, VBoxContainer, HBoxContainer
- Themes: Crear un Theme resource personalizado
- StyleBox: Para fondos, bordes, sombras
- Fonts: Fuentes personalizadas

**Ventajas:**
- Todo integrado en el editor
- Resultados inmediatos
- Fácil de iterar

---

## 🎯 Priorización de Tareas

### Alta Prioridad
- Bloquea otras features
- Es crítico para el core loop
- Es un bug crítico

### Media Prioridad
- Mejora experiencia significativamente
- Es necesario pero no urgente
- Bugs menores

### Baja Prioridad
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
6. **Mantén el Código Limpio**: Es más rápido trabajar con código limpio

---

## 📚 Recursos Adicionales

### Documentación del Proyecto

- `docs/BRANCHES_PRIORIDADES.md` - Lista de branches y features
- `docs/technical/` - Documentación técnica de sistemas
- `README.md` - Información general del proyecto

### Conceptos Fundamentales

1. **Game Design Patterns**
   - Observer Pattern (señales/eventos)
   - State Pattern (máquinas de estado)
   - Object Pool Pattern (optimización)

2. **Matemáticas para Juegos**
   - Vectores y álgebra lineal
   - Trigonometría básica
   - Física básica (velocidad, aceleración)

---

## 🚀 Consejos Finales

1. **Empieza Pequeño**: Un juego simple y completo es mejor que uno ambicioso e incompleto
2. **Termina lo que Empiezas**: No dejes proyectos a medias constantemente
3. **Aprende de Otros**: Juega juegos, lee código, estudia proyectos públicos
4. **Sé Iterativo**: Mejora gradualmente, no intentes hacer todo perfecto de una vez
5. **Documenta Decisiones**: Tu yo del futuro te lo agradecerá
6. **Testea Constantemente**: No esperes al final para probar
7. **Mantén el Código Limpio**: Es más fácil mantener código limpio que limpiar código sucio
8. **No Tengas Miedo de Refactorizar**: Si algo no funciona bien, arréglalo
9. **Disfruta el Proceso**: El desarrollo de juegos es un arte, disfrútalo

---

**¡Éxito en tu desarrollo! 🎮**

