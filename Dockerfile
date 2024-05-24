# Usa una imagen base de Python
FROM python:3.6-slim

# Instala las herramientas de construcción necesarias
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Actualiza pip a la última versión
RUN /usr/local/bin/python -m pip install --upgrade pip

# Establece el directorio de trabajo en /app
WORKDIR /app

# Copia el archivo requirements.txt a la imagen de Docker en /app
COPY requirements.txt /app

# Instala las dependencias necesarias
RUN pip install requirements.txt

# Copia el contenido de la aplicación a la imagen de Docker en /app
COPY . /app

# Expone el puerto en el que correrá la aplicación
EXPOSE 5000

# Define el comando por defecto para ejecutar la aplicación
CMD ["python", "app.py"]
