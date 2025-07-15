$certs = Get-ChildItem -Path Cert:\LocalMachine\My
$result = @()

foreach ($cert in $certs) {
    # Extrai o CN usando regex para capturar tudo entre CN= e ", OU=" ou até o final
    if ($cert.Subject -match 'CN=(.*?)(, OU=|$)') {
        $cn = $matches[1]
    } else {
        # Fallback para o método anterior se o padrão não for encontrado
        $cn = $cert.Subject -replace '.*CN=([^,]+).*', '$1'
    }
    
    # Remove barras invertidas, aspas duplas, etc.
    $cn = $cn.TrimStart('\').Replace('"', '').Replace('\\', '')
    
    # Verifica se a data de expiração do certificado é no futuro
    if ($cert.NotAfter -gt (Get-Date)) {
        $result += @{
            "{#CERTCN}" = $cn
            "{#THUMBPRINT}" = $cert.Thumbprint
        }
    }
}
$json = @{ data = $result } | ConvertTo-Json -Depth 3
Write-Output $json