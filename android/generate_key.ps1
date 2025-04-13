# Extract values
$storeFile     = "fluttertemplateproj_key.jks"
$storePassword = "XXXXXXX" #Must be the same as in gradle.properties
$keyAlias      = "fluttertemplateproj"
$keyPassword   = "XXXXXXX" #Must be the same as in gradle.properties

# Distinguished Name (customize as needed)
$dname = "CN=Connor DK, OU=Dev, O=Connor DK, L=Sydney, ST=NSW, C=AU"

# Step 1: Generate the keystore
Write-Host "Generating keystore '$storeFile' with alias '$keyAlias'..."
keytool -genkeypair -v `
  -keystore $storeFile `
  -alias $keyAlias `
  -keyalg RSA `
  -keysize 2048 `
  -validity 10000 `
  -storepass $storePassword `
  -keypass $keyPassword `
  -dname $dname

# Step 2: Extract SHA-1 and SHA-256
Write-Host "Retrieving certificate fingerprints..."
$fingerprintOutput = keytool -list -v `
  -keystore $storeFile `
  -alias $keyAlias `
  -storepass $storePassword

# Step 3: Extract SHA1 and SHA256 using regex
$sha1 = ($fingerprintOutput | Select-String "SHA1:" | ForEach-Object { $_.ToString().Split(":",2)[1].Trim() })
$sha256 = ($fingerprintOutput | Select-String "SHA256:" | ForEach-Object { $_.ToString().Split(":",2)[1].Trim() })

Write-Host "SHA Fingerprints:"
Write-Host "SHA-1:   $sha1"
Write-Host "SHA-256: $sha256"
