
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
