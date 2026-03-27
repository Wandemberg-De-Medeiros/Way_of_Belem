extends Node2D

func _ready():
	# Garante que o jogo não está pausado quando a tela aparece
	process_mode = Node.PROCESS_MODE_ALWAYS
	if has_node("TextoMotivo"):
		$TextoMotivo.text = GameManager.mensagem_final
	tocar_musica()

func tocar_musica():
	$AudioGameOver.play()

func tocar_clique():
	$clique.play()

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
	tocar_clique()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://Cenas/Game.tscn")


func _on_botão_menu_pressed() -> void:
	GameManager.floresta = 70
	GameManager.industria = 70
	GameManager.verba = 70
	GameManager.popularidade = 70
	GameManager.contador_cartas = 0
	
	# 2. Destrava o tempo do jogo caso tenha usado Engine.time_scale
	Engine.time_scale = 1.0
	tocar_clique()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://Cenas/Menu_Inicial.tscn")
