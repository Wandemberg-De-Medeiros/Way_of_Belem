extends HBoxContainer

# Referência direta para a barra dentro da cena instanciada da floresta
@onready var barra_floresta = $icone_floresta/BarraProgresso
@onready var barra_industria = $icone_industria/BarraProgresso
@onready var barra_verba = $icone_verba/BarraProgresso
@onready var barra_popularidade = $icone_povo/BarraProgresso

func _ready():
	# Conecta ao sinal global do GameManager
	GameManager.status_atualizado.connect(atualizar_barras)
	GameManager.status_atualizado.connect(atualizar_tudo)
	atualizar_barras()
	atualizar_tudo()

func atualizar_barras():
	# Atualiza o valor da barra de textura com o dado do GameManager
	barra_floresta.value = GameManager.floresta
	barra_industria.value = GameManager.industria
	barra_verba.value = GameManager.verba
	barra_popularidade.value = GameManager.popularidade
	
#Função para exibir o valor exato dos status durante teste e produção do jogo
func atualizar_tudo():
	$icone_floresta/Valor.text = str(GameManager.floresta)
	$icone_industria/Valor.text = str(GameManager.industria)
	$icone_verba/Valor.text = str(GameManager.verba)
	$icone_povo/Valor.text = str(GameManager.popularidade)
	
