# 🗺️ Mi Roadmap Personalizado - AutoChess MVP

**Fecha de creación:** Hoy  
**Objetivo del MVP:** MVP mínimo - Juego completo de principio a fin (ejercicio de aprendizaje)  
**Tiempo estimado:** 3-4 semanas (10-20 horas/semana = 40-80 horas totales)

---

## 🎯 Definición de Mi MVP

### Unidades
- **Cantidad:** 6 unidades
- **Tipos:** 
  1. Elfo (Costo: 1) - Unidad ranged asequible
  2. Enano (Costo: 1) - Unidad mele asequible
  3. Beastkin (Costo: 2) - Mecánicas inusuales, risk/reward, escalado
  4. Mago (Costo: 3) - Unidad ranged poderosa
  5. Orco (Costo: 3) - Unidad mele poderosa
  6. Demonio (Costo: 3) - Habilidades especiales, empieza débil, acaba fuerte

### Sistemas Incluidos
- [x] Sistema de compra (tienda)
- [x] Sistema de oro
- [x] Sistema de rondas
- [x] Sistema de vidas (5 vidas)
- [ ] Sistema de combinación (post-MVP)
- [x] Sistema de sinergias (3 sinergias)
- [ ] Sistema de items (post-MVP)

### Combate
- **Nivel:** Medio - Con habilidades especiales básicas
- **Movimiento:** Sí, unidades se mueven durante combate

### IA
- **Tipo:** Predefinida - Composiciones fijas por ronda
- **Escalado:** Sí, dificultad aumenta por ronda

### Sinergias Definidas
1. **Nombre:** Dark Path
   - Requisito: Al menos 3 demonios/beastkin/orcos en el tablero
   - Bonus: Después de cada ronda aumenta la vida máxima de todas las unidades en +5

2. **Nombre:** For the Light
   - Requisito: No tener ninguna unidad demonio o beastkin en el tablero
   - Bonus: Cada segundo de combate aumenta el attack speed de todas las unidades un 0.3% y las unidades se curan un 10% del daño aplicado

3. **Nombre:** Absolute Balance
   - Requisito: Tener una unidad de cada tipo en el tablero
   - Bonus: Se reciben los bonus de las dos mecánicas anteriores reducidas a la mitad

---

## 📅 Roadmap por Semanas

### Semana 1: Sistema de Compra y Oro ✅ COMPLETADA
**Meta:** Comprar unidades y colocarlas en el bench

**Tareas:**
- [x] Día 1-2: Sistema de oro
  - [x] Crear `GameManager.gd`
  - [x] Variable `gold: int = 10`
  - [x] Funciones `add_gold(amount)` y `spend_gold(amount)`
  - [x] Validación de oro suficiente
  - [x] UI básica para mostrar oro (parte de UI pulida)

- [x] Día 3-4: UI de tienda
  - [x] Panel de tienda (diseño simple pero pulido)
  - [x] Mostrar 5 ofertas aleatorias
  - [x] Botones de compra con visualización de costos
  - [x] Feedback visual al comprar
  - [x] Mostrar unidades disponibles: Elfo(1), Enano(1), Beastkin(2), Mago(3), Orco(3), Demonio(3)

- [x] Día 5: Conexión compra → bench
  - [x] Validar oro suficiente antes de comprar
  - [x] Validar espacio en bench (máximo 10 slots)
  - [x] Compra automática → bench
  - [x] Actualizar UI de oro después de compra
  - [x] Manejar errores (sin oro, bench lleno)

- [x] Día 6-7: Testing y ajustes
  - [x] Probar compra de todas las unidades
  - [x] Verificar costos correctos
  - [x] Verificar que aparecen en bench
  - [x] Tests unitarios completos (18 tests, todos pasan ✅)
  - [x] Testing de edge cases (bench lleno, sin oro)

**Resultado esperado:** ✅ Puedo comprar cualquier unidad y aparece en el bench correctamente

---

### Semana 2: Sistema de Rondas y Combate
**Meta:** Rondas completas con combate funcional

**Tareas:**
- [x] Día 1-2: Sistema de vidas y rondas
  - [x] Contador de rondas (inicia en 1)
  - [x] Sistema de vidas (5 vidas iniciales)
  - [x] Perder ronda = perder 1 vida (implementado en end_combat)
  - [x] UI para mostrar ronda y vidas (parte de UI pulida)
  - [x] Sistema de oro por ronda (ganar oro al empezar nueva ronda)
  - [x] Sistema de fases (preparación vs combate)
  - [x] Botón para iniciar combate

- [ ] Día 3-4: IA predefinida para enemigos
  - [ ] Crear composiciones fijas por ronda
  - [ ] Colocar unidades enemigas en GridEnemy
  - [ ] Aumentar dificultad por ronda (más unidades o más fuertes)
  - [ ] Testing básico de combate

- [ ] Día 5-6: Sistema de combate con movimiento
  - [ ] Unidades se mueven hacia enemigos más cercanos
  - [ ] Sistema de rango (ranged vs mele)
  - [ ] Ataques básicos funcionando
  - [ ] Detectar fin de combate (todas unidades aliadas muertas o todas enemigas muertas)
  - [ ] Calcular resultado (ganar/perder ronda)

- [ ] Día 7: Game over y testing
  - [ ] Detectar cuando vidas = 0
  - [ ] Pantalla de game over simple
  - [ ] Opción de reiniciar
  - [ ] Testing de ronda completa

