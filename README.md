# ⚠️ Failed to log in: The authentication servers are currently down for maintenance on Java 8 (≤1.16.5)

[**Reddit Post**](https://www.reddit.com/r/Minecraft/comments/1nxagcd/fix_the_authentication_servers_are_currently_down/)

At 3 October 2025, 14:00 UTC the TLS certificate for `sessionserver.mojang.com` has been changed, causing the **“The authentication servers are currently down for maintenance”** error on all Minecraft versions up to **1.16.5** (Java 8).

The root cause is that default Java 8 (before 8u91) default truststore lacks the DigiCert Global Root G2 that now anchors *.mojang.com (issued by Microsoft Azure RSA TLS Issuing CA 04).

Mojangs may fix this by switching back to a CA bundled with Java 8.

# ✅ FIX

1) [**Download**](https://github.com/caunt/Mojang-TrustStore/raw/refs/heads/main/mojang-trust.jks) this trust store that includes DigiCert Global Root G2

2) Add the following JVM arguments in whatever launcher you use:

```bash
-Djavax.net.ssl.trustStore="C:\mojang-trust.jks" -Djavax.net.ssl.trustStorePassword=changeit -Djdk.tls.client.protocols=TLSv1.2
```

Simply save the file above on disk C:\ as I did and use exactly same JVM arguments or update the file path to where you saved it.
