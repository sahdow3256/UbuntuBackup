# UbuntuBackup

Connectez-vous à la console des développeurs Google (https://console.developers.google.com/) et créez un nouveau projet.

Dans le projet, activez l'API Google Drive.

Créez des identifiants pour l'API Google Drive en utilisant la fonction "Create Credentials" de la console des développeurs. Sélectionnez "OAuth client ID" et choisissez "Desktop App" comme type d'application.

Téléchargez le fichier JSON contenant les informations d'identification de l'API Google Drive.
Installez le paquet "google-auth" et le paquet "google-api-python-client" en utilisant la commande suivante :

    pip install google-auth google-auth-oauthlib google-auth-httplib2 google-api-python-client

Utilisez le code suivant pour créer votre script de sauvegarde automatique. Assurez-vous de remplacer les valeurs des variables CLIENT_SECRET_FILE, API_NAME, API_VERSION, FILE_PATH et FILE_NAME par vos propres valeurs.

    import os
    import sys
    import pickle
    import google.auth
    from google.oauth2.credentials import Credentials
    from googleapiclient.discovery import build
    from googleapiclient.errors import HttpError
    from google.auth.transport.requests import Request

    # Set up the credentials
    creds = None
    if os.path.exists('token.pickle'):
    with open('token.pickle', 'rb') as token:
        creds = pickle.load(token)
    if not creds or not creds.valid:
    if creds and creds.expired and creds.refresh_token:
        creds.refresh(Request())
    else:
        flow = google.auth.transport.requests.InstalledAppFlow.from_client_secrets_file(
            'CLIENT_SECRET_FILE.json', ['https://www.googleapis.com/auth/drive'])
        creds = flow.run_local_server(port=0)
    with open('token.pickle', 'wb') as token:
        pickle.dump(creds, token)

    # Create the Drive API client
     service = build('API_NAME', 'API_VERSION', credentials=creds)

    # Set the file path and file name of the file to upload
    file_path = 'FILE_PATH'
    file_name = 'FILE_NAME'

    # Upload the file to Google Drive
    file_metadata = {'name': file_name}
    media = googleapiclient.http.MediaFileUpload(file_path, resumable=True)
    file = service.files().create(body=file_metadata, media_body=media,
                              fields='id').execute()
    print(f'File ID: {file.get("id")}')

Enregistrez le script avec l'extension ".py" et donnez-lui les permissions d'exécution avec la commande suivante :


    chmod +x nom_du_script.py

Pour exécuter le script, utilisez la commande suivante :

    ./nom_du_script.py

Cela va vous demander de vous connecter à votre compte Google et de donner l'autorisation d'accéder à votre espace de stockage Google Drive. Après cela, le script téléchargera le fichier spécifié sur votre espace de stockage Google Drive.
