# Usa una imagen base de Python
FROM python:3.9-slim

# Actualiza pip
RUN pip install --no-cache-dir --upgrade pip

# Crea un entorno virtual
RUN python -m venv venv

# Instala las dependencias dentro del entorno virtual
RUN /bin/bash -c "source venv/bin/activate && pip install --no-cache-dir -r requirements.txt"

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
