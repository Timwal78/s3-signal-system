FROM python:3.12-slim

WORKDIR /app

# Prevent glibc memory fragmentation (OOM Fix)
ENV MALLOC_ARENA_MAX=2
ENV PYTHONUNBUFFERED=1

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Drop to non-root user
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser
USER appuser

CMD ["python", "main.py"]
