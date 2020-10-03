 Param(
   [Parameter(Mandatory=$true)]
   [string]$keyboard,
   [Parameter(Mandatory=$true)]
   [string]$keymap
) #end param


$serviceName = 'com.docker.service'


If (Get-Service $serviceName -ErrorAction SilentlyContinue) {

    If ((Get-Service $serviceName).Status -eq 'Running') {

        Write-Host "$serviceName Running"

        docker run --rm -w /qmk_firmware -v "$PWD`:/qmk_firmware`:rw" -e ALT_GET_KEYBOARDS=true -e SKIP_GIT="$SKIP_GIT" -e MAKEFLAGS="$MAKEFLAGS" qmkfm/base_container make "$keyboard`:$keymap"

		

    } Else {

        Write-Host "$serviceName found, but it is not running."
    }

} Else {
    Write-Host "$serviceName not found"
}


