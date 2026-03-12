extends Node2D

@export var lista_de_propostas: Array[Proposta] = []
var cena_da_carta = preload("res://entidades/Carta.tscn")

func _ready():
	randomize()
	carregar_todas_as_cartas_da_pasta() 
	proxima_carta()

func carregar_todas_as_cartas_da_pasta():
	var caminho = "res://Propostas/"
	var dir = DirAccess.open(caminho)
	
	if dir:
		dir.list_dir_begin()
		var nome_arquivo = dir.get_next()
		
		while nome_arquivo != "":
			# Verifica se é um arquivo de recurso (.tres)
			if nome_arquivo.ends_with(".tres"):
				var recurso = load(caminho + nome_arquivo)
				if recurso is Proposta:
					lista_de_propostas.append(recurso)
			
			nome_arquivo = dir.get_next()
		
		lista_de_propostas.shuffle() # Embaralha depois de carregar tudo
		print("Cartas carregadas automaticamente: ", lista_de_propostas.size())

# Cria a aleatoriedade no baralho a cada nova partida
func embaralhar_cartas():
	if lista_de_propostas.size() > 0:
		lista_de_propostas.shuffle()
		print('Cartas embaralhadas para uma nova partida')

#responsavel por chamar a proxima carta da lista
func proxima_carta():
	if lista_de_propostas.size() > 0:
		var dados = lista_de_propostas.pop_front()
		var instancia_cena = cena_da_carta.instantiate()
		
		add_child(instancia_cena)
		
		# Define a posição exata da carta
		instancia_cena.global_position = Vector2(219.5, 127.5)
		
		# Acessa a Area2D para configurar o texto
		var area_carta = instancia_cena.get_node("Area2D")
		if area_carta:
			area_carta.configurar(dados)
			# Conecta para carregar a próxima quando esta for destruída
			area_carta.tree_exited.connect(proxima_carta)
	else:
		print("Fim das propostas!")
