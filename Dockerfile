FROM python:3.9-slim

# Variables de entorno
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Directorio inicial en el contenedor
WORKDIR /app

# Instalamos librerías del sistema
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Copiamos requirements e instalamos dependencias
COPY requirements.txt /app/
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copiamos TODO el proyecto
COPY . /app/

# Exponemos el puerto
EXPOSE 8000

# --- EL CAMBIO CLAVE ---
# Entramos a la carpeta 'backend' antes de ejecutar nada
WORKDIR /app/backend

# Ahora sí corremos el servidor
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]