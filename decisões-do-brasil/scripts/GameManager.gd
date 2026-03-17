extends Node

# Valores iniciais
var floresta: int = 70
var industria: int = 70
var verba: int = 70
var popularidade: int = 70

# Sinal para avisar a interface que os números mudaram
signal status_atualizado

func aplicar_mudancas(f, i, v, p):
	# Soma os impactos (podem ser positivos ou negativos)
	floresta = clampi(floresta + f, 0, 150)
	industria = clampi(industria + i, 0, 150)
	verba = clampi(verba + v, 0, 150)
	popularidade = clampi(popularidade + p, 0, 150)
	
	# Emite o sinal para os ícones se atualizarem
	status_atualizado.emit()
	
	_checar_fim_de_jogo()

func _checar_fim_de_jogo():
	var acabou_por_falta = floresta <= 0 or industria <= 0 or verba <= 0 or popularidade <= 0
	var acabou_por_excesso = floresta >= 150 or industria >= 150 or verba >= 150 or popularidade >= 150
	
	if acabou_por_falta or acabou_por_excesso:
		get_tree().call_deferred("change_scene_to_file", "res://cenas/game_over.tscn")
