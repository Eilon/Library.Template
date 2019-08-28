$dumpsPath = "$env:BUILD_ARTIFACTSTAGINGDIRECTORY/dumps"
if (!(Test-Path $dumpsPath)) { return }

# Take care to exclude any files whose size exceeds 4GB

@{
    "$dumpsPath" = (Get-ChildItem $dumpsPath -Recurse |? { $_.Length -lt (4*1024*1024*1024) })
}
