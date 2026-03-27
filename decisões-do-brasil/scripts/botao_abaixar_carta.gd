extends Area2D

signal clicado

func _ready():
	$Sprite2D.flip_v = true
	

func tocar_musica():
	$clique.play()
	
func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			$Sprite2D.flip_v = !$Sprite2D.flip_v
			emit_signal("clicado")
			tocar_musica()
			
