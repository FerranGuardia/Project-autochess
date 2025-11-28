# 📐 Layout de la Tienda - Posiciones Organizadas

**Fecha:** Hoy  
**Estado:** ✅ Reorganizado sin solapamientos

---

## 📊 Estructura del Panel de Tienda

**Panel Principal:**
- Posición: (50, 50)
- Tamaño: 600x300 píxeles
- Área: Rect2(50, 50, 600, 300)

---

## 📍 Posiciones Internas (Relativas al Panel)

### 1. Título "TIENDA"
- **Posición:** (10, 10)
- **Tamaño:** 580x30 píxeles
- **Área:** Rect2(10, 10, 580, 30)
- **Altura total usada:** 10 + 30 = 40px

### 2. Información del Juego
- **Posición:** (10, 45) - 5px de margen después del título
- **Tamaño:** 280x100 píxeles
- **Área:** Rect2(10, 45, 280, 100)
- **Contenido:**
  - Oro: (0, 0) relativo al contenedor
  - Ronda: (0, ~25) relativo al contenedor
  - Vidas: (0, ~50) relativo al contenedor
  - Fase: (0, ~75) relativo al contenedor
- **Altura total usada:** 45 + 100 = 145px

### 3. Ofertas
- **Posición:** (10, 150) - 5px de margen después de info
- **Tamaño:** 580x100 píxeles
- **Área:** Rect2(10, 150, 580, 100)
- **Cada oferta:** ~20px de altura (5 ofertas = 100px)
- **Altura total usada:** 150 + 100 = 250px

### 4. Botón Refrescar
- **Posición:** (10, 260) - 10px de margen después de ofertas
- **Tamaño:** 150x30 píxeles
- **Área:** Rect2(10, 260, 150, 30)
- **Altura total usada:** 260 + 30 = 290px

---

## ✅ Verificación de Solapamientos

| Elemento | Y Inicio | Y Fin | Solapamiento |
|----------|----------|-------|--------------|
| Título | 10 | 40 | ✅ |
| Info | 45 | 145 | ✅ (5px margen) |
| Ofertas | 150 | 250 | ✅ (5px margen) |
| Botón | 260 | 290 | ✅ (10px margen) |

**Resultado:** ✅ No hay solapamientos

---

## 📏 Márgenes y Espaciado

- **Margen lateral:** 10px (izquierda y derecha)
- **Margen entre título e info:** 5px
- **Margen entre info y ofertas:** 5px
- **Margen entre ofertas y botón:** 10px
- **Margen inferior:** 10px (300 - 290 = 10px)

---

## 🎯 Áreas Reservadas

### Panel de Tienda
- **Área:** Rect2(50, 50, 600, 300)
- **Descripción:** Todo el panel de la tienda

### Panel de Controles
- **Área:** Rect2(900, 50, 320, 60)
- **Descripción:** Panel de controles separado

**Separación entre áreas:** 250px horizontalmente

---

**Layout completamente organizado sin solapamientos ✅**

