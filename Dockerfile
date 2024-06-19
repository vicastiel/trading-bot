FROM jupyter/scipy-notebook

# Définir le répertoire de travail
WORKDIR /home/jovyan/work

# Copier le fichier requirements.txt dans le conteneur
COPY requirements.txt .

# Exécuter en tant qu'utilisateur root pour les commandes apt-get
USER root

# Installer les dépendances
RUN apt-get update && apt-get install -y wget && \
    wget https://letsencrypt.org/certs/lets-encrypt-r3.pem -O /usr/local/share/ca-certificates/lets-encrypt-r3.crt && \
    wget https://letsencrypt.org/certs/isrg-root-x1-cross-signed.pem -O /usr/local/share/ca-certificates/isrg-root-x1-cross-signed.crt && \
    update-ca-certificates

# Revenir à l'utilisateur jovyan pour la suite des commandes
USER jovyan

# Installer les dépendances Python
RUN pip install --upgrade pip && \
    pip install -r requirements.txt --no-cache-dir

# Copier le reste des fichiers de l'application dans le conteneur
COPY . .

# Commande par défaut pour démarrer Jupyter Notebook
CMD ["jupyter", "notebook", "--ip='0.0.0.0'", "--port=8888", "--no-browser", "--allow-root"]
