#!/usr/bin/env bash

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Função para imprimir com cor
print_header() {
    echo -e "${CYAN}${BOLD}╔════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}${BOLD}║       🧮 ${GREEN}CALCULADORA PYTHON${CYAN} 🧮       ║${NC}"
    echo -e "${CYAN}${BOLD}╚════════════════════════════════════════╝${NC}"
}

print_success() {
    echo -e "${GREEN}${BOLD}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}${BOLD}✗ $1${NC}"
}

print_info() {
    echo -e "${BLUE}${BOLD}ℹ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}${BOLD}⚠ $1${NC}"
}

# Exibir header
print_header
echo ""

# Ir para o diretório do script
SCRIPT_DIR="$(dirname "$0")"
cd "$SCRIPT_DIR/.."
PROJECT_DIR=$(pwd)
print_info "Diretório do projeto: $PROJECT_DIR"
echo ""

# Verificar se Python 3 está instalado
MIN_PYTHON_VERSION="3.12.0"

version_ge() {
    printf '%s\n%s\n' "$1" "$2" | sort -CV -V
}

install_python() {
    print_info "Tentando instalar a última versão disponível do Python 3..."

    if command -v apt-get &> /dev/null; then
        print_info "Sistema detectado: Debian/Ubuntu"
        sudo apt-get update
        sudo apt-get install -y python3 python3-pip
        if command -v python3.12 &> /dev/null; then
            sudo apt-get install -y python3.12 python3.12-venv python3.12-dev || true
            sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.12 2>/dev/null || true
        fi
    elif command -v dnf &> /dev/null; then
        print_info "Sistema detectado: Fedora/RHEL"
        sudo dnf install -y python3 python3-pip
    elif command -v pacman &> /dev/null; then
        print_info "Sistema detectado: Arch Linux"
        sudo pacman -Sy --noconfirm python python-pip
    elif command -v brew &> /dev/null; then
        print_info "Sistema detectado: macOS"
        brew install python
    else
        print_error "Gerenciador de pacotes não identificado!"
        print_error "Por favor, instale Python 3 manualmente"
        exit 1
    fi

    if command -v python3 &> /dev/null; then
        print_success "Python 3 instalado com sucesso!"
    else
        print_error "Falha ao instalar Python 3"
        exit 1
    fi
}

print_info "Verificando Python 3..."
if command -v python3 &> /dev/null; then
    INSTALLED_VERSION=$(python3 --version 2>&1 | awk '{print $2}')
    print_success "Python 3 já está instalado"
    print_info "Versão atual: ${CYAN}$INSTALLED_VERSION${NC}"
    if version_ge "$MIN_PYTHON_VERSION" "$INSTALLED_VERSION"; then
        print_success "Versão atual atende ao mínimo esperado (${MIN_PYTHON_VERSION})"
    else
        print_warning "Versão atual é menor que ${MIN_PYTHON_VERSION}. Atualizando para a última versão disponível..."
        install_python
    fi
else
    print_warning "Python 3 não está instalado!"
    install_python
fi

# Mostrar versão do Python
PYTHON_VERSION=$(python3 --version)
print_info "Versão: ${CYAN}$PYTHON_VERSION${NC}"
echo ""

# Verificar se app.py existe
if [ ! -f "$PROJECT_DIR/app.py" ]; then
    print_error "Arquivo app.py não encontrado em $PROJECT_DIR!"
    exit 1
fi

# Executar aplicação
echo -e "${MAGENTA}${BOLD}═══════════════════════════════════════${NC}"
echo -e "${MAGENTA}${BOLD}    Iniciando aplicação...${NC}"
echo -e "${MAGENTA}${BOLD}═══════════════════════════════════════${NC}"
echo ""

python3 "$PROJECT_DIR/app.py"
exit_code=$?

echo ""
echo -e "${MAGENTA}${BOLD}═══════════════════════════════════════${NC}"
if [ $exit_code -eq 0 ]; then
    print_success "Aplicação finalizada com sucesso!"
else
    print_error "Aplicação finalizada com erro (código: $exit_code)"
fi
echo -e "${MAGENTA}${BOLD}═══════════════════════════════════════${NC}"

exit $exit_code