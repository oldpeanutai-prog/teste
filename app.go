package main

import (
    "bufio"
    "fmt"
    "math"
    "os"
    "strconv"
    "strings"
)

func readLine(prompt string) string {
    fmt.Print(prompt)
    reader := bufio.NewReader(os.Stdin)
    text, _ := reader.ReadString('\n')
    return strings.TrimSpace(text)
}

func factorial(value int) string {
    if value < 0 {
        return "Não é possível calcular fatorial de um número negativo!"
    }
    result := 1
    for i := 2; i <= value; i++ {
        result *= i
    }
    return fmt.Sprintf("O resultado do fatorial de %d é %d", value, result)
}

func main() {
    operation := strings.ToLower(readLine("Digite a operação que você quer.\n    Sum = Soma\n    Sub = Subtrai\n    Mul = Multiplica\n    Div = Divide\n    Pow = Potência\n    Sqrt = Raiz Quadrada\n    Mod = Módulo\n    Fact = Fatorial\n >> "))

    num1Text := readLine("Digite o primeiro número (inteiro): ")
    num1, err := strconv.Atoi(num1Text)
    if err != nil {
        fmt.Println("Valor inválido. Use apenas números inteiros.")
        os.Exit(1)
    }

    switch operation {
    case "sum", "sub", "mul", "div", "pow", "mod":
        num2Text := readLine("Digite o segundo número (inteiro): ")
        num2, err := strconv.Atoi(num2Text)
        if err != nil {
            fmt.Println("Valor inválido. Use apenas números inteiros.")
            os.Exit(1)
        }

        switch operation {
        case "sum":
            fmt.Printf("O resultado da sua soma é %d\n", num1+num2)
        case "sub":
            result := num1 - num2
            if result < 0 {
                fmt.Printf("A sua subtração vai dar negativo! O resultado é %d.\n", result)
            } else {
                fmt.Printf("O resultado da sua subtração é %d\n", result)
            }
        case "mul":
            fmt.Printf("O resultado da sua multiplicação é %d\n", num1*num2)
        case "div":
            if num2 == 0 {
                fmt.Println("Não é possível dividir por zero!")
            } else {
                fmt.Printf("O resultado da sua divisão é %g\n", float64(num1)/float64(num2))
            }
        case "pow":
            fmt.Printf("O resultado da sua potência é %g\n", math.Pow(float64(num1), float64(num2)))
        case "mod":
            if num2 == 0 {
                fmt.Println("Não é possível calcular módulo por zero!")
            } else {
                fmt.Printf("O resultado do módulo é %d\n", num1%num2)
            }
        }
    case "sqrt":
        if num1 < 0 {
            fmt.Println("Não é possível calcular a raiz quadrada de um número negativo!")
        } else {
            fmt.Printf("O resultado da sua raiz quadrada é %g\n", math.Sqrt(float64(num1)))
        }
    case "fact":
        fmt.Println(factorial(num1))
    default:
        fmt.Println("Operação inválida. Use 'Sum', 'Sub', 'Mul', 'Div', 'Pow', 'Mod', 'Sqrt' ou 'Fact'.")
    }
}
