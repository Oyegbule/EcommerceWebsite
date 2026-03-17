#!/usr/bin/env bash
# exit on error
set -o errexit

# Install Python packages
pip install -r requirements.txt

mkdir -p mediafiles

# Build Tailwind CSS
npm install
npx tailwindcss -i ./static/src/style.css -o ./static/dist/style.css --minify

# Collect static files and run database migrations
python manage.py collectstatic --no-input
python manage.py migrate