extends Area2D

# Referência ao nó de animação
@onready var _animated_sprite = $AnimatedSprite2D

# Variável para controlar o estado da porta
var is_open: bool = false

func _ready():
	# Garante que a animação comece no estado fechado (primeiro frame de close)
	_animated_sprite.play("open")
	_animated_sprite.stop()
	_animated_sprite.frame = 0

# Função nativa do Area2D para detectar eventos de entrada
func _input_event(_viewport, event, _shape_idx):
	# Verifica se foi um clique com o botão esquerdo do mouse
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		toggle_door()

func toggle_door():
	if not is_open:
		# Abrir a porta
		_animated_sprite.play("open")
		is_open = true
	else:
		# Fechar a porta
		_animated_sprite.play("close")
		is_open = false
