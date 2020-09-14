#!/usr/bin/env bash

appName=djangocapstone_app

sudo docker-compose run web django-admin startproject $appName .

# Change permission oon files
sudo chown -R $USER:$USER .

sudo docker-compose up