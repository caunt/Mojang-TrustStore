$output = "build"
New-Item -ItemType Directory -Force -Path $output | Out-Null
Set-Location $output

# Download the exact issuers Mojang presents (intermediate + root)
Invoke-WebRequest 'http://www.microsoft.com/pkiops/certs/Microsoft%20Azure%20RSA%20TLS%20Issuing%20CA%2004%20-%20xsign.crt' -OutFile 'azure_issuing_ca_04.crt'
Invoke-WebRequest 'http://cacerts.digicert.com/DigiCertGlobalRootG2.crt' -OutFile 'digicert_global_root_g2.crt'

# Build a fresh JKS truststore containing ONLY the issuers (not the leaf)
Remove-Item -Force '.\mojang-trust.jks' -ErrorAction SilentlyContinue
$keytool = Join-Path ${env:JAVA_HOME} 'bin\keytool.exe'
if (-not (Test-Path $keytool)) { $keytool = 'keytool' } # fallback if JAVA_HOME not set

& $keytool -importcert -noprompt -alias azure_issuing_ca_04 -file 'azure_issuing_ca_04.crt' -keystore '.\mojang-trust.jks' -storepass changeit
& $keytool -importcert -noprompt -alias digicert_global_root_g2 -file 'digicert_global_root_g2.crt' -keystore '.\mojang-trust.jks' -storepass changeit