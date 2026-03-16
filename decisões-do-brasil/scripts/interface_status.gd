extends HBoxContainer

func _ready():
	# Se conecta ao sinal global do GameManager
	GameManager.status_atualizado.connect(atualizar_tudo)
	# Atualiza assim que o jogo abre para não começar com "0"
	atualizar_tudo()

func atualizar_tudo():
	# Buscamos as labels dentro de cada cena instanciada
	# Certifique-se que o nome após o $ seja igual ao que está na sua árvore
	$icone_floresta/Valor.text = str(GameManager.floresta)
	$icone_industria/Valor.text = str(GameManager.industria)
	$icone_verba/Valor.text = str(GameManager.verba)
	$icone_povo/Valor.text = str(GameManager.popularidade)
