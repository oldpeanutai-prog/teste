# teste

test
# Calculadora Python

Este repositório contém uma aplicação Python simples e scripts para executá-la em Linux/macOS e Windows.

## Estrutura de arquivos

- `app.py` — aplicação principal em Python.
- `calc.py` — módulos de cálculo.
- `scripts/run_calc.sh` — script para Linux/macOS.
- `scripts/run_calc.ps1` — script para Windows PowerShell.
- `scripts/run_calc.bat` — atalho Windows para chamar o PowerShell.
- `scripts/download_calculator.sh` — menu interativo para baixar versões em várias linguagens (Linux/macOS).
- `scripts/download_calculator.ps1` — menu interativo para baixar versões em várias linguagens (Windows PowerShell).
- `scripts/download_calculator.bat` — atalho Windows para chamar o download interativo.
- `app.go` — versão da calculadora em Go.
- `app.js` — versão da calculadora em JavaScript (Node.js).
- `app.rb` — versão da calculadora em Ruby.
- `App.java` — versão da calculadora em Java.

## Uso

### Linux / macOS

Executar a calculadora Python:

```bash
cd teste
./scripts/run_calc.sh
```

Baixar versões em outras linguagens:

```bash
cd teste
./scripts/download_calculator.sh
```

### Windows

Executar a calculadora Python com PowerShell:

```powershell
cd \caminho\para\teste\scripts
.\run_calc.ps1
```

Baixar versões em outras linguagens com PowerShell:

```powershell
cd \caminho\para\teste\scripts
.\download_calculator.ps1
```

### Atalho Windows

```bat
scripts\run_calc.bat
```

Para o menu de download:

```bat
scripts\download_calculator.bat
```

## Qual script é mais importante?

Para Windows, o arquivo `scripts/run_calc.ps1` é o mais importante, porque:

- ele faz a verificação do Python
- tenta instalar a última versão usando `winget` ou `choco`
- valida a versão mínima e executa `app.py`

O `scripts/run_calc.bat` existe apenas como um wrapper simples para abrir o PowerShell sem precisar digitar o comando completo.
