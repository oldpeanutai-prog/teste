from calc import calc as c

opDesejada = input("Digite a operação que você quer. \n    Sum = Soma\n    Sub = Subtrai \n    Mul = Multiplica\n    Div = Divide\n    Pow = Potência\n    Sqrt = Raiz Quadrada\n    Mod = Módulo\n    Floor = Divisão Inteira\n    Abs = Valor Absoluto\n    Fact = Fatorial\n >> ").strip().lower()

num1 = int(input("Digite o primeiro numero (OBS.: O número precisa ser inteiro): "))

if opDesejada == "sum":
    num2 = int(input(f"Número escolhido: {num1} Digite o segundo numero (OBS.: O número precisa ser inteiro): "))
    print(c.sum(num1, num2))
elif opDesejada == "sub":
    num2 = int(input(f"Número escolhido: {num1} Digite o segundo numero (OBS.: O número precisa ser inteiro): "))
    print(c.sub(num1, num2))
elif opDesejada == "mul":
    num2 = int(input(f"Número escolhido: {num1} Digite o segundo numero (OBS.: O número precisa ser inteiro): "))
    print(c.mul(num1, num2))
elif opDesejada == "div":
    num2 = int(input(f"Número escolhido: {num1} Digite o segundo numero (OBS.: O número precisa ser inteiro): "))
    print(c.div(num1, num2))
elif opDesejada == "pow":
    num2 = int(input(f"Número escolhido: {num1} Digite o segundo numero (OBS.: O número precisa ser inteiro): "))
    print(c.pow(num1, num2))
elif opDesejada == "mod":
    num2 = int(input(f"Número escolhido: {num1} Digite o segundo numero (OBS.: O número precisa ser inteiro): "))
    print(c.mod(num1, num2))
elif opDesejada == "floor":
    num2 = int(input(f"Número escolhido: {num1} Digite o segundo numero (OBS.: O número precisa ser inteiro): "))
    print(c.floor(num1, num2))
elif opDesejada == "sqrt":
    print(c.sqrt(num1))
elif opDesejada == "abs":
    print(c.abs(num1))
elif opDesejada == "fact":
    print(c.fact(num1))
else:
    print("Operação inválida. Use 'Sum', 'Sub', 'Mul', 'Div', 'Pow', 'Mod', 'Floor', 'Abs', 'Fact' ou 'Sqrt'.")     