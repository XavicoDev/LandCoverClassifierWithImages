# Usa una imagen base de Python de Alpine Linux
FROM python:3.9-alpine

# Actualiza pip
RUN pip install --no-cache-dir --upgrade pip

# Instala las dependencias necesarias, incluyendo las dependencias de system
RUN apk add --no-cache \
    build-base \
    libffi-dev \
    openssl-dev \
    && pip install --no-cache-dir -r requirements.txt \
    && apk del build-base libffi-dev openssl-dev

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
