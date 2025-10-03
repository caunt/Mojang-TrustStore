# ⚠️ Failed to log in: The authentication servers are currently down for maintenance on Java 8 (≤1.16.5)

[**Reddit Post**](https://www.reddit.com/r/Minecraft/comments/1nxagcd/fix_the_authentication_servers_are_currently_down/)

At 3 October 2025, 14:00 the TLS certificate for `sessionserver.mojang.com` has been changed, causing the **“The authentication servers are currently down for maintenance”** error on all Minecraft versions up to **1.16.5** (Java 8).

The root cause is that the default **Java 8** truststore doesn’t include the Microsoft **Azure RSA TLS Issuing CA 04** chain now used by `*.mojang.com`.

Mojangs may fix this by switching back to a CA bundled with Java 8.

## FIX

[**Download**](https://github.com/caunt/Mojang-TrustStore/raw/refs/heads/main/mojang-trust.jks) this truststore that includes the issuer certificates (Microsoft intermediate + DigiCert root) and pass these JVM arguments in your launcher:

```bash
-Djavax.net.ssl.trustStore="C:\mojang-trust.jks" -Djavax.net.ssl.trustStorePassword=changeit -Djdk.tls.client.protocols=TLSv1.2
```

Replace `C:\mojang-trust.jks` with the path where you saved the truststore.
