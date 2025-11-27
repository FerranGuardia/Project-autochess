# 📋 Planificación de MVP - Sesión de Definición

**Fecha:** Diciembre 2024  
**Objetivo:** Definir MVP realista y plan de acción concreto

---

## 🔍 Análisis del Estado Actual

### ✅ Lo que YA tienes (Excelente Base)

**Sistemas Funcionales:**
- ✅ Bench completo (10 slots, drag and drop)
- ✅ Grid completo (7x5, drag and drop)
- ✅ Sistema de drag and drop entre bench ↔ grid
- ✅ Sistema de combate básico (ataque, defensa, vida, muerte)
- ✅ 6 tipos de unidades definidos (Mago, Orco, Elfo, Enano, Beastkin, Demonio)
- ✅ Sistema de fases (Preparación, Combate)
- ✅ Tests unitarios (14 tests pasando)
- ✅ Tests de integración (base creada)
- ✅ Estructura de código sólida

**Assets:**
- ✅ Sprites 2D para todas las unidades
- ✅ Visualización funcional

**Código Base:**
- ✅ `Bench.gd` - Funcional
- ✅ `GridAlly.gd` - Funcional
- ✅ `GridEnemy.gd` - Funcional
- ✅ `Board.gd` - Funcional
- ✅ `Unit.gd` - Funcional
- ✅ `UnitData.gd` - Funcional
- ✅ `Shop.gd` - Existe pero no conectado

### ❌ Lo que FALTA para MVP Jugable

**Crítico (Sin esto no puedes jugar):**
1. ❌ **Sistema de Oro**
   - Variable de oro
   - Ganar/gastar oro
   - Costos de unidades

2. ❌ **Sistema de Compra**
   - UI de tienda
   - Botones de compra
   - Conexión Shop → Bench

3. ❌ **Sistema de Rondas**
   - Contador de rondas
   - Sistema de vidas
   - Game over

4. ❌ **IA para Enemigos**
   - Colocar unidades enemigas
   - O composición predefinida

**Importante (Para que sea divertido):**
5. ❌ **Sistema de Combinación**
   - 3 unidades = 1 estrella
   - Detección automática
   - Visual de estrellas

---

## 🎯 Definición de MVP

### MVP Mínimo (Lo que NECESITAS para jugar)

**Core Loop:**
```
1. Tienes oro
2. Compras unidad → Bench
3. Colocas unidad → Grid
4. Combate automático
5. Ganas/perdes ronda
6. Repites hasta game over
```

**Features Mínimas:**
- ✅ Grid 5x5 (ya tienes 7x5, está bien)
- ✅ Bench 8-10 slots (ya tienes 10)
- ✅ 5 unidades (ya tienes 6, elige 5)
- ✅ Sistema de compra (falta)
- ✅ Sistema de oro (falta)
- ✅ Combate básico (ya tienes)
- ✅ IA simple para enemigos (falta)
- ✅ Sistema de vidas (falta)
- ✅ Game over (falta)

**Tiempo estimado:** 3-4 semanas

### MVP Completo (Lo que hace el juego DIVERTIDO)

**Agregar a MVP Mínimo:**
- Sistema de combinación (3 = estrella)
- 2-3 sinergias simples
- UI mejorada
- Balance básico

**Tiempo estimado:** 6-8 semanas total

---

## 📊 Priorización de Tareas

### Prioridad 1: Core Loop Jugable (Semanas 1-2)

**Objetivo:** Poder jugar el juego de principio a fin

#### Tarea 1.1: Sistema de Oro (3-4 días)
- [ ] Crear `GameManager.gd` o agregar a `Board.gd`
- [ ] Variable `gold: int = 10` (oro inicial)
- [ ] Función `add_gold(amount: int)`
- [ ] Función `spend_gold(amount: int) -> bool`
- [ ] UI básica para mostrar oro

