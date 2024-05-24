from flask import Flask, render_template, request
import cv2
#import numpy as np
from tensorflow.keras.models import load_model

app = Flask(__name__,template_folder='template',static_folder='./template/static')

# Cargar el modelo entrenado
model = load_model("model/image_classifier_model.h5")

# Función para cargar una imagen y preprocesarla para la clasificación
def load_and_preprocess_image(image_path):
    img = cv2.imread(image_path)
    img = cv2.resize(img, (128, 128))  # Redimensionar la imagen a 128x128 píxeles (mismo tamaño que durante el entrenamiento)
    img = img / 255.0  # Normalizar los valores de píxeles al rango [0, 1]
    return img.reshape(1, 128, 128, 3)  # Agregar una dimensión adicional para la muestra

@app.route('/')
def index():
    return render_template('index.html', result=None)

@app.route('/upload', methods=['POST'])
def upload():
    # Verifica si se envió un archivo
    if 'file' not in request.files:
        return 'No se seleccionó ningún archivo'

    archivo = request.files['file']

    # Verifica si se seleccionó un archivo
    if archivo.filename == '':
        return 'No se seleccionó ningún archivo'

    # Verifica si el archivo es una imagen
    if archivo and archivo.filename.endswith(('.png', '.jpg', '.jpeg')):
        # Guarda el archivo en el servidor temporalmente
        ruta_temporal = 'template/static/uploaded_image.png'
        archivo.save(ruta_temporal)

        # Cargar y preprocesar la imagen
        image = load_and_preprocess_image(ruta_temporal)

        # Realizar la predicción
        predictions = model.predict(image)

        # Decodificar las predicciones
        label_map = {0: 'BANANO',
 1: 'CACAO',
 2: 'PASTIZAL',
 3: 'VEGETACIÓN SECUNDARIA',
 4: 'VÍAS DE ACCESO'}

        predicted_label = label_map[np.argmax(predictions)]

        return render_template('index.html', result=predicted_label)

    else:
        return 'El archivo seleccionado no es una imagen'

if __name__ == '__main__':
    app.run(debug=True)
