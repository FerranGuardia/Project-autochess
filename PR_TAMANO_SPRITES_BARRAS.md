# Ajustar tamaño de sprites y posicionamiento dinámico de barras

## 📋 Resumen

Este PR ajusta el tamaño de los sprites de las unidades y mejora el sistema de posicionamiento de las barras de vida y energía para que se adapten dinámicamente al tamaño del sprite.

## 🎯 Cambios principales

### 1. Ajuste de tamaño de sprites
- **Factor de escala reducido**: De 1.6x a 1.25x (125% del tamaño de celda)
- Aplicado tanto a unidades aliadas como enemigas
- Los sprites ahora tienen un tamaño más equilibrado visualmente

### 2. Posicionamiento dinámico de barras
- **Nueva función**: `get_sprite_top_position()` - Calcula dinámicamente la posición superior del bounding box del sprite
- Las barras de vida y energía se posicionan automáticamente encima del sprite
- **Barras siempre visibles**: Las barras se ajustan automáticamente si se modifica el tamaño del sprite en el futuro
- Barra de vida: 8 píxeles arriba del sprite
- Barra de energía: 16 píxeles arriba del sprite (8 píxeles arriba de la barra de vida)

### 3. Corrección de warnings del debugger
- **17 alertas eliminadas**: Inicialización de todas las variables sin valor por defecto
- Variables inicializadas en:
  - `Unit.gd`
  - `CombatSystem.gd`
  - `GridAlly.gd` / `GridEnemy.gd`
  - `Board.gd`
  - `ShopUI.gd`
  - `EnemyAI.gd`
  - `GameManager.gd`
  - `Shop.gd` / `Bench.gd`
  - Todos los archivos de tests

### 4. Tests unitarios
- **Nuevo archivo**: `SpriteSizeTests.gd`
- 7 tests para verificar:
  - Factor de escala correcto
  - Cálculo de tamaño del sprite
  - Cálculo de posición superior
  - Posicionamiento de barras encima del sprite
  - Posición correcta de barra de vida
  - Posición correcta de barra de energía
  - Posición relativa entre barras

## 📁 Archivos modificados

### Scripts principales
- `scripts/Unit.gd` - Ajuste de escala y posicionamiento dinámico
- `scripts/CombatSystem.gd` - Inicialización de variables
- `scripts/GridAlly.gd` - Inicialización de variables
- `scripts/GridEnemy.gd` - Inicialización de variables
- `scripts/Board.gd` - Inicialización de variables
- `scripts/ShopUI.gd` - Inicialización de variables
- `scripts/EnemyAI.gd` - Inicialización de variables
- `scripts/GameManager.gd` - Inicialización de variables
- `scripts/Shop.gd` - Inicialización de variables
- `scripts/Bench.gd` - Inicialización de variables

### Tests
- `scripts/tests/SpriteSizeTests.gd` - **NUEVO** - Tests de tamaño y posicionamiento
- `scripts/tests/EnergyTests.gd` - Inicialización de variables
- `scripts/tests/CombatTests.gd` - Inicialización de variables
- `scripts/tests/EnemyTests.gd` - Inicialización de variables
- `scripts/tests/IntegrationTests.gd` - Inicialización de variables
- `scripts/tests/ShopTests.gd` - Inicialización de variables

## ✅ Beneficios

1. **Mejor experiencia visual**: Sprites con tamaño más equilibrado
2. **Sistema robusto**: Las barras se ajustan automáticamente a cambios futuros en el tamaño de sprites
3. **Código más limpio**: Sin warnings del debugger
4. **Cobertura de tests**: Tests unitarios para verificar el funcionamiento correcto

## 🧪 Testing

- ✅ Tests unitarios pasando (SpriteSizeTests.gd)
- ✅ Pruebas visuales realizadas
- ✅ Sin warnings del debugger
- ✅ Barras posicionadas correctamente

## 📝 Notas

- El factor de escala puede ajustarse fácilmente modificando `scale_factor *= 1.25` en `Unit.gd`
- Las barras se posicionan dinámicamente, por lo que cualquier cambio futuro en el tamaño de sprites no requerirá ajustes manuales


