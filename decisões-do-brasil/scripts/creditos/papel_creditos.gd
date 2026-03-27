extends Area2D

var arrastando = false
var offset = Vector2.ZERO

func _ready():
	input_pickable = true
	rotation_degrees = randf_range(-5.0, 5.0)
	# Conecta o sinal de input via código para garantir que funcione
	if not is_connected("input_event", _on_input_event):
		input_event.connect(_on_input_event)

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# SÓ ENTRA SE NINGUÉM ESTIVER SENDO ARRASTADO NO JOGO INTEIRO
			if GameManager.papel_sendo_arrastado == null:
				GameManager.papel_sendo_arrastado = self # Eu me torno o papel da vez
				arrastando = true
				offset = global_position - get_global_mouse_position()
				
				# Puxa para frente na pilha
				var pai = get_parent()
				pai.move_child(self, pai.get_child_count() - 1)
		else:
			# Se eu soltar e eu era o cara sendo arrastado, libero a vaga
			if GameManager.papel_sendo_arrastado == self:
				GameManager.papel_sendo_arrastado = null
				arrastando = false

func _process(_delta):
	# Só se move se EU for o papel que o GameManager autorizou
	if arrastando and GameManager.papel_sendo_arrastado == self:
		global_position = get_global_mouse_position() + offset

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if not event.pressed:
			# Limpeza total ao soltar o mouse
			if GameManager.papel_sendo_arrastado == self:
				GameManager.papel_sendo_arrastado = null
			arrastando = false
