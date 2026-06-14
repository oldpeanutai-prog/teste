def prompt(message)
  print message
  gets.chomp
end

def factorial(n)
  return nil if n < 0
  result = 1
  (2..n).each { |i| result *= i }
  result
end

operations = {
  'sum' => 'Soma',
  'sub' => 'Subtrai',
  'mul' => 'Multiplica',
  'div' => 'Divide',
  'pow' => 'Potência',
  'sqrt' => 'Raiz Quadrada',
  'mod' => 'Módulo',
  'fact' => 'Fatorial'
}

operation = prompt("Digite a operação que você quer.\n    Sum = Soma\n    Sub = Subtrai\n    Mul = Multiplica\n    Div = Divide\n    Pow = Potência\n    Sqrt = Raiz Quadrada\n    Mod = Módulo\n    Fact = Fatorial\n >> ").strip.downcase
num1_text = prompt('Digite o primeiro número (inteiro): ')
num1 = Integer(num1_text) rescue nil

if num1.nil?
  puts 'Valor inválido. Use apenas números inteiros.'
  exit 1
end

if %w[sum sub mul div pow mod].include?(operation)
  num2_text = prompt('Digite o segundo número (inteiro): ')
  num2 = Integer(num2_text) rescue nil
  if num2.nil?
    puts 'Valor inválido. Use apenas números inteiros.'
    exit 1
  end

  case operation
  when 'sum'
    puts "O resultado da sua soma é #{num1 + num2}"
  when 'sub'
    result = num1 - num2
    if result < 0
      puts "A sua subtração vai dar negativo! O resultado é #{result}."
    else
      puts "O resultado da sua subtração é #{result}"
    end
  when 'mul'
    puts "O resultado da sua multiplicação é #{num1 * num2}"
  when 'div'
    if num2.zero?
      puts 'Não é possível dividir por zero!'
    else
      puts "O resultado da sua divisão é #{num1.to_f / num2}"
    end
  when 'pow'
    puts "O resultado da sua potência é #{num1**num2}"
  when 'mod'
    if num2.zero?
      puts 'Não é possível calcular módulo por zero!'
    else
      puts "O resultado do módulo é #{num1 % num2}"
    end
  end
elsif operation == 'sqrt'
  if num1 < 0
    puts 'Não é possível calcular a raiz quadrada de um número negativo!'
  else
    puts "O resultado da sua raiz quadrada é #{Math.sqrt(num1)}"
  end
elsif operation == 'fact'
  result = factorial(num1)
  if result.nil?
    puts 'Não é possível calcular fatorial de um número negativo!'
  else
    puts "O resultado do fatorial de #{num1} é #{result}"
  end
else
  puts "Operação inválida. Use 'Sum', 'Sub', 'Mul', 'Div', 'Pow', 'Mod', 'Sqrt' ou 'Fact'."
end
