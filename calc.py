class calc:
    @staticmethod
    def sum(a, b):
        return f"O resultado da sua soma é {a+b}"
    
    @staticmethod
    def sub(a, b):
        r = a - b
        if r < 0:
            return f"A sua subtração vai dar negativo! O resultado é {r}."
        return f"O resultado da sua subtração é {r}."

    @staticmethod
    def mul(a, b):
        return f"O resultado da sua multiplicação é {a*b}"
    
    @staticmethod
    def div(a, b):
        if b == 0:
            return "Não é possível dividir por zero!"
        return f"O resultado da sua divisão é {a/b}"

    @staticmethod
    def mod(a, b):
        if b == 0:
            return "Não é possível calcular módulo por zero!"
        return f"O resultado do módulo é {a % b}"

    @staticmethod
    def floor(a, b):
        if b == 0:
            return "Não é possível dividir por zero!"
        return f"O resultado da divisão inteira é {a // b}"
    
    @staticmethod
    def pow(a, b):
        return f"O resultado da sua potência é {a**b}"
    
    @staticmethod
    def sqrt(a):
        if a < 0:
            return "Não é possível calcular a raiz quadrada de um número negativo!"
        return f"O resultado da sua raiz quadrada é {a**0.5}"

    @staticmethod
    def abs(a):
        return f"O valor absoluto de {a} é {abs(a)}"

    @staticmethod
    def fact(a):
        if a < 0:
            return "Não é possível calcular fatorial de um número negativo!"
        result = 1
        for i in range(2, a + 1):
            result *= i
        return f"O resultado do fatorial de {a} é {result}"
