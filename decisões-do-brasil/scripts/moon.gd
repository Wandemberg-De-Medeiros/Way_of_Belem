extends Area2D

func _ready() -> void:
	$"caixa de texto".visible = false
	$Label.visible = false

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$"caixa de texto".visible = !$"caixa de texto".visible
		$Label.visible = !$Label.visible
		
		await get_tree().create_timer(3.0).timeout
		$"caixa de texto".visible = !$"caixa de texto".visible
		$Label.visible = !$Label.visible
