Push-Location $PSScriptRoot

if (Test-Path ".\out\upload")
{
	Remove-Item -Recurse -Force ".\out\upload"
}

New-Item -Path ".\out\upload" -ItemType Directory
New-Item -Path ".\out\upload\winui3_x86" -ItemType Directory
New-Item -Path ".\out\upload\winui3_x86_checked" -ItemType Directory
New-Item -Path ".\out\upload\winui3_x86_debug" -ItemType Directory
New-Item -Path ".\out\upload\winui3_x64" -ItemType Directory
New-Item -Path ".\out\upload\winui3_x64_debug" -ItemType Directory
New-Item -Path ".\out\upload\winui3_x64_checked" -ItemType Directory
New-Item -Path ".\out\upload\winui3_arm64" -ItemType Directory
New-Item -Path ".\out\upload\winui3_arm64_checked" -ItemType Directory
New-Item -Path ".\out\upload\winui3_arm64_debug" -ItemType Directory

Copy-Item ".\out\Release_x86\libEGL.dll" -Destination ".\out\upload\winui3_x86\libEGL.dll"
Copy-Item ".\out\Release_x86\libEGL.dll.pdb" -Destination ".\out\upload\winui3_x86\libEGL.dll.pdb"
Copy-Item ".\out\Release_x86\libGLESv2.dll" -Destination ".\out\upload\winui3_x86\libGLESv2.dll"
Copy-Item ".\out\Release_x86\libGLESv2.dll.pdb" -Destination ".\out\upload\winui3_x86\libGLESv2.dll.pdb"
Copy-Item ".\out\Release_x86\libGLESv1_CM.dll" -Destination ".\out\upload\winui3_x86\libGLESv1_CM.dll"
Copy-Item ".\out\Release_x86\libGLESv1_CM.dll.pdb" -Destination ".\out\upload\winui3_x86\libGLESv1_CM.dll.pdb"

Copy-Item ".\out\Checked_x86\libEGL.dll" -Destination ".\out\upload\winui3_x86_checked\libEGL.dll"
Copy-Item ".\out\Checked_x86\libEGL.dll.pdb" -Destination ".\out\upload\winui3_x86_checked\libEGL.dll.pdb"
Copy-Item ".\out\Checked_x86\libGLESv2.dll" -Destination ".\out\upload\winui3_x86_checked\libGLESv2.dll"
Copy-Item ".\out\Checked_x86\libGLESv2.dll.pdb" -Destination ".\out\upload\winui3_x86_checked\libGLESv2.dll.pdb"
Copy-Item ".\out\Checked_x86\libGLESv1_CM.dll" -Destination ".\out\upload\winui3_x86_checked\libGLESv1_CM.dll"
Copy-Item ".\out\Checked_x86\libGLESv1_CM.dll.pdb" -Destination ".\out\upload\winui3_x86_checked\libGLESv1_CM.dll.pdb"

Copy-Item ".\out\Debug_x86\libEGL.dll" -Destination ".\out\upload\winui3_x86_debug\libEGL.dll"
Copy-Item ".\out\Debug_x86\libEGL.dll.pdb" -Destination ".\out\upload\winui3_x86_debug\libEGL.dll.pdb"
Copy-Item ".\out\Debug_x86\libGLESv2.dll" -Destination ".\out\upload\winui3_x86_debug\libGLESv2.dll"
Copy-Item ".\out\Debug_x86\libGLESv2.dll.pdb" -Destination ".\out\upload\winui3_x86_debug\libGLESv2.dll.pdb"
Copy-Item ".\out\Debug_x86\libGLESv1_CM.dll" -Destination ".\out\upload\winui3_x86_debug\libGLESv1_CM.dll"
Copy-Item ".\out\Debug_x86\libGLESv1_CM.dll.pdb" -Destination ".\out\upload\winui3_x86_debug\libGLESv1_CM.dll.pdb"

