# UbuntuBackup

Connectez-vous à la console des développeurs Google (https://console.developers.google.com/) et créez un nouveau projet.

Dans le projet, activez l'API Google Drive.

Créez des identifiants pour l'API Google Drive en utilisant la fonction "Create Credentials" de la console des développeurs. Sélectionnez "OAuth client ID" et choisissez "Desktop App" comme type d'application.

Téléchargez le fichier JSON contenant les informations d'identification de l'API Google Drive.
Installez le paquet "google-auth" et le paquet "google-api-python-client" en utilisant la commande suivante :

    pip install google-auth google-auth-oauthlib google-auth-httplib2 google-api-python-client

Utilisez backup.py pour créer votre script de sauvegarde. Assurez-vous de remplacer les valeurs des variables CLIENT_SECRET_FILE, API_NAME, API_VERSION, FILE_PATH et FILE_NAME par vos propres valeurs.

Donnez-lui les permissions d'exécution avec la commande suivante :


    chmod +x Backup.py

Pour exécuter le script, utilisez la commande suivante :

    ./Backup.py

Cela va vous demander de vous connecter à votre compte Google et de donner l'autorisation d'accéder à votre espace de stockage Google Drive. Après cela, le script téléchargera le fichier spécifié sur votre espace de stockage Google Drive.
