
$OutPath = "$env:USERPROFILE\Documents\ScreenShot"
if (-not (Test-Path $OutPath))
        {
            New-Item $OutPath -ItemType Directory -Force
        }
$FileName = "$env:COMPUTERNAME - $(get-date -f yyyy-MM-dd_HHmmss).png" # screenshot1: 2023-06-25_021833.png screenshot2023-06-25_021833.png

#$File = "$OutPath\$FileName"

# Join-Path is use to join 2 path and return a single absolute path of a file
$File = Join-Path $OutPath $fileName 

Add-Type -AssemblyName System.Windows.Forms
Add-type -AssemblyName System.Drawing

# Gather Screen resolution information
$Screen = [System.Windows.Forms.SystemInformation]::VirtualScreen
$Width = $Screen.Width
$Height = $Screen.Height
$Left = $Screen.Left
$Top = $Screen.Top

# Create bitmap using the top-left and bottom-right bounds
$bitmap = New-Object System.Drawing.Bitmap $Width, $Height

# Create Graphics object
$graphic = [System.Drawing.Graphics]::FromImage($bitmap)

# Capture screen
$graphic.CopyFromScreen($Left, $Top, 0, 0, $bitmap.Size)

# Save to file
$bitmap.Save($File)
 
#Write-Output "Screenshot saved to:"
Write-Output $File
