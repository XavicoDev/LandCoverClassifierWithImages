FROM python:3.8-slim

# Instala el paquete virtualenv
RUN pip install virtualenv

# Crea un directorio para el proyecto
WORKDIR /app

# Copia los archivos de requerimientos
COPY requirements.txt requirements.txt

# Crea y activa la virtual environment
RUN virtualenv venv
RUN . venv/bin/activate
RUN pip install --upgrade pip

# Instala las dependencias del proyecto
RUN pip install -r requirements.txt

# Copia el resto de los archivos de tu proyecto
COPY . .

# Expone el puerto si es necesario
EXPOSE 8080

# Comando para ejecutar la aplicación
CMD ["python3", "app.py"]
