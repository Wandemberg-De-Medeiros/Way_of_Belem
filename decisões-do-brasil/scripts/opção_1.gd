extends Area2D

signal escolhida(impactos: Dictionary)

var impactos_locais = {}

func configurar_opcao(texto: String, f: int, i: int, v: int, p: int):
	# Ajuste o caminho da Label se ela não for filha direta da Area2D
	$Label.text = texto
	impactos_locais = {
		"floresta": f,
		"industria": i,
		"verba": v,
		"popularidade": p
	}

func tocar_musica():
	$audio_clique1.play()

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			tocar_musica()
			emit_signal("escolhida", impactos_locais)
			animar_saida_opcao()

func animar_saida_opcao():
	input_pickable = false
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.4)
