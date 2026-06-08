class calc:
    def sum(self, a, b):
        return(f"O resultado da sua subtração é ${a+b}")
    
    def sub(self, a, b):
        if(a>b):
            return(f"O resultado da sua subtração é ${a-b}.")
        else:
            return(f"A sua subtração vai dar negativo! O resultado é ${a-b}.")