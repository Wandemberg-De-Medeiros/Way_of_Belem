extends CanvasLayer

func _ready():
	# Garante que o jogo não está pausado quando a tela aparece
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_botão_reiniciar_pressed() -> void:
	# 1. Reseta os valores no GameManager
	GameManager.floresta = 70
	GameManager.industria = 70
	GameManager.verba = 70
	GameManager.popularidade = 70
	GameManager.contador_cartas = 0
	
	# 2. Destrava o tempo do jogo caso tenha usado Engine.time_scale
	Engine.time_scale = 1.0
	
	# 3. Recarrega a cena principal (ajuste o caminho se necessário)
	get_tree().change_scene_to_file("res://Cenas/Game.tscn")


func _on_botão_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/Menu_Inicial.tscn")
