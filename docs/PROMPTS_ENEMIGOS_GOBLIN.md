# 🎨 Prompts para Sprites de Enemigos - Temática Goblin

**Herramienta:** Sloyd AI (Text to Image)  
**Estilo:** 2D Isométrico, Pixel Art  
**Tamaño recomendado:** 512x512 píxeles (escalar a 256x256 para el juego)  
**Formato:** PNG con fondo transparente

---

## 📋 Información General

### Temática: Goblin
- **Raza:** Goblin (pequeños, verdes, malvados)
- **Estilo visual:** Pixel art isométrico, autochess/TFT
- **Vista:** Top-down isométrica (45 grados)
- **Consistencia:** Todos los goblins deben verse como parte de la misma raza

### Nomenclatura de Archivos:
```
assets/sprites/enemies/
├── goblin_archer_idle.png    (Goblin con arco - Ranged)
├── goblin_dagger_idle.png    (Goblin con daga - Mele)
└── goblin_shield_idle.png    (Goblin con espada y escudo - Tank)
```

---

## 🏹 Goblin Arquero (Ranged)

### Prompt Principal:
```
A small green goblin archer character, pixel art style, isometric top-down view, 45 degree angle, autochess game style, holding a wooden bow with an arrow, wearing simple leather armor, green skin, pointy ears, yellow eyes, menacing expression, standing idle pose, clean background, transparent background, 512x512 pixels, game sprite, Teamfight Tactics art style
```

### Prompt Alternativo (más detallado):
```
Pixel art sprite of a goblin archer, isometric top-down view, small green creature with pointy ears and yellow eyes, holding a wooden bow ready to shoot, wearing ragged leather armor and a quiver on the back, green skin with darker green patches, menacing grin, standing in idle combat pose, autochess game character, clean pixel art style, transparent background, 512x512 resolution, Teamfight Tactics inspired
```

### Características Visuales:
- **Arma:** Arco de madera simple, flecha lista
- **Armadura:** Armadura de cuero simple/raída
- **Color principal:** Verde (piel de goblin)
- **Expresión:** Malvada, amenazante
- **Pose:** En guardia, listo para disparar
- **Rol:** Ranged (ataque a distancia)

