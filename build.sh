#!/usr/bin/env bash
# exit on error
set -o errexit

# 1. Install dependencies
pip install -r requirements.txt
npm install

# 2. Build CSS (Do this during build, not start!)
npx tailwindcss -i ./static/src/style.css -o ./static/dist/style.css --minify

# 3. Django maintenance
python manage.py collectstatic --no-input
python manage.py migrate

# 4. Superuser creation logic
python manage.py shell <<EOF
from django.contrib.auth import get_user_model
User = get_user_model()
if not User.objects.filter(username='Esther').exists():
    User.objects.create_superuser('Esther', 'admin@example.com', 'Esther12')
EOF