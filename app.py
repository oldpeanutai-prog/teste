from calc import calc as c

opDesejada = input("Digite a operação que você quer. \n    Sum = Soma\n    Sub = Subtrai \n >> ")

num1 = int(input("Digite o primeiro numero: "))
num2 = int(input(f"Número escolhido: ${num1} Digite o segundo numero: "))

match opDesejada:
    case "Sum", "sum":
        resp = c.sum(num1, num2)
        print(resp)
    case "Sub", "sub":
        resp = c.sub(num1, num2)
        print(resp) 