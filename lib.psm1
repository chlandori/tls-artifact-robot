
function New-TlsCert {
    param(
        [string[]]$Domains,
        [string]$Email = "admin@example.com"
    )

    $domainArgs = $Domains | ForEach-Object { "-d $_" } -join " "
    docker run --rm `
        -v C:\letsencrypt:/etc/letsencrypt `
        tls-artifact-robot certbot certonly `
        --standalone -m $Email --agree-tos $domainArgs
}

function Renew-TlsCert {
    docker run --rm `
        -v C:\letsencrypt:/etc/letsencrypt `
        tls-artifact-robot certbot renew
}


function Renew-TlsCert {
    docker run --rm `
        -v C:\letsencrypt:/etc/letsencrypt `
        tls-artifact-robot certbot renew
}

