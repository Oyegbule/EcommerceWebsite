#!/usr/bin/env bash
# exit on error
set -o errexit

# Install Python packages
pip install -r requirements.txt



# Build Tailwind CSS
npm install
npx tailwindcss -i ./static/src/style.css -o ./static/dist/style.css --minify

# Collect static files and run database migrations
python manage.py collectstatic --no-input
python manage.py migrate



python manage.py shell <<EOF
from django.contrib.auth import get_user_model
User = get_user_model()

# EDIT THESE TWO LINES:
username = 'Esther'
password = 'Esther12'
email = 'admin@example.com'

if not User.objects.filter(username=username).exists():
    User.objects.create_superuser(username, email, password)
    print(f"Superuser '{username}' created successfully!")
else:
    print(f"Superuser '{username}' already exists.")
EOF