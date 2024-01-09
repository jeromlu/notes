[CmdletBinding(PositionalBinding=$false)]

Param(
    # If specified, the script only removes the build outputs and exits.
    [Switch]$Clean,
    # If specified, the produced pdf file is opened in Sumatra pdf.
    [Switch]$ShowPdf
    #[Switch]$CreateHtml
)

# Quit on cmdlet errors.
$ErrorActionPreference = 'Stop'

$buildDirName = "build"
# Name of the file that will be compiled. Should be without '.tex' suffix.
$texFileName = "notes_main"
$outDocumentName = "ph_calc_notes"
$BUILD_DIR = "$PSScriptRoot\$buildDirName"

function Remove-ByForce {
    Remove-Item -Recurse -Force -ErrorAction SilentlyContinue @Args
}

if ($Clean) {
    #latexmk -c
    Remove-ByForce $BUILD_DIR
    Write-Host "Removed:`n'$BUILD_DIR'"
    exit
}

# Build.
New-Item -Force -ItemType directory -Path $BUILD_DIR
$sourceFile = "$PSScriptRoot/src/$texFileName.tex"
try {
    Write-Host "Source file:`n$sourceFile"
    Write-Host "Build dir:`n$buildDirName`n"
    # Using latexmk. Needs Perl distribution.
    #latexmk -pdf -lualatex -jobname="./$buildDirName/%A" $sourceFile -shell-escape
    latexmk -pdf -lualatex -jobname="./$buildDirName/$outDocumentName" $sourceFile -shell-escape
    # Alternative: pdflatex->bibtex->2 x pdflatex. No need for Perl :D.

    Write-Host "Source file:`n$sourceFile"
    Write-Host "Build dir:`n$buildDirName`n"
    # Needed only for sumatraPDF.
    Push-Location -Path $BUILD_DIR
    if ($CreateHtml) {
        "Create html. Not yet implemented."
        #mk4ht htlatex $sourceFile 'xhtml,charset=utf-8,pmathml' ' -cunihtf -utf8 -cvalidate'
    }
    if ($ShowPdf) {
        SumatraPDF.exe "$outDocumentName.pdf"
    }
}
finally {
    Pop-Location
}
