# Usa una imagen base de Python
FROM python:3.6-slim

# Actualiza pip a la última versión
RUN /usr/local/bin/python -m pip install --upgrade pip

# Establece el directorio de trabajo en /app
WORKDIR /app

# Copia el archivo requirements.txt a la imagen de Docker en /app
COPY requirements.txt /app

# Instala las dependencias necesarias
RUN pip install --no-cache-dir -r requirements.txt

# Copia el contenido de la aplicación a la imagen de Docker en /app
COPY . /app

# Expone el puerto en el que correrá la aplicación
EXPOSE 5000

# Define el comando por defecto para ejecutar la aplicación
CMD ["python", "app.py"]
