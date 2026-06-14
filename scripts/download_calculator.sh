#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DOWNLOAD_DIR="$PROJECT_DIR/downloads"

declare -A FILES=(
  [py]="app.py calc.py"
  [go]="app.go"
  [js]="app.js"
  [rb]="app.rb"
  [java]="App.java"
)

declare -A COMMANDS=(
  [py]="python3"
  [go]="go"
  [js]="node"
  [rb]="ruby"
  [java]="javac"
)

install_package() {
  local pkg="$1"
  if command -v apt-get &> /dev/null; then
    case "$pkg" in
      python3) sudo apt-get update && sudo apt-get install -y python3 python3-pip ;; 
      go) sudo apt-get update && sudo apt-get install -y golang-go ;; 
      node) sudo apt-get update && sudo apt-get install -y nodejs npm ;; 
      ruby) sudo apt-get update && sudo apt-get install -y ruby-full ;; 
      javac) sudo apt-get update && sudo apt-get install -y default-jdk ;; 
      *) return 1 ;;
    esac
  elif command -v dnf &> /dev/null; then
    case "$pkg" in
      python3) sudo dnf install -y python3 python3-pip ;; 
      go) sudo dnf install -y golang ;; 
      node) sudo dnf install -y nodejs npm ;; 
      ruby) sudo dnf install -y ruby ;; 
      javac) sudo dnf install -y java-17-openjdk-devel ;; 
      *) return 1 ;;
    esac
  elif command -v pacman &> /dev/null; then
    case "$pkg" in
      python3) sudo pacman -Sy --noconfirm python python-pip ;; 
      go) sudo pacman -Sy --noconfirm go ;; 
      node) sudo pacman -Sy --noconfirm nodejs npm ;; 
      ruby) sudo pacman -Sy --noconfirm ruby ;; 
      javac) sudo pacman -Sy --noconfirm jdk-openjdk ;; 
      *) return 1 ;;
    esac
  elif command -v brew &> /dev/null; then
    case "$pkg" in
      python3) brew install python ;; 
      go) brew install go ;; 
      node) brew install node ;; 
      ruby) brew install ruby ;; 
      javac) brew install openjdk ;; 
      *) return 1 ;;
    esac
  else
    echo "Gerenciador de pacotes não suportado. Instale $pkg manualmente." >&2
    return 1
  fi
}

check_install() {
  local key="$1"
  local cmd="${COMMANDS[$key]}"

  if command -v "$cmd" &> /dev/null; then
    echo "$cmd encontrado. OK."
    return 0
  fi

  echo "$cmd não encontrado. Tentando instalar..."
  install_package "$cmd"

  if command -v "$cmd" &> /dev/null; then
    echo "$cmd instalado com sucesso."
    return 0
  fi

  echo "Falha ao instalar $cmd. Por favor, instale manualmente." >&2
  return 1
}

echo "Selecione qual versão deseja baixar:"
echo "  1) Python (.py)"
echo "  2) Go (.go)"
echo "  3) JavaScript (.js)"
echo "  4) Ruby (.rb)"
echo "  5) Java (.java)"
echo "  6) Todas as versões"
echo "  0) Sair"

read -rp "Digite a opção: " choice

case "$choice" in
  1|py|PY|python)
    selected=(py)
    ;;
  2|go|GO)
    selected=(go)
    ;;
  3|js|JS|javascript)
    selected=(js)
    ;;
  4|rb|RB|ruby)
    selected=(rb)
    ;;
  5|java|JAVA)
    selected=(java)
    ;;
  6|all|ALL)
    selected=(py go js rb java)
    ;;
  0|exit|sair)
    echo "Saindo..."
    exit 0
    ;;
  *)
    echo "Opção inválida. Saindo."
    exit 1
    ;;
esac

mkdir -p "$DOWNLOAD_DIR"

echo "Criando pasta de destino: $DOWNLOAD_DIR"

for key in "${selected[@]}"; do
  check_install "$key"
  for file in ${FILES[$key]}; do
    src="$PROJECT_DIR/$file"
    dst="$DOWNLOAD_DIR/$file"
    if [ ! -f "$src" ]; then
      echo "Arquivo não encontrado: $src"
      exit 1
    fi
    cp "$src" "$dst"
    echo "Baixado: $file -> $DOWNLOAD_DIR"
  done
done

echo "Download concluído. Arquivos disponíveis em: $DOWNLOAD_DIR"
