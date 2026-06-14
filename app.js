const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

function ask(question) {
  return new Promise((resolve) => rl.question(question, resolve));
}

function factorial(n) {
  if (n < 0) return null;
  let result = 1;
  for (let i = 2; i <= n; i += 1) {
    result *= i;
  }
  return result;
}

(async () => {
  const operation = (await ask(
    'Digite a operação que você quer.\n    Sum = Soma\n    Sub = Subtrai\n    Mul = Multiplica\n    Div = Divide\n    Pow = Potência\n    Sqrt = Raiz Quadrada\n    Mod = Módulo\n    Fact = Fatorial\n >> '
  )).trim().toLowerCase();

  const num1Text = await ask('Digite o primeiro número (inteiro): ');
  const num1 = parseInt(num1Text, 10);
  if (Number.isNaN(num1)) {
    console.log('Valor inválido. Use apenas números inteiros.');
    rl.close();
    process.exit(1);
  }

  if (['sum', 'sub', 'mul', 'div', 'pow', 'mod'].includes(operation)) {
    const num2Text = await ask('Digite o segundo número (inteiro): ');
    const num2 = parseInt(num2Text, 10);
    if (Number.isNaN(num2)) {
      console.log('Valor inválido. Use apenas números inteiros.');
      rl.close();
      process.exit(1);
    }

    switch (operation) {
      case 'sum':
        console.log(`O resultado da sua soma é ${num1 + num2}`);
        break;
      case 'sub': {
        const result = num1 - num2;
        if (result < 0) {
          console.log(`A sua subtração vai dar negativo! O resultado é ${result}.`);
        } else {
          console.log(`O resultado da sua subtração é ${result}`);
        }
        break;
      }
      case 'mul':
        console.log(`O resultado da sua multiplicação é ${num1 * num2}`);
        break;
      case 'div':
        if (num2 === 0) {
          console.log('Não é possível dividir por zero!');
        } else {
          console.log(`O resultado da sua divisão é ${num1 / num2}`);
        }
        break;
      case 'pow':
        console.log(`O resultado da sua potência é ${Math.pow(num1, num2)}`);
        break;
      case 'mod':
        if (num2 === 0) {
          console.log('Não é possível calcular módulo por zero!');
        } else {
          console.log(`O resultado do módulo é ${num1 % num2}`);
        }
        break;
    }
  } else if (operation === 'sqrt') {
    if (num1 < 0) {
      console.log('Não é possível calcular a raiz quadrada de um número negativo!');
    } else {
      console.log(`O resultado da sua raiz quadrada é ${Math.sqrt(num1)}`);
    }
  } else if (operation === 'fact') {
    const result = factorial(num1);
    if (result === null) {
      console.log('Não é possível calcular fatorial de um número negativo!');
    } else {
      console.log(`O resultado do fatorial de ${num1} é ${result}`);
    }
  } else {
    console.log("Operação inválida. Use 'Sum', 'Sub', 'Mul', 'Div', 'Pow', 'Mod', 'Sqrt' ou 'Fact'.");
  }

  rl.close();
})();
