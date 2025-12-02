# tls-artifact-robot

A lightweight utility for Windows Server 2025 sysops to manage TLS certificates using **WSL2** and **Ubuntu LTS**.  
This project wraps [Certbot](https://certbot.eff.org/) inside WSL, outputting certificates directly to the Windows host at `C:\letsencrypt`.

---

## ✨ Features

- Runs inside **WSL2 Ubuntu LTS** environment on Windows Server 2025.
- Uses Certbot for certificate issuance and renewal.
- Supports **DNS-01 challenge** for private servers (no need to expose ports).
- Outputs certificates to the Windows host via `/mnt/c/letsencrypt` → `C:\letsencrypt`.
- Designed for sysops who want a clean, repeatable TLS ritual.

---

## 🚀 Usage

### Configure Windows Server Host

``` powershell
.\host-wsl-config.ps1
wsl
```

### Issue a New Certificate

Run the helper script with your email and domains:

```bash
./run-certbot-dns.sh admin@example.com app1.example.com
```

### Export to PFX with password

Exports from WSL to Windows Server C:\letsencrypt as a PFX (PKCS#12)

```bash
./export-to-pfx.sh app1.example.com
```