#### Tarea 1.2: Sistema de Compra (4-5 días)
- [ ] Conectar `Shop.gd` con sistema de oro
- [ ] Definir costos de unidades (1-3 oro)
- [ ] Crear UI de tienda (panel simple)
- [ ] Botones de compra
- [ ] Validar oro suficiente
- [ ] Validar espacio en bench
- [ ] Compra → Bench automático

#### Tarea 1.3: Sistema de Rondas (3-4 días)
- [ ] Contador de rondas
- [ ] Sistema de vidas (ej: 5 vidas)
- [ ] Perder ronda = perder 1 vida
- [ ] Game over cuando vidas = 0
- [ ] UI básica para mostrar ronda y vidas

#### Tarea 1.4: IA Simple para Enemigos (2-3 días)
- [ ] Colocar unidades enemigas aleatoriamente
- [ ] O usar composición predefinida por ronda
- [ ] Aumentar dificultad por ronda

**Resultado:** Juego jugable de principio a fin

### Prioridad 2: Combinación de Unidades (Semana 3)

**Objetivo:** Agregar mecánica core de autochess

#### Tarea 2.1: Sistema de Combinación (5-6 días)
- [ ] Detectar 3 unidades del mismo tipo
- [ ] Combinar automáticamente
- [ ] Crear unidad de 2 estrellas
- [ ] Remover unidades originales
- [ ] Colocar unidad combinada
- [ ] Visual de estrellas (simple)

**Resultado:** Puedes combinar unidades

### Prioridad 3: Pulido (Semana 4)

**Objetivo:** Hacer el juego más divertido

#### Tarea 3.1: Sinergias Simples (3-4 días)
- [ ] Definir 2-3 sinergias
- [ ] Sistema de detección
- [ ] Aplicar bonificaciones
- [ ] UI para mostrar sinergias

#### Tarea 3.2: Balance y Testing (2-3 días)
- [ ] Ajustar stats de unidades
- [ ] Ajustar costos
- [ ] Probar gameplay
- [ ] Arreglar bugs

**Resultado:** Juego pulido y balanceado

---

## 🗑️ Qué Eliminar/Postergar del Roadmap Actual

### Eliminar Completamente (por ahora)

❌ **Sistema de Items Complejo**
   - Postergar para después del MVP
   - Puedes hacer 2-3 items básicos después

❌ **Sistema de Interés de Oro**
   - Postergar para después del MVP
   - Oro simple es suficiente

❌ **Múltiples Sets de Campeones**
   - Postergar para después del MVP
   - 1 set balanceado es suficiente

❌ **Migración a 3D**
   - Postergar completamente
   - 2D funciona perfecto

### Postergar para Después del MVP

⏸️ **Bodyblock y Pathfinding Complejo**
   - Hacer: Movimiento básico (ya tienes)
   - Postergar: Pathfinding avanzado

⏸️ **Sistema de Sinergias Complejo**
   - Hacer: 2-3 sinergias simples
   - Postergar: Sistema completo

⏸️ **UI Super Pulida**
   - Hacer: UI funcional y clara
   - Postergar: Animaciones, efectos

⏸️ **Sistema de Progresión**
   - Hacer: Juego sin progresión
   - Postergar: Unlocks, achievements

---

## 📝 Definición de Unidades para MVP

### 5 Unidades Core (Elige de tus 6)

**Recomendación:**
1. **Mago** (Ranged DPS) - Costo: 2 oro
2. **Orco** (Melee Tank) - Costo: 1 oro
3. **Elfo** (Ranged DPS) - Costo: 2 oro
4. **Enano** (Melee DPS) - Costo: 3 oro
5. **Beastkin** (Melee DPS) - Costo: 2 oro

**O puedes usar las 6, pero 5 es más fácil de balancear.**

### Costos Sugeridos

- **Costo 1:** Unidades básicas (Orco)
- **Costo 2:** Unidades medias (Mago, Elfo, Beastkin)
- **Costo 3:** Unidades fuertes (Enano, Demonio)

