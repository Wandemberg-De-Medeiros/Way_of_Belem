extends Node2D

@export var lista_de_propostas: Array[Proposta] = []
var cena_da_carta = preload("res://entidades/Carta.tscn")

func _ready():
	# randomize() não é mais necessário no Godot 4 (o motor já faz isso), 
	# mas não faz mal deixar.
	carregar_todas_as_cartas_da_pasta() 
	proxima_carta()

func carregar_todas_as_cartas_da_pasta():
	var caminho = "res://Propostas/"
	
	# Verifica se a pasta existe antes de tentar abrir
	if not DirAccess.dir_exists_absolute(caminho):
		print("Erro: A pasta de propostas não existe!")
		return

	var dir = DirAccess.open(caminho)
	lista_de_propostas.clear()
	
	if dir:
		dir.list_dir_begin()
		var nome_arquivo = dir.get_next()
		
		while nome_arquivo != "":
			if nome_arquivo.ends_with(".tres"):
				var recurso = load(caminho + nome_arquivo)
				if recurso is Proposta:
					lista_de_propostas.append(recurso)
			nome_arquivo = dir.get_next()
		
		lista_de_propostas.shuffle()
		print("Cartas carregadas: ", lista_de_propostas.size())

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

	# Define a posição (Descomente e ajuste se necessário)
	# instancia_cena.global_position = Vector2(219.5, 127.5)
	
	var area_carta = instancia_cena.get_node_or_null("Area2D")
	
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
		
	
func _exit_tree():
	# Desconecta para evitar que a carta tente chamar o MainScene enquanto ele morre
	for child in get_children():
		if child.has_node("Area2D"):
			var area = child.get_node("Area2D")
			if area.tree_exited.is_connected(proxima_carta):
				area.tree_exited.disconnect(proxima_carta)
