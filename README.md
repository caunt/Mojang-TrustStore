# ⚠️ Failed to log in: The authentication servers are currently down for maintenance on Java 8 (≤1.16.5)

[**Reddit Post**](https://www.reddit.com/r/Minecraft/comments/1nxagcd/fix_the_authentication_servers_are_currently_down/)

On 3 October 2025, 14:00 UTC the TLS certificate for `sessionserver.mojang.com` has been changed, causing the **“The authentication servers are currently down for maintenance”** error on all Minecraft versions up to **1.16.5** (Java 8).

The root cause is that Java 8 (before 8u91) default trust store lacks the DigiCert Global Root G2 that now anchors *.mojang.com (issued by Microsoft Azure RSA TLS Issuing CA 04).

_Mojangs may fix this by switching back to a root bundled with Java 8._

As a temporary fix - users can tell the JVM to use trust store that includes DigiCert Global Root G2.

# 🔧 BUILD

If you'd like to build your own trust store, run the `build.ps1` script. You'll find fresh trust store at `build\mojang-trust.jks`.

# ✅ FIX

1) [**Download**](https://github.com/caunt/Mojang-TrustStore/raw/refs/heads/main/mojang-trust.jks) this trust store that includes DigiCert Global Root G2

2) Add the following JVM arguments in whatever launcher you use:

```bash
-Djavax.net.ssl.trustStore="C:\mojang-trust.jks" -Djavax.net.ssl.trustStorePassword=changeit -Djdk.tls.client.protocols=TLSv1.2
```

Simply save the file above on disk C:\ as I did and use exactly same JVM arguments or update the file path to where you saved it.