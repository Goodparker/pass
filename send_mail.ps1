$ErrorActionPreference = "Stop"

$File = "C:\Output.txt"
$Log = "C:\mail_log.txt"

"==== START $(Get-Date) ====" | Out-File $Log -Append
"File: $File" | Out-File $Log -Append

try {
    if (!(Test-Path $File)) {
        throw "Файл не найден: $File"
    }

    $smtpServer = "smtp.gmail.com"
    $smtpPort = 587

    $from = "@@gmail.com"
    $to = "@@gmail.com"
    $subject = "TXT file"
    $body = "Файл во вложении."

    $username = "@@gmail.com"
    $password = "@"

    $securePassword = ConvertTo-SecureString $password -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential($username, $securePassword)

    "Sending email..." | Tee-Object -FilePath $Log -Append

    Send-MailMessage `
        -From $from `
        -To $to `
        -Subject $subject `
        -Body $body `
        -SmtpServer $smtpServer `
        -Port $smtpPort `
        -UseSsl `
        -Credential $credential `
        -Attachments $File

    "SUCCESS: письмо отправлено" | Tee-Object -FilePath $Log -Append
}
catch {
    "ERROR: $($_.Exception.Message)" | Tee-Object -FilePath $Log -Append
    $_ | Out-File $Log -Append
    exit 1
}

"==== END $(Get-Date) ====" | Out-File $Log -Append