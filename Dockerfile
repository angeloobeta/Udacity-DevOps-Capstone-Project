FROM python:3.7-alpine

## Step 1:
# Create a working directory
WORKDIR /djangoproject


## Step 2:
# Copy source code to working directory
COPY ./requirements.txt /djangoproject/ 
COPY . /djangoproject/


## Step 3:
# Install packages from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

## Step 4:
# Expose port 8000
EXPOSE 8000

## Step 5:
# Run the django app at container launch
# CMD ["python", "manage.py", "runserver"]
CMD ["sh", "-c", "exec gunicorn djangocapstone_app.wsgi:application --bind 0.0.0.0:8000 --workers 3"]