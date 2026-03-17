extends Control

func _on_iniciar_governo_pressed() -> void:
	GameManager.floresta = 50
	GameManager.industria = 50
	GameManager.verba = 50
	GameManager.popularidade = 50
	
	get_tree().change_scene_to_file("res://Cenas/Game.tscn")

func _on_botao_sair_pressed():
	# Caso queira um botão de fechar o jogo já no menu
	get_tree().quit()