Copy-Item ".\out\Release_x64\libEGL.dll" -Destination ".\out\upload\winui3_x64\libEGL.dll"
Copy-Item ".\out\Release_x64\libEGL.dll.pdb" -Destination ".\out\upload\winui3_x64\libEGL.dll.pdb"
Copy-Item ".\out\Release_x64\libGLESv2.dll" -Destination ".\out\upload\winui3_x64\libGLESv2.dll"
Copy-Item ".\out\Release_x64\libGLESv2.dll.pdb" -Destination ".\out\upload\winui3_x64\libGLESv2.dll.pdb"
Copy-Item ".\out\Release_x64\libGLESv1_CM.dll" -Destination ".\out\upload\winui3_x64\libGLESv1_CM.dll"
Copy-Item ".\out\Release_x64\libGLESv1_CM.dll.pdb" -Destination ".\out\upload\winui3_x64\libGLESv1_CM.dll.pdb"

Copy-Item ".\out\Checked_x64\libEGL.dll" -Destination ".\out\upload\winui3_x64_checked\libEGL.dll"
Copy-Item ".\out\Checked_x64\libEGL.dll.pdb" -Destination ".\out\upload\winui3_x64_checked\libEGL.dll.pdb"
Copy-Item ".\out\Checked_x64\libGLESv2.dll" -Destination ".\out\upload\winui3_x64_checked\libGLESv2.dll"
Copy-Item ".\out\Checked_x64\libGLESv2.dll.pdb" -Destination ".\out\upload\winui3_x64_checked\libGLESv2.dll.pdb"
Copy-Item ".\out\Checked_x64\libGLESv1_CM.dll" -Destination ".\out\upload\winui3_x64_checked\libGLESv1_CM.dll"
Copy-Item ".\out\Checked_x64\libGLESv1_CM.dll.pdb" -Destination ".\out\upload\winui3_x64_checked\libGLESv1_CM.dll.pdb"

Copy-Item ".\out\Debug_x64\libEGL.dll" -Destination ".\out\upload\winui3_x64_debug\libEGL.dll"
Copy-Item ".\out\Debug_x64\libEGL.dll.pdb" -Destination ".\out\upload\winui3_x64_debug\libEGL.dll.pdb"
Copy-Item ".\out\Debug_x64\libGLESv2.dll" -Destination ".\out\upload\winui3_x64_debug\libGLESv2.dll"
Copy-Item ".\out\Debug_x64\libGLESv2.dll.pdb" -Destination ".\out\upload\winui3_x64_debug\libGLESv2.dll.pdb"
Copy-Item ".\out\Debug_x64\libGLESv1_CM.dll" -Destination ".\out\upload\winui3_x64_debug\libGLESv1_CM.dll"
Copy-Item ".\out\Debug_x64\libGLESv1_CM.dll.pdb" -Destination ".\out\upload\winui3_x64_debug\libGLESv1_CM.dll.pdb"

Copy-Item ".\out\Release_arm64\libEGL.dll" -Destination ".\out\upload\winui3_arm64\libEGL.dll"
Copy-Item ".\out\Release_arm64\libEGL.dll.pdb" -Destination ".\out\upload\winui3_arm64\libEGL.dll.pdb"
Copy-Item ".\out\Release_arm64\libGLESv2.dll" -Destination ".\out\upload\winui3_arm64\libGLESv2.dll"
Copy-Item ".\out\Release_arm64\libGLESv2.dll.pdb" -Destination ".\out\upload\winui3_arm64\libGLESv2.dll.pdb"
Copy-Item ".\out\Release_arm64\libGLESv1_CM.dll" -Destination ".\out\upload\winui3_arm64\libGLESv1_CM.dll"
Copy-Item ".\out\Release_arm64\libGLESv1_CM.dll.pdb" -Destination ".\out\upload\winui3_arm64\libGLESv1_CM.dll.pdb"

Copy-Item ".\out\Checked_arm64\libEGL.dll" -Destination ".\out\upload\winui3_arm64_checked\libEGL.dll"
Copy-Item ".\out\Checked_arm64\libEGL.dll.pdb" -Destination ".\out\upload\winui3_arm64_checked\libEGL.dll.pdb"
Copy-Item ".\out\Checked_arm64\libGLESv2.dll" -Destination ".\out\upload\winui3_arm64_checked\libGLESv2.dll"
Copy-Item ".\out\Checked_arm64\libGLESv2.dll.pdb" -Destination ".\out\upload\winui3_arm64_checked\libGLESv2.dll.pdb"
Copy-Item ".\out\Checked_arm64\libGLESv1_CM.dll" -Destination ".\out\upload\winui3_arm64_checked\libGLESv1_CM.dll"
Copy-Item ".\out\Checked_arm64\libGLESv1_CM.dll.pdb" -Destination ".\out\upload\winui3_arm64_checked\libGLESv1_CM.dll.pdb"