### Paleta de Colores Sugerida:
- **Piel:** Verde (#4A7C3E a #6B9F5F)
- **Armadura:** Marrón cuero (#8B6F47)
- **Arco:** Marrón madera (#5C4033)
- **Detalles:** Amarillo para ojos (#FFD700)

---

## ⚔️ Goblin con Daga (Mele)

### Prompt Principal:
```
A small green goblin warrior character, pixel art style, isometric top-down view, 45 degree angle, autochess game style, holding a sharp dagger in one hand, wearing minimal armor, green skin, pointy ears, yellow eyes, aggressive expression, standing in combat stance, clean background, transparent background, 512x512 pixels, game sprite, Teamfight Tactics art style
```

### Prompt Alternativo (más detallado):
```
Pixel art sprite of a goblin assassin, isometric top-down view, small green creature with pointy ears and yellow eyes, wielding a sharp curved dagger, wearing minimal dark leather armor, green skin with scars, aggressive snarl, crouched combat stance ready to strike, autochess game character, clean pixel art style, transparent background, 512x512 resolution, Teamfight Tactics inspired
```

### Características Visuales:
- **Arma:** Daga curva y afilada
- **Armadura:** Armadura mínima de cuero oscuro
- **Color principal:** Verde (piel de goblin)
- **Expresión:** Agresiva, lista para atacar
- **Pose:** Agachado, en posición de ataque
- **Rol:** Mele (ataque cuerpo a cuerpo)

### Paleta de Colores Sugerida:
- **Piel:** Verde (#4A7C3E a #6B9F5F)
- **Armadura:** Cuero oscuro (#3A2F1F)
- **Daga:** Metal plateado/oscuro (#808080)
- **Detalles:** Amarillo para ojos (#FFD700)

---

## 🛡️ Goblin con Espada y Escudo (Tank)

### Prompt Principal:
```
A small green goblin tank character, pixel art style, isometric top-down view, 45 degree angle, autochess game style, holding a small sword and a round wooden shield, wearing heavier armor pieces, green skin, pointy ears, yellow eyes, defensive expression, standing in defensive stance, clean background, transparent background, 512x512 pixels, game sprite, Teamfight Tactics art style
```

### Prompt Alternativo (más detallado):
```
Pixel art sprite of a goblin defender, isometric top-down view, small green creature with pointy ears and yellow eyes, holding a small sword and a round wooden shield with metal reinforcements, wearing heavier leather and metal armor pieces, green skin, determined expression, standing in defensive stance with shield raised, autochess game character, clean pixel art style, transparent background, 512x512 resolution, Teamfight Tactics inspired
```

### Características Visuales:
- **Armas:** Espada pequeña y escudo redondo de madera con refuerzos metálicos
- **Armadura:** Armadura más pesada (cuero y metal)
- **Color principal:** Verde (piel de goblin)
- **Expresión:** Determinada, defensiva
- **Pose:** Defensiva, escudo levantado
- **Rol:** Tank (tanque, absorbe daño)

### Paleta de Colores Sugerida:
- **Piel:** Verde (#4A7C3E a #6B9F5F)
- **Armadura:** Cuero marrón (#6B5B3D) y metal (#A0A0A0)
- **Escudo:** Madera (#8B6F47) con metal (#808080)
- **Espada:** Metal (#C0C0C0)
- **Detalles:** Amarillo para ojos (#FFD700)

---

## 🎯 Variaciones de Prompts (Si necesitas iterar)

### Si el goblin es demasiado grande:
Agrega al final del prompt:
```
, very small character, tiny goblin, miniature size
```

### Si el goblin es demasiado detallado:
Agrega al final del prompt:
```
, simple pixel art, minimal details, clean lines
```

### Si necesitas más agresividad:
Agrega al final del prompt:
```
, menacing expression, sharp teeth, aggressive pose
```

### Si necesitas más consistencia entre los 3:
Agrega al inicio del prompt:
```
Consistent art style with other goblin characters,
```

---

## 📝 Checklist de Generación

Para cada goblin, verifica:

- [ ] **Tamaño:** 512x512 píxeles (o mayor)
- [ ] **Fondo:** Transparente (PNG con alpha)
- [ ] **Vista:** Isométrica top-down (45 grados)
- [ ] **Estilo:** Pixel art consistente
- [ ] **Color:** Verde para la piel (consistente entre los 3)
- [ ] **Expresión:** Apropiada para su rol (amenazante, agresiva, defensiva)
- [ ] **Arma:** Visible y clara
- [ ] **Armadura:** Apropiada para su rol
- [ ] **Nombre de archivo:** Correcto según nomenclatura

---

## 🔧 Post-Procesamiento

Después de generar los sprites:

1. **Remover fondo** (si no es transparente):
   - Usar GIMP o herramienta similar
   - Ver `docs/GUIA_GIMP_SPRITES.md` para guía completa

2. **Escalar a tamaño final**:
   - Tamaño recomendado en juego: 256x256 píxeles
   - O mantener 512x512 si prefieres más detalle

3. **Guardar en la carpeta correcta**:
   ```
   assets/sprites/enemies/
   ```

4. **Verificar transparencia**:
   - Asegurarse de que el fondo es transparente
   - Probar en Godot que se vea correctamente

---

## 🎮 Integración en el Juego

Una vez que tengas los sprites:

1. **Crear `EnemyData.gd`** (similar a `UnitData.gd`):
   ```gdscript
   enum EnemyType {
       GOBLIN_ARCHER,    # Ranged
       GOBLIN_DAGGER,    # Mele
       GOBLIN_SHIELD     # Tank
   }
   ```

2. **Agregar función para obtener sprite path**:
   ```gdscript
   static func get_enemy_sprite_path(enemy_type: EnemyType) -> String:
       match enemy_type:
           EnemyType.GOBLIN_ARCHER:
               return "res://assets/sprites/enemies/goblin_archer_idle.png"
           EnemyType.GOBLIN_DAGGER:
               return "res://assets/sprites/enemies/goblin_dagger_idle.png"
           EnemyType.GOBLIN_SHIELD:
               return "res://assets/sprites/enemies/goblin_shield_idle.png"
   ```

3. **Definir stats de cada enemigo**:
   - **Goblin Archer:** Bajo HP, Medio ataque, Rango 3
   - **Goblin Dagger:** Medio HP, Alto ataque, Rango 1
   - **Goblin Shield:** Alto HP, Bajo ataque, Rango 1

---

## 💡 Tips Adicionales

1. **Consistencia visual:**
   - Todos los goblins deben tener la misma altura aproximada
   - Misma paleta de colores base (verde para piel)
   - Mismo estilo de pixel art

2. **Diferenciación clara:**
   - El arco debe ser obvio en el arquero
   - La daga debe ser visible en el asesino
   - El escudo debe ser prominente en el tanque

3. **Iteración:**
   - Si un sprite no te gusta, prueba variaciones del prompt
   - Puedes combinar elementos de diferentes generaciones
   - Ajusta detalles específicos en el prompt

4. **Testing:**
   - Prueba los sprites en Godot antes de finalizar
   - Verifica que se vean bien a diferentes escalas
   - Asegúrate de que sean distinguibles en combate

---

**¡Listo para generar tus enemigos goblin! 🎮**

