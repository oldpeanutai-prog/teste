from calc import calc as c

opDesejada = input("Digite a operação que você quer. \n    Sum = Soma\n    Sub = Subtrai \n >> ").strip().lower()

num1 = int(input("Digite o primeiro numero: "))
num2 = int(input(f"Número escolhido: {num1} Digite o segundo numero: "))

if opDesejada == "sum":
    print(c.sum(num1, num2))
elif opDesejada == "sub":
    print(c.sub(num1, num2))
else:
    print("Operação inválida. Use 'Sum' ou 'Sub'.")