extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func tocar_musica():
	$clique.play()

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		tocar_musica()
		await get_tree().create_timer(0.2).timeout
		get_tree().change_scene_to_file("res://Cenas/Menu_Inicial.tscn")
