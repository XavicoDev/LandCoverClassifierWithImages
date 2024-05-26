# Utilizar una imagen base oficial de Python 3.8 slim
FROM python:3.8-slim

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar solo requirements.txt primero para aprovechar el caché de Docker
COPY requirements.txt /app/requirements.txt

# Instalar las dependencias del proyecto
RUN pip3 install --no-cache-dir -r requirements.txt

# Copiar el resto del código de la aplicación
COPY . .

# Exponer el puerto 8080
EXPOSE 8080

# Comando por defecto para ejecutar la aplicación
CMD ["python3", "app.py"]
