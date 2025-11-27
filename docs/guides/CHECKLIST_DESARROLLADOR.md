# ✅ Checklist Rápido - Desarrollador de Videojuegos

**Referencia rápida para el día a día**

---

## 🌅 Inicio del Día

- [ ] Revisar tareas del día
- [ ] Verificar estado del proyecto (git pull si trabajas en equipo)
- [ ] Revisar bugs/issues pendientes
- [ ] Planificar qué vas a hacer hoy
- [ ] Setup del entorno (abrir editor, cargar proyecto)

---

## 💻 Antes de Empezar a Codear

- [ ] ¿Entiendo completamente qué voy a implementar?
- [ ] ¿Tengo todos los assets/recursos necesarios?
- [ ] ¿Hay documentación que deba leer primero?
- [ ] ¿Conozco las dependencias de esta feature?
- [ ] ¿Hay tests existentes que deba revisar?

---

## 🔨 Mientras Desarrollas

### Código
- [ ] ¿El código es legible y fácil de entender?
- [ ] ¿Estoy siguiendo las convenciones del proyecto?
- [ ] ¿Estoy probando mientras desarrollo?
- [ ] ¿Estoy documentando código complejo?

### Funcionalidad
- [ ] ¿La feature funciona como se espera?
- [ ] ¿Manejo casos de error apropiadamente?
- [ ] ¿La feature se integra bien con sistemas existentes?
- [ ] ¿No rompí funcionalidad existente?

### Performance
- [ ] ¿El código es eficiente?
- [ ] ¿Hay memory leaks potenciales?
- [ ] ¿Estoy haciendo allocaciones innecesarias?

---

## 🧪 Antes de Hacer Commit

- [ ] ¿El código compila sin errores?
- [ ] ¿Los tests pasan?
- [ ] ¿Probé la funcionalidad manualmente?
- [ ] ¿No hay código comentado/debug que deba remover?
- [ ] ¿El mensaje de commit es descriptivo?
- [ ] ¿Hice commit de cambios relacionados juntos?

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

---

## 🐛 Al Encontrar un Bug

- [ ] ¿Puedo reproducirlo consistentemente?
- [ ] ¿Documenté los pasos para reproducirlo?
- [ ] ¿Identifiqué la causa raíz?
- [ ] ¿Creé un fix que resuelve el problema?
- [ ] ¿Verifiqué que el fix funciona?
- [ ] ¿Agregué un test para prevenir regresión?
- [ ] ¿No rompí otras funcionalidades?

---

## 🔄 Al Refactorizar

- [ ] ¿Creé tests antes de refactorizar?
- [ ] ¿Los tests pasan antes de empezar?
- [ ] ¿Estoy haciendo cambios pequeños e incrementales?
- [ ] ¿Verifico que tests pasan después de cada cambio?
- [ ] ¿El código refactorizado es más legible?
- [ ] ¿No cambié la funcionalidad (solo estructura)?

---

## 📝 Al Implementar una Feature

### Planificación
- [ ] ¿Definí claramente qué voy a implementar?
- [ ] ¿Identifiqué componentes necesarios?
- [ ] ¿Revisé sistemas existentes que puedo usar?
- [ ] ¿Estimé el tiempo necesario?

### Implementación
- [ ] ¿Creé la estructura base primero?
- [ ] ¿Implementé funcionalidad core?
- [ ] ¿Manejé edge cases?
- [ ] ¿Integré con otros sistemas?
- [ ] ¿Creé tests?

### Finalización
- [ ] ¿La feature está completa?
- [ ] ¿Documenté cómo funciona?
- [ ] ¿Actualicé documentación del proyecto?
- [ ] ¿Probé la feature completamente?

---

## 🎨 Al Trabajar con Assets

- [ ] ¿Los assets siguen las convenciones de nombres?
- [ ] ¿Están en las carpetas correctas?
- [ ] ¿Están optimizados (tamaño, formato)?
- [ ] ¿Los importé correctamente en el editor?
- [ ] ¿Actualicé referencias si moví/renombré assets?

---

## 🧪 Testing

### Tests Unitarios
- [ ] ¿Creé tests para código nuevo?
- [ ] ¿Los tests cubren casos normales?
- [ ] ¿Los tests cubren edge cases?
- [ ] ¿Los tests cubren casos de error?
- [ ] ¿Todos los tests pasan?

### Testing Manual
- [ ] ¿Probé el flujo completo?
- [ ] ¿Probé casos extremos?
- [ ] ¿Probé con entrada inválida?
- [ ] ¿Probé integración con otros sistemas?

---

## 📚 Documentación

