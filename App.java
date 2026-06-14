import java.util.InputMismatchException;
import java.util.Scanner;

public class App {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.println("Digite a operação que você quer.");
        System.out.println("    Sum = Soma");
        System.out.println("    Sub = Subtrai");
        System.out.println("    Mul = Multiplica");
        System.out.println("    Div = Divide");
        System.out.println("    Pow = Potência");
        System.out.println("    Sqrt = Raiz Quadrada");
        System.out.println("    Mod = Módulo");
        System.out.println("    Fact = Fatorial");
        System.out.print(" >> ");
        String operation = scanner.nextLine().trim().toLowerCase();

        try {
            System.out.print("Digite o primeiro número (inteiro): ");
            int num1 = Integer.parseInt(scanner.nextLine().trim());

            if (operation.equals("sum") || operation.equals("sub") || operation.equals("mul") || operation.equals("div") || operation.equals("pow") || operation.equals("mod")) {
                System.out.print("Digite o segundo número (inteiro): ");
                int num2 = Integer.parseInt(scanner.nextLine().trim());

                switch (operation) {
                    case "sum":
                        System.out.println("O resultado da sua soma é " + (num1 + num2));
                        break;
                    case "sub":
                        int sub = num1 - num2;
                        if (sub < 0) {
                            System.out.println("A sua subtração vai dar negativo! O resultado é " + sub + ".");
                        } else {
                            System.out.println("O resultado da sua subtração é " + sub);
                        }
                        break;
                    case "mul":
                        System.out.println("O resultado da sua multiplicação é " + (num1 * num2));
                        break;
                    case "div":
                        if (num2 == 0) {
                            System.out.println("Não é possível dividir por zero!");
                        } else {
                            System.out.println("O resultado da sua divisão é " + ((double) num1 / num2));
                        }
                        break;
                    case "pow":
                        System.out.println("O resultado da sua potência é " + Math.pow(num1, num2));
                        break;
                    case "mod":
                        if (num2 == 0) {
                            System.out.println("Não é possível calcular módulo por zero!");
                        } else {
                            System.out.println("O resultado do módulo é " + (num1 % num2));
                        }
                        break;
                }
            } else if (operation.equals("sqrt")) {
                if (num1 < 0) {
                    System.out.println("Não é possível calcular a raiz quadrada de um número negativo!");
                } else {
                    System.out.println("O resultado da sua raiz quadrada é " + Math.sqrt(num1));
                }
            } else if (operation.equals("fact")) {
                if (num1 < 0) {
                    System.out.println("Não é possível calcular fatorial de um número negativo!");
                } else {
                    System.out.println("O resultado do fatorial de " + num1 + " é " + factorial(num1));
                }
            } else {
                System.out.println("Operação inválida. Use 'Sum', 'Sub', 'Mul', 'Div', 'Pow', 'Mod', 'Sqrt' ou 'Fact'.");
            }
        } catch (NumberFormatException e) {
            System.out.println("Valor inválido. Use apenas números inteiros.");
        } finally {
            scanner.close();
        }
    }

    private static long factorial(int value) {
        long result = 1;
        for (int i = 2; i <= value; i++) {
            result *= i;
        }
        return result;
    }
}
