extends Area2D

func _ready():
	$Sprite_Aberta.visible = false
	$Label.visible = false
	$Botao_Creditos.input_pickable = false

func tocar_musica():
	$clique.play()

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$Sprite_Aberta.visible = !$Sprite_Aberta.visible
		$Label.visible = !$Label.visible
		$Botao_Creditos.input_pickable = $Sprite_Aberta.visible
		tocar_musica()

func _on_botao_creditos_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		tocar_musica()
		await get_tree().create_timer(0.1).timeout
		get_tree().change_scene_to_file("res://Cenas/pre_creditos.tscn")
