#!/bin/sh

echo "🚀 Starting container..."

# Initialize migrations only if missing
if [ ! -d "migrations" ]; then
  echo "📦 Initializing migrations..."
  flask db init
fi

# Ensure versions folder exists
mkdir -p migrations/versions

# Auto create migration if none exists
if [ -z "$(ls -A migrations/versions 2>/dev/null)" ]; then
  echo "🧱 Creating initial migration..."
  flask db migrate -m "initial migration"
fi

# Apply migrations
echo "⬆️ Applying migrations..."
flask db upgrade

echo "🔥 Starting Flask app..."
gunicorn -b 0.0.0.0:5000 --access-logfile - \
  --error-logfile - \
  --log-level info \
run:app