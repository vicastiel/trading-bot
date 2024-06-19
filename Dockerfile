# Utiliser une image de base officielle Python
FROM python:3.10-slim

# Définir le répertoire de travail
WORKDIR /app

# Copier le fichier requirements.txt dans le conteneur
COPY requirements.txt .

# Installer les dépendances
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copier le reste des fichiers de l'application dans le conteneur
COPY . .

# Exposer le port si nécessaire (adapter le port en fonction de votre application)
EXPOSE 8080

# Définir la commande pour démarrer l'application
CMD ["python", "tradingbot.py"]
