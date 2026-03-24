extends Area2D

@onready var sprite = $Pasta # Certifique-se que o nome é igual ao do nó
var original_y: float

func _ready():
	original_y = sprite.position.y
	# Conectando os sinais via código para facilitar
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	input_event.connect(_on_input_event)

func _on_mouse_entered():
	# Efeito de "Pulo" ao passar o mouse
	var tween = create_tween()
	tween.tween_property(sprite, "position:y", original_y - 10, 0.1).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(sprite, "position:y", original_y, 0.1).set_delay(0.1)

func _on_mouse_exited():
	# Garante que o item volte ao lugar se o mouse sair rápido demais
	sprite.position.y = original_y

func _on_input_event(_viewport, event, _shape_idx):
	# Detecta o clique do mouse
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		executar_acao()

func executar_acao():
	if name == "GavetaEsquerda":
		sprite.texture = load("res://Gaveta_praquela_pasta_ali_o.png")
	elif name == "GavetaDireita":
		sprite.texture = load("res://Gaveta_pro_clashroyale.png")
	else:
		print("Clicou no item: ", name)
