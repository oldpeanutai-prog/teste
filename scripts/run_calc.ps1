# Requires -Version 5.1

function Write-Header {
    Write-Host "==============================================" -ForegroundColor Cyan
    Write-Host "      🧮 CALCULADORA PYTHON PARA WINDOWS 🧮      " -ForegroundColor Cyan
    Write-Host "==============================================" -ForegroundColor Cyan
}

function Write-Success([string]$message) {
    Write-Host "✔ $message" -ForegroundColor Green
}

function Write-ErrorMsg([string]$message) {
    Write-Host "✗ $message" -ForegroundColor Red
}

function Write-Info([string]$message) {
    Write-Host "ℹ $message" -ForegroundColor Cyan
}

function Write-WarningMsg([string]$message) {
    Write-Host "⚠ $message" -ForegroundColor Yellow
}

function Test-Command([string]$command) {
    $null = Get-Command $command -ErrorAction SilentlyContinue
    return $?
}

function Get-PythonCommand {
    if (Test-Command python) { return 'python' }
    if (Test-Command python3) { return 'python3' }
    if (Test-Command py) { return 'py -3' }
    return $null
}

function Install-Python {
    Write-Info "Tentando instalar a última versão do Python 3..."

    if (Test-Command winget) {
        Write-Info "Gerenciador detectado: winget"
        Write-Info "Instalando Python 3 via winget..."
        winget install --id Python.Python.3 -e --source winget --accept-package-agreements --accept-source-agreements
        return
    }

    if (Test-Command choco) {
        Write-Info "Gerenciador detectado: Chocolatey"
        Write-Info "Instalando Python 3 via choco..."
        choco install python -y
        return
    }

    Write-ErrorMsg "Nenhum gerenciador de pacotes suportado encontrado (winget ou choco)."
    Write-ErrorMsg "Instale o Python manualmente a partir de https://www.python.org/downloads/"
    throw "Python install failed"
}

function Get-PythonVersion([string]$command) {
    try {
        $versionText = & $command --version 2>&1
        if ($LASTEXITCODE -eq 0) {
            return ($versionText -replace '^Python\s+', '').Trim()
        }
    } catch {
        return $null
    }
    return $null
}

function Compare-PythonVersion([string]$installed, [string]$minimum) {
    $installedParts = $installed.Split('.') | ForEach-Object {[int]$_}
    $minimumParts = $minimum.Split('.') | ForEach-Object {[int]$_}
    for ($i = 0; $i -lt [Math]::Max($installedParts.Length, $minimumParts.Length); $i++) {
        $installedValue = if ($i -lt $installedParts.Length) { $installedParts[$i] } else { 0 }
        $minimumValue = if ($i -lt $minimumParts.Length) { $minimumParts[$i] } else { 0 }
        if ($installedValue -gt $minimumValue) { return 1 }
        if ($installedValue -lt $minimumValue) { return -1 }
    }
    return 0
}

# Início
Write-Header
Write-Host ''

$scriptDir = Split-Path -Parent $PSScriptRoot
$projectDir = Split-Path -Parent $scriptDir
Set-Location -Path $projectDir
Write-Info "Diretório do projeto: $(Get-Location)"
Write-Host ''

$minVersion = '3.12.0'
$pythonCmd = Get-PythonCommand

if (-not $pythonCmd) {
    Write-WarningMsg "Python 3 não está instalado ou não foi encontrado no PATH."
    Install-Python
    $pythonCmd = Get-PythonCommand
    if (-not $pythonCmd) {
        Write-ErrorMsg "Não foi possível localizar o Python após a instalação."
        exit 1
    }
    Write-Success "Python 3 instalado com sucesso."
}

$installedVersion = Get-PythonVersion $pythonCmd
if (-not $installedVersion) {
    Write-ErrorMsg "Falha ao obter a versão do Python usando o comando '$pythonCmd'."
    exit 1
}

Write-Success "Python encontrado: $installedVersion"

if (Compare-PythonVersion $installedVersion $minVersion -lt 0) {
    Write-WarningMsg "Versão atual é menor que $minVersion. Atualizando Python..."
    Install-Python
    $pythonCmd = Get-PythonCommand
    if (-not $pythonCmd) {
        Write-ErrorMsg "Não foi possível localizar o Python após a atualização."
        exit 1
    }
    $installedVersion = Get-PythonVersion $pythonCmd
    if (-not $installedVersion) {
        Write-ErrorMsg "Falha ao obter a versão do Python após a atualização."
        exit 1
    }
    Write-Success "Versão atualizada para $installedVersion"
}

Write-Info "Usando comando Python: $pythonCmd"
Write-Info "Versão final: $installedVersion"
Write-Host ''

$appFile = Join-Path $projectDir 'app.py'
if (-not (Test-Path $appFile)) {
    Write-ErrorMsg "Arquivo 'app.py' não encontrado em '$projectDir'."
    exit 1
}

Write-Host '==============================================' -ForegroundColor Magenta
Write-Host '    Iniciando aplicação...' -ForegroundColor Magenta
Write-Host '==============================================' -ForegroundColor Magenta
Write-Host ''

& $pythonCmd $appFile
$exitCode = $LASTEXITCODE

Write-Host ''
Write-Host '==============================================' -ForegroundColor Magenta
if ($exitCode -eq 0) {
    Write-Success "Aplicação finalizada com sucesso!"
} else {
    Write-ErrorMsg "Aplicação finalizada com erro (código: $exitCode)"
}
Write-Host '==============================================' -ForegroundColor Magenta

exit $exitCode
