# Use an official lightweight Python image
FROM python:3.14-slim

# Set the working directory inside the container
WORKDIR /app

# Copy Python dependencies
COPY requirements.txt .

# Install application dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy Flask application code
COPY app/ ./app/

# Document the port used by the application
EXPOSE 5000

# Check whether the Flask application is healthy
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/health', timeout=3)"

# Start the Flask application
CMD ["python", "app/app.py"]