Copy-Item ".\out\Debug_arm64\libEGL.dll" -Destination ".\out\upload\winui3_arm64_debug\libEGL.dll"
Copy-Item ".\out\Debug_arm64\libEGL.dll.pdb" -Destination ".\out\upload\winui3_arm64_debug\libEGL.dll.pdb"
Copy-Item ".\out\Debug_arm64\libGLESv2.dll" -Destination ".\out\upload\winui3_arm64_debug\libGLESv2.dll"
Copy-Item ".\out\Debug_arm64\libGLESv2.dll.pdb" -Destination ".\out\upload\winui3_arm64_debug\libGLESv2.dll.pdb"
Copy-Item ".\out\Debug_arm64\libGLESv1_CM.dll" -Destination ".\out\upload\winui3_arm64_debug\libGLESv1_CM.dll"
Copy-Item ".\out\Debug_arm64\libGLESv1_CM.dll.pdb" -Destination ".\out\upload\winui3_arm64_debug\libGLESv1_CM.dll.pdb"


$compress = @{
  Path = ".\out\upload\winui3_x86\libEGL.dll", ".\out\upload\winui3_x86\libGLESv2.dll"
  CompressionLevel = "Optimal"
  DestinationPath = ".\out\upload\winui3_x86.zip"
}
Compress-Archive @compress

$compress = @{
  Path = ".\out\upload\winui3_x86\libGLESv1_CM.dll"
  CompressionLevel = "Optimal"
  DestinationPath = ".\out\upload\winui3_x86_extra_gles1.zip"
}
Compress-Archive @compress

$compress = @{
  Path = ".\out\upload\winui3_x86\libEGL.dll.pdb", ".\out\upload\winui3_x86\libGLESv2.dll.pdb", ".\out\upload\winui3_x86\libGLESv1_CM.dll.pdb"
  CompressionLevel = "Optimal"
  DestinationPath = ".\out\upload\winui3_x86_extra_symbols.zip"
}
Compress-Archive @compress

$compress = @{
  Path = ".\out\upload\winui3_x86_checked\libEGL.dll", ".\out\upload\winui3_x86_checked\libEGL.dll.pdb", ".\out\upload\winui3_x86_checked\libGLESv2.dll", ".\out\upload\winui3_x86_checked\libGLESv2.dll.pdb", ".\out\upload\winui3_x86_checked\libGLESv1_CM.dll", ".\out\upload\winui3_x86_checked\libGLESv1_CM.dll.pdb"
  CompressionLevel = "Optimal"
  DestinationPath = ".\out\upload\winui3_x86_checked.zip"
}
Compress-Archive @compress

$compress = @{
  Path = ".\out\upload\winui3_x86_debug\libEGL.dll", ".\out\upload\winui3_x86_debug\libEGL.dll.pdb", ".\out\upload\winui3_x86_debug\libGLESv2.dll", ".\out\upload\winui3_x86_debug\libGLESv2.dll.pdb", ".\out\upload\winui3_x86_debug\libGLESv1_CM.dll", ".\out\upload\winui3_x86_debug\libGLESv1_CM.dll.pdb"
  CompressionLevel = "Optimal"
  DestinationPath = ".\out\upload\winui3_x86_debug.zip"
}
Compress-Archive @compress


$compress = @{
  Path = ".\out\upload\winui3_x64\libEGL.dll", ".\out\upload\winui3_x64\libGLESv2.dll"
  CompressionLevel = "Optimal"
  DestinationPath = ".\out\upload\winui3_x64.zip"
}
Compress-Archive @compress

