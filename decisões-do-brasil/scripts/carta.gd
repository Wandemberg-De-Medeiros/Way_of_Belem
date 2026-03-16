extends Area2D

# Referências baseadas na sua imagem
# No topo do carta.gd
@onready var label_proposta = $Label
@onready var area_opc1 = get_node("../opção_1/Area2D")
@onready var area_opc2 = get_node("../opção_2/Area2D")
@onready var area_opc3 = get_node("../opção_3/Area2D")

func configurar(dados: Proposta):
	if dados == null: return
	
	label_proposta.text = dados.texto_proposta
	
	# Configura cada sub-entidade
	area_opc1.configurar_opcao(dados.texto_opc1, dados.opc1_floresta, dados.opc1_industria, dados.opc1_verba, dados.opc1_popularidade)
	area_opc2.configurar_opcao(dados.texto_opc2, dados.opc2_floresta, dados.opc2_industria, dados.opc2_verba, dados.opc2_popularidade)
	area_opc3.configurar_opcao(dados.texto_opc3, dados.opc3_floresta, dados.opc3_industria, dados.opc3_verba, dados.opc3_popularidade)
	
	# Conecta os sinais de clique
	if not area_opc1.is_connected("escolhida", _ao_escolher_opcao):
		area_opc1.escolhida.connect(_ao_escolher_opcao)
		area_opc2.escolhida.connect(_ao_escolher_opcao)
		area_opc3.escolhida.connect(_ao_escolher_opcao)

func _ao_escolher_opcao(impactos: Dictionary):
	# Envia os valores para o GameManager processar
	GameManager.aplicar_mudancas(
		impactos.floresta, 
		impactos.industria, 
		impactos.verba, 
		impactos.popularidade
	)
	
	animar_saida()

func animar_saida():
	var tween = create_tween()
	# Animação simples: a carta e as opções somem
	tween.tween_property(get_parent(), "modulate:a", 0, 0.4)
	tween.finished.connect(func(): get_parent().queue_free())
	
