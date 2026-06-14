function Write-Info([string]$message) {
    Write-Host "ℹ $message" -ForegroundColor Cyan
}

function Write-Success([string]$message) {
    Write-Host "✔ $message" -ForegroundColor Green
}

function Write-ErrorMsg([string]$message) {
    Write-Host "✗ $message" -ForegroundColor Red
}

function Read-Choice([string]$prompt) {
    Write-Host -NoNewline $prompt
    return Read-Host
}

function Install-Package([string]$command) {
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        switch ($command) {
            'python3' { winget install --id Python.Python.3 -e --accept-package-agreements --accept-source-agreements }
            'go' { winget install --id GoLang.Go -e --accept-package-agreements --accept-source-agreements }
            'node' { winget install --id OpenJS.NodeJS -e --accept-package-agreements --accept-source-agreements }
            'ruby' { winget install --id RubyInstaller.Ruby -e --accept-package-agreements --accept-source-agreements }
            'javac' { winget install --id Eclipse.Adoptium.Temurin.17.JDK -e --accept-package-agreements --accept-source-agreements }
            default { throw "Pacote desconhecido: $command" }
        }
        return
    }

    if (Get-Command choco -ErrorAction SilentlyContinue) {
        switch ($command) {
            'python3' { choco install python -y }
            'go' { choco install golang -y }
            'node' { choco install nodejs -y }
            'ruby' { choco install ruby -y }
            'javac' { choco install openjdk -y }
            default { throw "Pacote desconhecido: $command" }
        }
        return
    }

    Write-ErrorMsg "Nenhum gerenciador de pacotes suportado encontrado (winget ou choco)."
    throw "Instalação falhou"
}

function Ensure-Command([string]$command) {
    if (Get-Command $command -ErrorAction SilentlyContinue) {
        Write-Success "$command encontrado. OK."
        return
    }

    Write-Info "$command não encontrado. Tentando instalar..."
    Install-Package $command

    if (-not (Get-Command $command -ErrorAction SilentlyContinue)) {
        Write-ErrorMsg "Falha ao instalar $command. Instale manualmente."
        throw "Comando não encontrado"
    }

    Write-Success "$command instalado com sucesso."
}

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectDir = Split-Path -Parent $scriptDir
$downloadDir = Join-Path $projectDir 'downloads'

$files = @{
    py = @('app.py', 'calc.py')
    go = @('app.go')
    js = @('app.js')
    rb = @('app.rb')
    java = @('App.java')
}

$commands = @{
    py = 'python3'
    go = 'go'
    js = 'node'
    rb = 'ruby'
    java = 'javac'
}

Write-Host 'Selecione qual versão deseja baixar:' -ForegroundColor Cyan
Write-Host '  1) Python (.py)'
Write-Host '  2) Go (.go)'
Write-Host '  3) JavaScript (.js)'
Write-Host '  4) Ruby (.rb)'
Write-Host '  5) Java (.java)'
Write-Host '  6) Todas as versões'
Write-Host '  0) Sair'

$choice = Read-Choice 'Digite a opção: '
$choice = $choice.Trim().ToLower()

switch ($choice) {
    '1' { $selected = @('py') }
    'py' { $selected = @('py') }
    '2' { $selected = @('go') }
    'go' { $selected = @('go') }
    '3' { $selected = @('js') }
    'js' { $selected = @('js') }
    'javascript' { $selected = @('js') }
    '4' { $selected = @('rb') }
    'rb' { $selected = @('rb') }
    'ruby' { $selected = @('rb') }
    '5' { $selected = @('java') }
    'java' { $selected = @('java') }
    '6' { $selected = @('py','go','js','rb','java') }
    'all' { $selected = @('py','go','js','rb','java') }
    '0' { Write-Host 'Saindo...'; exit 0 }
    'exit' { Write-Host 'Saindo...'; exit 0 }
    'sair' { Write-Host 'Saindo...'; exit 0 }
    default { Write-ErrorMsg 'Opção inválida. Saindo.'; exit 1 }
}

if (-not (Test-Path $downloadDir)) {
    New-Item -ItemType Directory -Path $downloadDir | Out-Null
    Write-Success "Criado diretório: $downloadDir"
}

foreach ($key in $selected) {
    Ensure-Command $commands[$key]
    foreach ($file in $files[$key]) {
        $src = Join-Path $projectDir $file
        $dst = Join-Path $downloadDir $file
        if (-not (Test-Path $src)) {
            Write-ErrorMsg "Arquivo não encontrado: $src"
            exit 1
        }
        Copy-Item -Path $src -Destination $dst -Force
        Write-Success "Baixado: $file -> $downloadDir"
    }
}

Write-Host ''
Write-Success "Download concluído. Arquivos disponíveis em: $downloadDir"
