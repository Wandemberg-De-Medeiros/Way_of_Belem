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

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			emit_signal("escolhida", impactos_locais)
