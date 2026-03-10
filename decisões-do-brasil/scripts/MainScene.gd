extends Node2D

@export var lista_de_propostas: Array[Proposta] = []
var cena_da_carta = preload("res://entidades/Carta.tscn")

func _ready():
	proxima_carta()

func proxima_carta():
	if lista_de_propostas.size() > 0:
		var dados = lista_de_propostas.pop_front()
		var instancia_cena = cena_da_carta.instantiate()
		
		add_child(instancia_cena)
		
		# Define a posição exata que você pediu
		instancia_cena.global_position = Vector2(950, 450)
		
		# Acessa a Area2D para configurar o texto
		var area_carta = instancia_cena.get_node("Area2D")
		if area_carta:
			area_carta.configurar(dados)
			# Conecta para carregar a próxima quando esta for destruída
			area_carta.tree_exited.connect(proxima_carta)
	else:
		print("Fim das propostas!")
