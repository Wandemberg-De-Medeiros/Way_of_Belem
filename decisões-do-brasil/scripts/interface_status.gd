extends HBoxContainer

@onready var barra_floresta = $icone_floresta/BarraProgresso
@onready var barra_industria = $icone_industria/BarraProgresso
@onready var barra_verba = $icone_verba/BarraProgresso
@onready var barra_popularidade = $icone_povo/BarraProgresso

# Cores para o feedback visual
var cor_normal = Color("ffffff") # Branco (ou a cor original da sua barra)
var cor_alerta = Color("ff3333") # Vermelho

func _ready():
	GameManager.status_atualizado.connect(atualizar_tudo)
	# Inicializa sem animação no primeiro frame para não começar do zero
	configurar_inicial()

func configurar_inicial():
	barra_floresta.value = GameManager.floresta
	barra_industria.value = GameManager.industria
	barra_verba.value = GameManager.verba
	barra_popularidade.value = GameManager.popularidade
	verificar_cores()

func atualizar_tudo():
	# Criamos um único Tween para gerenciar todas as barras simultaneamente
	var tween = create_tween().set_parallel(true)
	
	# 1. Animação suave (Duração de 0.8 segundos)
	# O .set_trans(Tween.TRANS_SINE) dá o toque suave "líquido"
	tween.tween_property(barra_floresta, "value", GameManager.floresta, 0.8).set_trans(Tween.TRANS_SINE)
	tween.tween_property(barra_industria, "value", GameManager.industria, 0.8).set_trans(Tween.TRANS_SINE)
	tween.tween_property(barra_verba, "value", GameManager.verba, 0.8).set_trans(Tween.TRANS_SINE)
	tween.tween_property(barra_popularidade, "value", GameManager.popularidade, 0.8).set_trans(Tween.TRANS_SINE)
	
	# Atualiza os textos numéricos
	$icone_floresta/Valor.text = str(GameManager.floresta)
	$icone_industria/Valor.text = str(GameManager.industria)
	$icone_verba/Valor.text = str(GameManager.verba)
	$icone_povo/Valor.text = str(GameManager.popularidade)
	
	# 2. Verificar cores (Chamado após o início da animação)
	verificar_cores()

func verificar_cores():
	# Função auxiliar para aplicar a cor vermelha se abaixo de 30
	_aplicar_cor_alerta(barra_floresta, GameManager.floresta)
	_aplicar_cor_alerta(barra_industria, GameManager.industria)
	_aplicar_cor_alerta(barra_verba, GameManager.verba)
	_aplicar_cor_alerta(barra_popularidade, GameManager.popularidade)

func _aplicar_cor_alerta(barra: TextureProgressBar, valor: int):
	if valor <= 30:
		# Se a sua barra for TextureProgressBar, usamos a propriedade tint_progress
		barra.tint_progress = cor_alerta
	else:
		barra.tint_progress = cor_normal
