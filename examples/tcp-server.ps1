$path = Split-Path -Parent -Path (Split-Path -Parent -Path $MyInvocation.MyCommand.Path)
Import-Module "$($path)/src/Pode.psm1" -Force -ErrorAction Stop

# or just:
# Import-Module Pode

# create a server, and start listening on port 8999
Start-PodeServer -Threads 2 {

    Add-PodeEndpoint -Address *:8999 -Protocol TCP

    # allow the local ip
    access allow ip 127.0.0.1

    # setup a tcp handler
    handler 'tcp' {
        param($session)
        Write-PodeTcpClient -Message 'gief data'
        $msg = (Read-PodeTcpClient)
        Write-Host $msg
    }

}