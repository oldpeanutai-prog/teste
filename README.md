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

## Uso

### Linux / macOS

```bash
cd teste
./scripts/run_calc.sh
```

### Windows

- Abra o `PowerShell` e execute:

```powershell
cd \caminho\para\teste\scripts
.\run_calc.ps1
```

- Ou use o atalho:

```bat
scripts\run_calc.bat
```

## Qual script é mais importante?

Para Windows, o arquivo `scripts/run_calc.ps1` é o mais importante, porque:

- ele faz a verificação do Python
- tenta instalar a última versão usando `winget` ou `choco`
- valida a versão mínima e executa `app.py`

O `scripts/run_calc.bat` existe apenas como um wrapper simples para abrir o PowerShell sem precisar digitar o comando completo.