- [ ] ¿Documenté decisiones importantes?
- [ ] ¿Documenté sistemas complejos?
- [ ] ¿Actualicé README si es necesario?
- [ ] ¿Los comentarios en código son útiles?
- [ ] ¿La documentación está actualizada?

---

## 🚀 Antes de un Build/Release

- [ ] ¿Todas las features están completas?
- [ ] ¿Todos los bugs críticos están arreglados?
- [ ] ¿Los tests pasan?
- [ ] ¿Probé el juego completo?
- [ ] ¿Optimicé assets (si es necesario)?
- [ ] ¿Revisé logs de errores?
- [ ] ¿El juego corre a buen frame rate?
- [ ] ¿No hay memory leaks?

---

## 📊 Revisión Semanal

- [ ] ¿Qué completé esta semana?
- [ ] ¿Qué aprendí?
- [ ] ¿Qué problemas encontré?
- [ ] ¿Qué haré la próxima semana?
- [ ] ¿Actualicé el roadmap?
- [ ] ¿Hay deuda técnica que deba abordar?

---

## 🎯 Priorización

### Alta Prioridad
- [ ] Bloquea otras features
- [ ] Es crítico para el core loop
- [ ] Es un bug crítico

### Media Prioridad
- [ ] Mejora experiencia significativamente
- [ ] Es necesario pero no urgente
- [ ] Bugs menores

### Baja Prioridad
- [ ] Nice to have
- [ ] Pulido visual
- [ ] Optimizaciones prematuras

---

## 🔍 Code Review (si trabajas en equipo)

### Al Revisar Código de Otros
- [ ] ¿El código es legible?
- [ ] ¿Sigue las convenciones del proyecto?
- [ ] ¿Hay bugs obvios?
- [ ] ¿Hay mejoras sugeridas?
- [ ] ¿Los tests están incluidos?
- [ ] ¿La documentación está actualizada?

### Al Enviar Código para Review
- [ ] ¿El código está limpio?
- [ ] ¿Los tests pasan?
- [ ] ¿Documenté cambios importantes?
- [ ] ¿El PR/commit tiene descripción clara?

---

## 🛠️ Mantenimiento

### Diario
- [ ] Commits pequeños y frecuentes
- [ ] Código limpio
- [ ] Tests actualizados

### Semanal
- [ ] Revisar y limpiar código no usado
- [ ] Actualizar dependencias si es necesario
- [ ] Revisar y cerrar issues resueltos

### Mensual
- [ ] Revisar arquitectura general
- [ ] Identificar deuda técnica
- [ ] Planificar refactorizaciones grandes

---

## ⚠️ Red Flags (Señales de Alerta)

**Si encuentras esto, detente y revisa:**
- [ ] Código que no entiendes completamente
- [ ] Funciones muy largas (>50 líneas)
- [ ] Mucha duplicación de código
- [ ] Tests que fallan frecuentemente
- [ ] Bugs que aparecen constantemente
- [ ] Código que temes tocar
- [ ] Cambios pequeños requieren tocar muchos archivos

---

## 💡 Buenas Prácticas Rápidas

### Código
- ✅ Nombres descriptivos
- ✅ Funciones pequeñas y enfocadas
- ✅ Comentarios donde sea necesario
- ✅ Sin código duplicado
- ✅ Tests para lógica compleja

### Trabajo
- ✅ Tareas pequeñas y manejables
- ✅ Commits frecuentes
- ✅ Testing constante
- ✅ Documentación mientras desarrollas
- ✅ Descansos regulares

### Proyecto
- ✅ Estructura clara
- ✅ Convenciones consistentes
- ✅ Roadmap actualizado
- ✅ Bugs documentados
- ✅ Features priorizadas

---

## 🎓 Aprendizaje Continuo

**Semanalmente:**
- [ ] ¿Aprendí algo nuevo esta semana?
- [ ] ¿Leí algún artículo/tutorial útil?
- [ ] ¿Vi código de otros proyectos?
- [ ] ¿Experimenté con nuevas técnicas?

**Mensualmente:**
- [ ] ¿Revisé mejores prácticas?
- [ ] ¿Aprendí sobre nuevas herramientas?
- [ ] ¿Mejoré en algún área específica?

---

## 📞 Comunicación (si trabajas en equipo)

- [ ] ¿Comuniqué cambios importantes?
- [ ] ¿Documenté decisiones de diseño?
- [ ] ¿Pregunté cuando no estoy seguro?
- [ ] ¿Compartí conocimiento con el equipo?
- [ ] ¿Actualicé el estado de mis tareas?

---

**Imprime este checklist y úsalo como referencia diaria! 📋**

