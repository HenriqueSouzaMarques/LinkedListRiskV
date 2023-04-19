# Trabalho 1 -> SSC0902 - Organização e Arquitetura de Computadores

# Henrique Souza Marques		NUSP: 11815722
# Lucas Greff Meneses			NUSP: 13671615
# Eduardo Neves Gomes da Silva		NUSP: 13822710
# Vinicius Carneiro Macedo		NUSP: 11915752 

	.data						# Seção de Dados
	.align 0
	
promptA: .asciz "Inserir o id: "
promptB: .asciz "Insira a string (ate 26 caracteres): "
promptC: .asciz "Insira a quantidade de nos: "
espaco:  .asciz " "

	.align 2
	
ponteiro: .word

	.text						# Seção de código
	.align 2					# Instruções de 32 bits
	.globl main
		
main:
	addi s0, zero, 36
	addi s1, zero, 0
	addi a1, zero, 28	
	addi s10, zero, -1
	
	la a0, promptC
	jal print_string
	
	addi a7, zero, 5
	ecall
	
	add s2, zero, a0
	
	addi sp, sp, -4
	sw ra, 0(sp)
	
	jal lista_criar
	
lista_criar:
	beq s1, s2, lista_printar
	jal criar_no
	j lista_criar

lista_printar:
	la t1, ponteiro
	lw t0, 0(t1)
	
printar:
	beq s1, zero, sair_programa
	
	addi a7, zero, 1
	lw a0, 0(t0)
	ecall
	
	la a0, espaco
	jal print_string
	
	add a0, zero, t0
	addi a0, a0, 4
	jal print_string
	
	lw t0, 32(t0)
	addi s1, s1, -1
	
	j printar
	
criar_no:
	
	addi sp, sp, -4
	sw ra, 0(sp)
	
	jal alocar_no
	
	jal preencher_no
	
	jal inserir_no

	lw ra, 0(sp)
	addi sp, sp, 4

	jr ra
	
alocar_no:	
	# Recebe s0 (tamanho do nó)
	# Retorno
	
	 add a0, zero, s0
	 addi a7, zero, 9
	 ecall
	 
	 add a3, zero, a0
	 
	 sw s10, 32(a3)
	 
	 jr ra 
	
	
print_string:
	# Recebe em a0 o endereço do buffer da string
	addi a7, zero, 4
	ecall
	
	jr ra	
	
preencher_no:
	# Recebe a3 -> Endereço do nó a ser preenchido
	
	addi sp, sp, -4
	sw ra, 0(sp)
	
	# Printa promptA
	la a0, promptA
	jal print_string
	
	# Leitura do ID
	addi a7, zero, 5
	ecall
	
	# Armazenar o ID
	sw a0, 0(a3)
	
	# Printa promptB
	la a0, promptB
	jal print_string
	
	# Ler a string (28 chars)
	addi a7, zero, 8
	add a0, zero, a3
	addi a0, a0, 4
	ecall
	
	lw ra, 0(sp)
	addi sp, sp, 4
	
	jr ra
	
inserir_no:
	# Recebe a2 -> Endereço do último nó da lista
	# Recebe a3 -> Endereço do nó a ser inserido
	
	beq s1, zero, PRIMEIRO_BLOCO
	
	sw a3, 32(a2)
	addi s1, s1, 1
	add a2, zero, a3
	
	jr ra

PRIMEIRO_BLOCO:
	la t0, ponteiro
	sw a3, 0(t0)
	addi s1, s1, 1
	add a2, zero, a3
	
	jr ra
	
sair_programa:
	addi a7, zero, 10
	ecall
