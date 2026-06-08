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
