# 🎮 Guía Rápida: Tablero - AutoChess

**Última actualización:** Diciembre 2024  
**Estado:** Referencia rápida

---

## ⚡ Inicio Rápido

El tablero ya está creado y funcional en `scenes/Board.tscn`.

### Estructura de la Escena

```
Board (Node2D)
├── Camera2D (Camera2D) - Position: (0, 0)
├── GridEnemy (Node2D) - Position: (0, -250)
├── GridAlly (Node2D) - Position: (0, 250)
└── Bench (Node2D) - Position: (0, 610)
```

### Scripts Asociados

- `scripts/Board.gd` - Script principal
- `scripts/GridEnemy.gd` - Grid enemigo (7×5)
- `scripts/GridAlly.gd` - Grid aliado (7×5)
- `scripts/Bench.gd` - Banquillo (10 slots)

---

## 📐 Especificaciones Básicas

- **Resolución:** 1920×1080 (Full HD)
- **Tamaño de celda:** 100px × 100px
- **Grid Enemigo:** 7 columnas × 5 filas
- **Grid Aliado:** 7 columnas × 5 filas
- **Banquillo:** 10 slots horizontales

---

## ✅ Verificación

Al ejecutar el juego (F5), deberías ver:
- ✅ Grid Enemigo arriba
- ✅ Grid Aliado en el centro
- ✅ Banquillo abajo
- ✅ Todo centrado en pantalla
- ✅ Tests ejecutándose automáticamente

---

## 📖 Documentación Completa

Para información detallada, consulta:
- **`ESPECIFICACIONES_TABLERO.md`** - Especificaciones técnicas
- **`RESUMEN_CREACION_TABLERO.md`** - Documentación completa
- **`DESIGN_DECISIONS.md`** - Decisiones de diseño

---

**Nota:** Los elementos visuales se crean automáticamente mediante scripts.
