extends Node2D

@onready var splash = $CanvasLayer/SplashScreen

func _ready():
	# 1. Configurar Splash Screen
	iniciar_splash()
	

func iniciar_splash():
	# Garante que o ColorRect bloqueie cliques enquanto visível
	splash.mouse_filter = Control.MOUSE_FILTER_STOP
	var tween = create_tween()
	tween.tween_property(splash, "modulate:a", 0, 2.0) # 2 segundos para sumir
	tween.finished.connect(func(): 
		splash.visible = false
		# Libera cliques para o que está atrás
		splash.mouse_filter = Control.MOUSE_FILTER_IGNORE 
	)
	
# --- Cliques nos Itens da Mesa ---

func _on_botao_pasta_principal_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		GameManager.floresta = 70
		GameManager.industria = 70
		GameManager.verba = 70
		GameManager.popularidade = 70
	
	get_tree().change_scene_to_file("res://Cenas/Game.tscn")

func _on_botao_cafe_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		print("Abrindo Conquistas...")

func _on_botao_interfone_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		print("Abrindo Configurações...")