---

## 🎮 Definición de Sinergias Simples

### 2-3 Sinergias para MVP

**Opción 1: Por Tipo**
- **Guerreros** (2+): +15% ataque, +10% defensa
- **Magos** (2+): +20% daño mágico

**Opción 2: Por Raza**
- **Humanos** (2+): +10% vida
- **Bestias** (2+): +15% velocidad de ataque

**Recomendación:** Empieza con 2 sinergias simples, agrega más después.

---

## 📅 Roadmap Simplificado (4 Semanas)

### Semana 1: Sistema de Compra
**Meta:** Comprar unidades y colocarlas

- [ ] Día 1-2: Sistema de oro
- [ ] Día 3-4: UI de tienda
- [ ] Día 5: Conexión compra → bench
- [ ] Día 6-7: Testing y ajustes

### Semana 2: Sistema de Rondas
**Meta:** Rondas completas funcionan

- [ ] Día 1-2: Sistema de vidas y rondas
- [ ] Día 3-4: IA simple para enemigos
- [ ] Día 5: Game over
- [ ] Día 6-7: Testing completo

### Semana 3: Combinación
**Meta:** Puedes combinar unidades

- [ ] Día 1-3: Sistema de combinación
- [ ] Día 4-5: Visual de estrellas
- [ ] Día 6-7: Testing y ajustes

### Semana 4: Pulido
**Meta:** Juego divertido y balanceado

- [ ] Día 1-2: Sinergias simples
- [ ] Día 3-4: Balance de gameplay
- [ ] Día 5-6: UI mejorada
- [ ] Día 7: Testing final

---

## 🎯 Preguntas para Definir tu MVP

### 1. ¿Cuántas unidades quieres?
- [ ] 5 unidades (más fácil de balancear)
- [ ] 6 unidades (ya las tienes todas)
- [ ] 8 unidades (más variedad, más trabajo)

**Recomendación:** 5 para MVP, agrega más después

### 2. ¿Qué tan complejo quieres el combate?
- [ ] Simple (ya tienes esto)
- [ ] Con habilidades especiales
- [ ] Con items

**Recomendación:** Simple para MVP

### 3. ¿Quieres sinergias en el MVP?
- [ ] Sí, 2-3 sinergias simples
- [ ] No, solo combinación de unidades

**Recomendación:** 2 sinergias simples hacen el juego más divertido

### 4. ¿Cuánto tiempo quieres dedicar?
- [ ] 3-4 semanas (MVP mínimo)
- [ ] 6-8 semanas (MVP completo)
- [ ] Más tiempo (más features)

**Recomendación:** 4 semanas para MVP jugable

---

## ✅ Checklist de Preparación

Antes de empezar a codificar:

- [ ] He leído y entendido el MVP
- [ ] He definido mis 5 unidades
- [ ] He definido costos de unidades
- [ ] He definido 2-3 sinergias (si las quiero)
- [ ] He creado mi roadmap personalizado
- [ ] Sé qué voy a hacer primero
- [ ] Sé qué voy a postergar

---

## 🚀 Próximo Paso Inmediato

**Una vez que definas tu MVP:**

1. **Crea tu roadmap personalizado** basado en este documento
2. **Empieza con Tarea 1.1: Sistema de Oro**
3. **Completa una tarea antes de empezar otra**
4. **Testea constantemente**
5. **Actualiza este documento con tu progreso**

---

## 💬 Notas Finales

**Recuerda:**
- ✅ Ya tienes una base excelente
- ✅ No necesitas empezar de cero
- ✅ Simplifica, no elimines todo
- ✅ Completa antes de agregar
- ✅ Un juego pequeño y completo > juego grande e incompleto

**Tu objetivo:**
> "Hacer un autochess simple, completo y divertido en 4 semanas"

---

**¿Listo para definir tu MVP específico?** 🎮

