# Start with Python 3.9 image
FROM python:3.9

# Set the working directory
WORKDIR /app/backend

# Copy requirements and install system dependencies
COPY requirements.txt /app/backend
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies in one command
RUN pip install mysqlclient && pip install --no-cache-dir -r requirements.txt

# Copy all app files
COPY . /app/backend

# Expose the Django port
EXPOSE 8000

# Run migrations (optional)
# Uncomment these lines if you want to run migrations as part of the build
# RUN python manage.py makemigrations
# RUN python manage.py migrate

# Start the Django application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
