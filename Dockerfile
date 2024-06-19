# Utiliser une image de base officielle Python
FROM python:3.9-slim

# Définir le répertoire de travail
WORKDIR /app

# Copier le fichier requirements.txt dans le conteneur
COPY requirements.txt .

# Installer les dépendances
RUN pip install --upgrade pip && \
    pip install -r requirements.txt --no-cache-dir

# Télécharger et installer les certificats SSL
RUN apt-get update && apt-get install -y wget && \
    wget https://letsencrypt.org/certs/lets-encrypt-r3.pem -O /usr/local/share/ca-certificates/lets-encrypt-r3.crt && \
    wget https://letsencrypt.org/certs/isrg-root-x1-cross-signed.pem -O /usr/local/share/ca-certificates/isrg-root-x1-cross-signed.crt && \
    update-ca-certificates

# Copier le reste des fichiers de l'application dans le conteneur
COPY . .

# Exposer le port si nécessaire (adapter le port en fonction de votre application)
EXPOSE 8080

# Définir la commande pour démarrer l'application
CMD ["python", "tradingbot.py"]
