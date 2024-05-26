FROM python:3.8-slim

WORKDIR /app

# Copia y instala solo las dependencias esenciales primero
COPY requirements.txt /app/requirements.txt
RUN pip3 install --no-cache-dir -r requirements.txt

# Luego copia el resto del código de la aplicación
COPY . .

# Exponer el puerto 8080
EXPOSE 8080

# Comando por defecto para ejecutar la aplicación
CMD ["python3", "app.py"]
