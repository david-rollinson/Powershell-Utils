# Path to copy specified frames in the format U:/path/to/my/file.%0d.exr inside a text file into a destination folder. File paths should be separated by a line break.

# User define the path to the text file containing the list of file paths. 
$fileListPath = Read-Host "Please provide a path to a file list in .txt format"

# User define the destination folder to which files will be copied.
$destinationFolder = Read-Host "Please specify the destination folder"

# Read file paths from .txt file.
$filePaths = Get-Content -Path $fileListPath

# Loop through each file path template.
foreach ($filePathTemplate in $filePaths) {
    # Replace %04d placeholder with wildcard pattern *
    $wildcardPath = $filePathTemplate -replace "%04d", "*"

    # Get all files matching wildcard path.
    $files = Get-ChildItem -Path $wildcardPath -File -ErrorAction SilentlyContinue

    # Loop through each matching file and copy it to the destination folder.
    foreach ($file in $files) {
        # Define destination path for file.
        $destinationPath = Join-Path -Path $destinationFolder -ChildPath $file.Name
        # Copy file to destination folder.
        Copy-Item -Path $file.FullName -Destination $destinationPath -Force
        Write-Output "Copied $($file.FullName) to $destinationPath"
    }
}