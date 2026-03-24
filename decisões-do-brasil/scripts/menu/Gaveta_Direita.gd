extends Area2D

func _ready():
	$Sprite_Aberta.visible = false
	$Botao_Sair.input_pickable = false

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$Sprite_Aberta.visible = !$Sprite_Aberta.visible
		$Botao_Sair.input_pickable = $Sprite_Aberta.visible

func _on_botao_sair_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Saindo do jogo...")
		get_tree().quit()