$compress = @{
  Path = ".\out\upload\winui3_x64\libGLESv1_CM.dll"
  CompressionLevel = "Optimal"
  DestinationPath = ".\out\upload\winui3_x64_extra_gles1.zip"
}
Compress-Archive @compress

$compress = @{
  Path = ".\out\upload\winui3_x64\libEGL.dll.pdb", ".\out\upload\winui3_x64\libGLESv2.dll.pdb", ".\out\upload\winui3_x64\libGLESv1_CM.dll.pdb"
  CompressionLevel = "Optimal"
  DestinationPath = ".\out\upload\winui3_x64_extra_symbols.zip"
}
Compress-Archive @compress

$compress = @{
  Path = ".\out\upload\winui3_x64_checked\libEGL.dll", ".\out\upload\winui3_x64_checked\libEGL.dll.pdb", ".\out\upload\winui3_x64_checked\libGLESv2.dll", ".\out\upload\winui3_x64_checked\libGLESv2.dll.pdb", ".\out\upload\winui3_x64_checked\libGLESv1_CM.dll", ".\out\upload\winui3_x64_checked\libGLESv1_CM.dll.pdb"
  CompressionLevel = "Optimal"
  DestinationPath = ".\out\upload\winui3_x64_checked.zip"
}
Compress-Archive @compress

$compress = @{
  Path = ".\out\upload\winui3_x64_debug\libEGL.dll", ".\out\upload\winui3_x64_debug\libEGL.dll.pdb", ".\out\upload\winui3_x64_debug\libGLESv2.dll", ".\out\upload\winui3_x64_debug\libGLESv2.dll.pdb", ".\out\upload\winui3_x64_debug\libGLESv1_CM.dll", ".\out\upload\winui3_x64_debug\libGLESv1_CM.dll.pdb"
  CompressionLevel = "Optimal"
  DestinationPath = ".\out\upload\winui3_x64_debug.zip"
}
Compress-Archive @compress


$compress = @{
  Path = ".\out\upload\winui3_arm64\libEGL.dll", ".\out\upload\winui3_arm64\libGLESv2.dll"
  CompressionLevel = "Optimal"
  DestinationPath = ".\out\upload\winui3_arm64.zip"
}
Compress-Archive @compress

$compress = @{
  Path = ".\out\upload\winui3_arm64\libGLESv1_CM.dll"
  CompressionLevel = "Optimal"
  DestinationPath = ".\out\upload\winui3_arm64_extra_gles1.zip"
}
Compress-Archive @compress

$compress = @{
  Path = ".\out\upload\winui3_arm64\libEGL.dll.pdb", ".\out\upload\winui3_arm64\libGLESv2.dll.pdb", ".\out\upload\winui3_arm64\libGLESv1_CM.dll.pdb"
  CompressionLevel = "Optimal"
  DestinationPath = ".\out\upload\winui3_arm64_extra_symbols.zip"
}
Compress-Archive @compress

$compress = @{
  Path = ".\out\upload\winui3_arm64_checked\libEGL.dll", ".\out\upload\winui3_arm64_checked\libEGL.dll.pdb", ".\out\upload\winui3_arm64_checked\libGLESv2.dll", ".\out\upload\winui3_arm64_checked\libGLESv2.dll.pdb", ".\out\upload\winui3_arm64_checked\libGLESv1_CM.dll", ".\out\upload\winui3_arm64_checked\libGLESv1_CM.dll.pdb"
  CompressionLevel = "Optimal"
  DestinationPath = ".\out\upload\winui3_arm64_checked.zip"
}
Compress-Archive @compress

$compress = @{
  Path = ".\out\upload\winui3_arm64_debug\libEGL.dll", ".\out\upload\winui3_arm64_debug\libEGL.dll.pdb", ".\out\upload\winui3_arm64_debug\libGLESv2.dll", ".\out\upload\winui3_arm64_debug\libGLESv2.dll.pdb", ".\out\upload\winui3_arm64_debug\libGLESv1_CM.dll", ".\out\upload\winui3_arm64_debug\libGLESv1_CM.dll.pdb"
  CompressionLevel = "Optimal"
  DestinationPath = ".\out\upload\winui3_arm64_debug.zip"
}
Compress-Archive @compress
