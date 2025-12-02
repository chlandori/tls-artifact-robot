# requires administer privileges

param (
    [Parameter(Mandatory=$true)]
    [string]$Domain,
    [string]$PfxPath = "C:\letsencrypt\",
    [string]$CertStoreLocation = "Cert:\LocalMachine\My",
    [securestring]$PfxPassword
)

if (-not $PfxPassword) {
    $PfxPassword = Read-Host -AsSecureString "Enter PFX password"
}

# Import the PFX into LocalMachine\My
Import-PfxCertificate -FilePath "$PfxPath$Domain.pfx" `
    -CertStoreLocation $CertStoreLocation `
    -Password $PfxPassword

Start-Sleep -Seconds 2 # Wait for the certificate to be fully registered
# Get the thumbprint of the imported certificate
$certThumbprint = (Get-PfxCertificate -FilePath "$PfxPath$Domain.pfx" -Password $PfxPassword).Thumbprint

# Locate the certificate
$cert = Get-ChildItem -Path Cert:\LocalMachine\My | Where-Object { $_.Thumbprint -eq $certThumbprint }

# Get the private key file path
$keyName = $cert.PrivateKey.CspKeyContainerInfo.UniqueKeyContainerName
$keyPath = "C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys\$keyName"

# Create access rule
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule($userName, $permission, "Allow")

# Apply ACL
$acl = Get-Acl -Path $keyPath
$acl.AddAccessRule($rule)
Set-Acl -Path $keyPath -AclObject $acl

Write-Host "Access granted to $userName on $keyPath"
