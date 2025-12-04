#!/bin/bash
# Crear un icono SVG simple y convertirlo a PNG

convert -size 1024x1024 xc:'#1E88E5' \
  -gravity center \
  \( -size 700x700 xc:none -draw "fill white circle 350,350 350,50" \) -composite \
  \( -size 500x500 xc:none -draw "fill #1E88E5 path 'M 250,150 Q 150,250 250,350 Q 350,250 250,150 Z'" \) -composite \
  assets/icon/app_icon.png 2>/dev/null

if [ $? -ne 0 ]; then
  echo "ImageMagick no está disponible. Creando icono simple con Python..."
  python3 << 'PYTHON_EOF'
from PIL import Image, ImageDraw
import os

# Crear imagen de 1024x1024 con fondo azul
img = Image.new('RGB', (1024, 1024), color='#1E88E5')
draw = ImageDraw.Draw(img)

# Dibujar círculo blanco
draw.ellipse([162, 162, 862, 862], fill='white')

# Dibujar gota de agua (simplificada)
draw.ellipse([312, 262, 712, 662], fill='#1E88E5')
draw.polygon([(512, 212), (412, 462), (612, 462)], fill='#1E88E5')

# Guardar
os.makedirs('assets/icon', exist_ok=True)
img.save('assets/icon/app_icon.png')
print("Icono creado exitosamente!")
PYTHON_EOF
fi
