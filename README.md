# Getting Started From Flutter Template

1. Firstly find and replace all instances of fluttertemplateproj to your new app name using the script rename_project.ps1, you need to replace the newAppName with the newAppName.
2. All other values you will need to replace do so by CTRL+F for XXXXXXX.
3. Only pain point is Firebase. You need to create your app: set the SHA-1, SHA-256 from your key generation. It outputs it in the script, as well as adding the debug SHA-1/SHA-256 which are genned from a script in the same folder. You need to enter those creds in the script and the gradle.properties for your signing key add this to .gitignore afterwards as it will contain your key.
4. Once that’s all done you need to pull your google-services.json down and your Google-Info.Plist down for Apple. Register your app as allowed to login with apple.
5. For google you then need to go into google admin console and go to the credentials for the projects, it may not show in recent projects need to check all. Then go to the web client and get the client id and secret from there to put into backend.
