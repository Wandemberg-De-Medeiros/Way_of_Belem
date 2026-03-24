extends Area2D

func _ready():
	$Sprite_Aberta.visible = false
	$Botao_Creditos.input_pickable = false

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$Sprite_Aberta.visible = !$Sprite_Aberta.visible
		$Botao_Creditos.input_pickable = $Sprite_Aberta.visible

func _on_botao_creditos_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Indo para os Créditos...")
		# get_tree().change_scene_to_file("res://Cenas/Creditos.tscn")
