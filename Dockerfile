
FROM python:3.9-slim

# 1. Create working folder and install dependencies
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 2. Copy the application contents
COPY service/ ./service/

# 3. Switch to a non-root user (Security Best Practice)
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# 4. Run the service
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]	
