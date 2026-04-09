extends Node2D

@export var lista_de_propostas: Array[Proposta] = []
@export var lista_de_buffs: Array[Proposta] = []
@onready var options: Panel = $options
@onready var moon: Node2D = $Moon/Area2D
@onready var panel_moon: Panel = $PanelMoon
@onready var secretaria: Node2D = $Secretaria/Area2D
@onready var panel_secretaria: Panel = $PanelSecretaria
@onready var panel_tutorial: Panel = $PanelTutorial

var cena_da_carta = preload("res://entidades/Carta.tscn")
var carta_ativa_node = null

func _ready():
	options.visible = false
	panel_moon.visible = false
	panel_secretaria.visible = false
	panel_tutorial.visible = false
	# randomize() não é mais necessário no Godot 4 (o motor já faz isso), 
	# mas não faz mal deixar.
	carregar_todas_as_cartas_da_pasta() 
	proxima_carta()
	GameManager.jogo_encerrado.connect(_on_jogo_encerrado)
	tocar_musica_com_atraso()
	if moon:
		moon.moon_clicked.connect(_on_moon_clicked)
	
	if secretaria:
		secretaria.secretaria_clicked.connect(_on_secretaria_clicked)
	
	
	if has_node("botao_abaixar_carta"):
		$botao_abaixar_carta.clicado.connect(_ao_clicar_no_botao_abaixar)

func _on_secretaria_clicked():
	_ao_clicar_no_botao_abaixar()
	if secretaria:
		panel_secretaria.visible = !panel_secretaria.visible

func _on_moon_clicked():
		_ao_clicar_no_botao_abaixar()
		if moon:
			panel_moon.visible = !panel_moon.visible
			await get_tree().create_timer(3.0).timeout
			panel_moon.visible = !panel_moon.visible
			_ao_clicar_no_botao_abaixar()

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
	
	var banco_buffs = load("res://banco_de_buffs.tres")
	if banco_buffs is ListaBuff:
		lista_de_buffs = banco_buffs.todos_os_buffs.duplicate()
		lista_de_buffs.shuffle()

func proxima_carta():
	if lista_de_propostas.is_empty():
		return
		
	var dados: Proposta
	var e_um_buff: bool = false

	# Lógica de 10% de chance para Buff
	if randf() <= 0.10 and not lista_de_buffs.is_empty():
		dados = lista_de_buffs.pop_front()
		e_um_buff = true
	else:
		dados = lista_de_propostas.pop_front()
		e_um_buff = false
	
	var instancia_cena = cena_da_carta.instantiate()
	add_child(instancia_cena)
	
	var area_carta = instancia_cena.get_node_or_null("Area2D")
	carta_ativa_node = area_carta
	
	if area_carta:
		if not area_carta.tree_exited.is_connected(proxima_carta):
			area_carta.tree_exited.connect(proxima_carta)
		
		# Passamos a informação se é buff para a carta saber se deve esconder as opções
		area_carta.configurar(dados, e_um_buff)
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


func _on_icone_config_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		_ao_clicar_no_botao_abaixar()
		options.visible = !options.visible


func _on_button_pressed() -> void:
	_ao_clicar_no_botao_abaixar()
	options.visible = !options.visible

func _on_não_pressed() -> void:
	_ao_clicar_no_botao_abaixar()
	panel_secretaria.visible = !panel_secretaria.visible


func _on_sim_pressed() -> void:
	panel_secretaria.visible = !panel_secretaria.visible
	panel_tutorial.visible = !panel_tutorial.visible


func _on_sair_pressed() -> void:
	_ao_clicar_no_botao_abaixar()
	panel_tutorial.visible = !panel_tutorial.visible
