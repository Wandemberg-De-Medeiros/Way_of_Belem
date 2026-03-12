extends Area2D

var arrastando = false
var posicao_inicial = Vector2.ZERO
var limite_decisao = 150 

func _ready():
	# Forçamos a posição local a zero para alinhar com o pai Node2D
	position = Vector2.ZERO
	posicao_inicial = position

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			arrastando = event.pressed

func _process(_delta):
	if arrastando:
		# Calculamos o deslocamento baseado no mouse global em relação ao pai
		var mouse_x = get_global_mouse_position().x
		position.x = mouse_x - get_parent().global_position.x
		
		# Rotação baseada no deslocamento
		rotation_degrees = position.x * 0.1
	else:
		# Volta para o centro (0,0) relativo ao pai
		position.x = lerp(position.x, 0.0, 0.2)
		rotation_degrees = lerp(rotation_degrees, 0.0, 0.2)

func _input(event):
	if event is InputEventMouseButton and not event.pressed and arrastando:
		arrastando = false
		verificar_decisao()

func verificar_decisao():
	if position.x > limite_decisao:
		decidir("NAO")
		print("Vc esclheu não ")
	elif position.x < -limite_decisao:
		decidir("SIM")
		print("Vc esclheu sim ")

func configurar(dados: Proposta):
	$Label.text = dados.texto
	print("Surgiu nova carta. Verba: ", dados.verba, " | Floresta: ", dados.floresta," | Industria: ", dados.industria, " | Popularidade: ", dados.popularidade, )

func decidir(escolha):
	set_process_input(false)
	var tween = create_tween()
	var direcao = -1200 if escolha == "SIM" else 1200
	
	tween.tween_property(self, "position:x", direcao, 0.4).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	tween.finished.connect(get_parent().queue_free) # Deleta o Node2D pai também
