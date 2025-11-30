
# TLS Artifact Robot – PowerShell Module

This module provides a simple PowerShell interface to manage TLS certificates
using the `tls-artifact-robot` container. It exposes three core functions:

1. **New-TlsCert** – Create new certificates
2. **Renew-TlsCert** – Renew certificates on demand
3. **AutoRenew-TlsCert** – Schedule automatic renewals via Windows Task Scheduler

---

## 📦 Prerequisites

- Windows Server with PowerShell 5+ or PowerShell Core
- Docker installed and running
- `tls-artifact-robot` container image built or pulled locally
- A persistent volume for certificates (e.g. `C:\letsencrypt`)

``` powershell
# === Add current user to docker-users group ===
# Run this script in an elevated PowerShell session (Run as Administrator)

# Get the current username
$User = "$env:USERDOMAIN\$env:USERNAME"

# Add the user to the docker-users group
Add-LocalGroupMember -Group "docker-users" -Member $User

# Confirm membership
Get-LocalGroupMember -Group "docker-users"
```

---

## 🔧 Installation

1. Clone or download this repository.
2. Copy the module file `TlsArtifactRobot.psm1` to a working directory.
3. Import the module in PowerShell:

```powershell
   Import-Module .\TlsArtifactRobot.psm1
```

## 🚀 Usage

1. Create new 

``` powershell
New-TlsCert -Domains "core.example.com","www.core.example.com" -Email "admin@example.com"
```

* Issues a new certificate for the specified domains.
* Certificates are stored in the mounted volume (C:\letsencrypt)

2. Renew On-Demand

``` powershell
Renew-TlsCert
```

* Runs certbot renew inside the container.
* Certificates will only renew if they are within 30 days of expiry.
* Add --force-renewal inside the function if you want to override.

3. Schedule automatic renewal

``` powershell
AutoRenew-TlsCert
```

* Registers a Windows Scheduled Task named TLSAutoRenew.
* Runs daily at 3 AM to check and renew certificates.
* You can adjust the schedule by editing the function or task.


## Test Dry Run

``` powershell
docker run --rm -v C:\letsencrypt:/etc/letsencrypt tls-artifact-robot certbot renew --dry-run
``` 

