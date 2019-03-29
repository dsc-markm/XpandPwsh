function Update-ProjectTargetFramework {
    [CmdletBinding()]
    param (
        [ValidateSet("4.5.2","4.6.1","4.7.1")]
        $FrameworkVersion="4.6.1"
    )
    
    begin {
    }
    
    process {
        $allProjects=Get-Project -All
        $allProjects
        $activity="Changing TargetFramework to $FrameworkVersion"
        $activity
        $dte=($allProjects|Select-Object -First 1 ).Dte
        $solutionFile=$dte.Solution.Filename
        $allProjects|ForEach-Object{
            $projectName=$_.ProjectName
            [xml]$csproj=Get-Content $_.FullName
            $csproj.Project.PropertyGroup|Where-Object{$_["TargetFrameworkVersion"]}|ForEach-Object{
                "Changing $projectName $($_.TargetFrameworkVersion) to $FrameWorkVersion"
                $_.TargetFrameworkVersion="v$FrameworkVersion"
            }
            $csproj.Save($_.FullName)
        }
        "Closing solution $($dte.Solution.FileName)"
        $dte.Solution.Close($true)
        "Opening solution $solutionFile"
        $dte.Solution.Open($solutionFile)
    }
    
    end {
    }
}