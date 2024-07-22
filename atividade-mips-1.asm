.data
  msg_opcoes: .asciiz "Escolha uma opção:\n1 - Fahrenheit -> Celsius\n2 - Fibonacci\n3 - Enésimo número par\n4 - Sair\nDigite sua escolha: "
  msg_informar_fahrenheit: .asciiz "Informe a temperatura em Fahrenheit: "
  msg_informar_n: .asciiz "Informe o N: "
  msg_exibir_resultado: .asciiz "Resultado: "
  quebrarLinha: .asciiz "\n"

.text
  menu:
    # Mostra o menu
    la $a0, msg_opcoes
    li $v0, 4  # syscall para printar string
    syscall

    # Recebe a escolha do usuário
    li $v0, 5  # syscall para ler inteiro
    syscall
    move $t2, $v0  # armazena a escolha do usuário no t2

    # Faz o Loop até o usuário escolher a opção Sair
  escolha_opcao:
    # Confere qual opção foi escolhida pelo usuário
    beq $t2, 4, sair  
    beq $t2, 1, fahrenheit_para_celsius
    beq $t2, 2, fibonacci
    beq $t2, 3, enesimo_numero_par

    # Escolha Inválida (se o usuário não escolher nenhuma das opções fornecidas)
    la $a0, msg_opcoes
    li $v0, 4  # syscall para printar string
    syscall
    li $v0, 5  # syscall para ler inteiro
    syscall
    move $t2, $v0  # Store user choice
    j escolha_opcao

  fahrenheit_para_celsius:
    # Carrega a temperatura em Fahrenheit
    la $a0, msg_informar_fahrenheit
    li $v0, 4  # syscall para printar string
    syscall
    li $v0, 5  # syscall para ler inteiro
    syscall
    move $t3, $v0  # Armazena a temperatura em Fahrenheit no T3

    # Converte Fahrenheit para Celsius
    sub $t4, $t3, 32  # Subtrai 32 do t3
    mul $t4, $t4, 5  # Multiplica por 5
    div $t4, $t4, 9  # Divide por 9

    # Mostra a temperatura em Celsius
    la $a0, msg_exibir_resultado
    li $v0, 4  # syscall para printar string
    syscall
    move $a0, $t4
    li $v0, 1  # syscall para printar inteiro
    syscall
    la $a0, quebrarLinha
    li $v0, 4  # syscall para printar string
    syscall

    j menu

    fibonacci:
    # Carrega o valor de N
    la $a0, msg_informar_n
    li $v0, 4  # syscall para printar string
    syscall
    li $v0, 5  # syscall para ler inteiro
    syscall
    move $t3, $v0  # Armazena valor de N

    # Declara variáveis do Fibonacci
    li $t0, 0  # Declara variável contadora
    li $t4, 0  # Declara F1
    li $t5, 1  # Declara F2

  fibonacci_calculo:
    beq $t0, $t3, fibonacci_resultado  # Confere se o enésimo termo foi alcançado

    move $t6, $t4  # Armazena F0 em uma variavel temporaria
    add $t4, $t4, $t5  # F(n) = F(n-1) + F(n-2)
    move $t5, $t6  # Atualiza F1 com o valor anterior
    addi $t0, $t0, 1  # Incrementa contador
    j fibonacci_calculo

  fibonacci_resultado:
    la $a0, msg_exibir_resultado
    li $v0, 4  # syscall para printar string
    syscall
    move $a0, $t4
    li $v0, 1  # syscall para printar inteiro
    syscall
    la $a0, quebrarLinha  # Print quebrarLinha
    li $v0, 4  # syscall para printar string
    syscall

    j menu

  enesimo_numero_par:
    # Carrega o Valor de N
    la $a0, msg_informar_n
    li $v0, 4  # syscall para printar string
    syscall
    li $v0, 5  # syscall para ler inteiro
    syscall
    move $t3, $v0  # Armazena valor de N no t3

    # Inicializa contador de enésimo número par
    li $t0, 0  # Declara variável contadora
    li $t1, 0  # Declara o primeiro número par

  enesimo_par_loop:
    beq $t0, $t3, enesimo_par_resultado  # Confere se o enésimo número foi alcançado

    addi $t1, $t1, 2  # Soma 2 ao número par
    addi $t0, $t0, 1  # Incrementa contador
    j enesimo_par_loop

    enesimo_par_resultado:
    la $a0, msg_exibir_resultado
    li $v0, 4  # syscall para printar string
    syscall
    move $a0, $t1
    li $v0, 1  # syscall para printar inteiro
    syscall
    la $a0, quebrarLinha  # Leitura do quebrarLinha
    li $v0, 4  # syscall para printar string
    syscall

    j menu

  # Encerrar programa
  sair:
    li $v0, 10
    syscall