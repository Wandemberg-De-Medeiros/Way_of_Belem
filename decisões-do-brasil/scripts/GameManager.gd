extends Node

# Valores iniciais
var floresta: int = 50
var industria: int = 50
var verba: int = 50
var popularidade: int = 50

# Sinal para avisar a interface que os números mudaram
signal status_atualizado

func aplicar_mudancas(f, i, v, p):
	# Soma os impactos (podem ser positivos ou negativos)
	floresta = clampi(floresta + f, 0, 100)
	industria = clampi(industria + i, 0, 100)
	verba = clampi(verba + v, 0, 100)
	popularidade = clampi(popularidade + p, 0, 100)
	
	# Emite o sinal para os ícones se atualizarem
	status_atualizado.emit()
	
	_checar_fim_de_jogo()

func _checar_fim_de_jogo():
	if floresta <= 0 or popularidade <= 0 or verba <= 0 or industria <= 0:
		print("GAME OVER")
