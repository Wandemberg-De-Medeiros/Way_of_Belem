extends Node2D

@export var lista_de_propostas: Array[Proposta] = []
var cena_da_carta = preload("res://entidades/Carta.tscn")
var carta_ativa_node = null

func _ready():
	# randomize() não é mais necessário no Godot 4 (o motor já faz isso), 
	# mas não faz mal deixar.
	carregar_todas_as_cartas_da_pasta() 
	proxima_carta()
	GameManager.jogo_encerrado.connect(_on_jogo_encerrado)
	tocar_musica_com_atraso()
	
	if has_node("botao_abaixar_carta"):
		$botao_abaixar_carta.clicado.connect(_ao_clicar_no_botao_abaixar)

func tocar_musica_com_atraso():
	await get_tree().create_timer(6.0).timeout
	tocar_musica()

func tocar_musica():
	$SomAmbiente.play()

func _on_jogo_encerrado():
	$SomAmbiente.stop()

func carregar_todas_as_cartas_da_pasta():
	var banco = load("res://banco_de_cartas.tres")
	if banco is ListaPropostas:
		# Duplicamos a lista para não alterar o arquivo original ao dar shuffle
		lista_de_propostas = banco.todas_as_propostas.duplicate()
		lista_de_propostas.shuffle()
		print("Cartas carregadas via Resource: ", lista_de_propostas.size())

func proxima_carta():
	# 1. Verifica se ainda há cartas no baralho
	if lista_de_propostas.is_empty():
		print("Fim das propostas! O deck acabou.")
		# Aqui você poderia chamar uma tela de vitória ou balanço final
		return
		
	# 2. Retira o primeiro dado da lista
	var dados = lista_de_propostas.pop_front()
	
	var instancia_cena = cena_da_carta.instantiate()
	add_child(instancia_cena)
	
	var area_carta = instancia_cena.get_node_or_null("Area2D")
	carta_ativa_node = area_carta
	
	if area_carta:
		# Conecta o sinal ANTES de configurar, por segurança
		if not area_carta.tree_exited.is_connected(proxima_carta):
			area_carta.tree_exited.connect(proxima_carta)
		
		# Envia os dados para a carta
		area_carta.configurar(dados)
	else:
		print("Erro Crítico: O nó 'Area2D' não foi encontrado dentro de Carta.tscn")
		# Se a carta falhou, chama a próxima para o jogo não travar
		proxima_carta()

func _ao_clicar_no_botao_abaixar():
	if is_instance_valid(carta_ativa_node):
		if carta_ativa_node.has_method("alternar_posicao"):
			carta_ativa_node.alternar_posicao()
		else:
			print("Erro: A script da Carta não possui a função 'alternar_posicao'")

func _exit_tree():
	# Desconecta para evitar que a carta tente chamar o MainScene enquanto ele morre
	for child in get_children():
		if child.has_node("Area2D"):
			var area = child.get_node("Area2D")
			if area.tree_exited.is_connected(proxima_carta):
				area.tree_exited.disconnect(proxima_carta)