**Resultado esperado:** Puedo jugar rondas completas con combate funcional hasta game over

---

### Semana 3: Habilidades y Sinergias
**Meta:** Combate con habilidades y sistema de sinergias funcionando

**Tareas:**
- [ ] Día 1-3: Sistema de habilidades básicas
  - [ ] Definir habilidades para cada unidad (básicas pero únicas)
  - [ ] Sistema de cooldown/mana para habilidades
  - [ ] Implementar habilidades especiales básicas
  - [ ] Elfo: Habilidad ranged especial
  - [ ] Enano: Habilidad mele especial
  - [ ] Beastkin: Mecánica inusual (risk/reward)
  - [ ] Mago: Habilidad poderosa a distancia
  - [ ] Orco: Habilidad mele poderosa
  - [ ] Demonio: Habilidad de escalado (débil → fuerte)

- [ ] Día 4-5: Sistema de sinergias
  - [ ] Sistema de detección de sinergias
  - [ ] Dark Path: Detectar 3+ demonios/beastkin/orcos
  - [ ] For the Light: Detectar que no hay demonios/beastkin
  - [ ] Absolute Balance: Detectar una unidad de cada tipo
  - [ ] Aplicar bonificaciones correctamente
  - [ ] UI para mostrar sinergias activas (parte de UI pulida)

- [ ] Día 6-7: Testing y balance
  - [ ] Probar todas las habilidades
  - [ ] Probar todas las sinergias
  - [ ] Verificar que los bonus se aplican correctamente
  - [ ] Testing de combate completo con habilidades y sinergias
  - [ ] Ajustar valores si es necesario

**Resultado esperado:** Combate con habilidades funcionando y sistema de sinergias completo

---

### Semana 4: Pulido y Balance
**Meta:** Juego completo, balanceado y divertido

**Tareas:**
- [ ] Día 1-2: Balance de gameplay
  - [ ] Ajustar stats de unidades (HP, ataque, velocidad)
  - [ ] Ajustar costos de unidades si es necesario
  - [ ] Ajustar valores de sinergias (bonus de Dark Path, For the Light, Absolute Balance)
  - [ ] Ajustar dificultad de IA por ronda
  - [ ] Probar diferentes composiciones
  - [ ] Verificar que todas las unidades son viables

- [ ] Día 3-4: UI pulida
  - [ ] Mejorar visualización de oro, ronda, vidas
  - [ ] Mejorar visualización de sinergias activas
  - [ ] Agregar feedback visual (compras, combate, sinergias)
  - [ ] Pulir detalles visuales
  - [ ] Asegurar que UI es clara y funcional

- [ ] Día 5-6: Testing exhaustivo
  - [ ] Jugar partidas completas (múltiples)
  - [ ] Probar todas las unidades
  - [ ] Probar todas las sinergias
  - [ ] Verificar que el juego es divertido
  - [ ] Verificar que el balance es razonable
  - [ ] Arreglar bugs encontrados

- [ ] Día 7: Preparación final
  - [ ] Últimos ajustes de balance
  - [ ] Arreglar últimos bugs críticos
  - [ ] Verificar que todo funciona correctamente
  - [ ] Preparar para demo/prueba
  - [ ] Documentar decisiones importantes

**Resultado esperado:** MVP completo, balanceado y listo para jugar de principio a fin

---

## 📊 Progreso

### Semana 1 ✅
- [x] Completada
- [ ] En progreso
- [ ] Pendiente

**Notas:** Sistema de oro y tienda completamente funcional. 18 tests unitarios pasan. Commit realizado.

### Semana 2
- [ ] Completada
- [ ] En progreso
- [ ] Pendiente

**Notas:** _____

### Semana 3
- [ ] Completada
- [ ] En progreso
- [ ] Pendiente

**Notas:** _____

### Semana 4
- [ ] Completada
- [ ] En progreso
- [ ] Pendiente

**Notas:** _____

---

## 🎯 Hitos Importantes

- [ ] **Hito 1:** Sistema de compra funcionando
  - Fecha objetivo: _____
  - Fecha real: _____

- [ ] **Hito 2:** Rondas completas funcionando
  - Fecha objetivo: _____
  - Fecha real: _____

- [ ] **Hito 3:** Combinación de unidades funcionando
  - Fecha objetivo: _____
  - Fecha real: _____

- [ ] **Hito 4:** MVP completo
  - Fecha objetivo: _____
  - Fecha real: _____

---

## 🐛 Bugs Encontrados

| Bug | Descripción | Prioridad | Estado | Fecha |
|-----|-------------|-----------|--------|-------|
|     |             |           |        |       |
|     |             |           |        |       |
|     |             |           |        |       |

---

## 💡 Ideas para Después del MVP

- [ ] _____
- [ ] _____
- [ ] _____

---

## 📝 Notas de Desarrollo

### Decisiones Importantes
- _____
- _____
- _____

### Lecciones Aprendidas
- _____
- _____
- _____

### Cambios de Plan
- _____
- _____
- _____

---

## ✅ Checklist Semanal

**Cada semana, verifica:**
- [ ] ¿Completé las tareas planificadas?
- [ ] ¿El código funciona correctamente?
- [ ] ¿Hice testing suficiente?
- [ ] ¿Actualicé este roadmap?
- [ ] ¿Estoy en el camino correcto?

---

**¡Actualiza este roadmap regularmente con tu progreso! 🚀**

