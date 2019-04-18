$ErrorActionPreference="Stop"
if (!(Get-Module PSMD -ListAvailable)){
    Install-Module PSMD
}
Import-Module PSMD
Remove-Item "$PSScriptRoot\..\ReadMe.md" -Force
New-PSMDDocument -Name ReadMe -OutputPath "$PSScriptRoot\.." -Content {
    Paragraph -Text "![](https://img.shields.io/powershellgallery/v/XpandPosh.svg?style=flat) ![](https://img.shields.io/powershellgallery/dt/XpandPosh.svg?style=flat)"
    Title -Text Installation -Size h1
    Paragraph -Text "``XpandPosh`` is available in ``PSGallery``. Open a powershell prompt and type:"
    CodeBlock -Lang ps1 -Code "Install-Module XpandPosh"
    Title -Text "Exported Functions-CmdLets" -Size h2
    CodeBlock -Lang ps1 -Code "Get-Command -Module XpandPosh"
    CodeBlock -Lang txt -Code "$($(Get-Command -Module XpandPosh|Sort-Object) -join "`r`n")"
}

if (git diff --name-only |Where-Object{$_ -like "*ReadMe.md"}){
    Write-Error "ReadMe changed" -ErrorAction Continue
    exit 1
}