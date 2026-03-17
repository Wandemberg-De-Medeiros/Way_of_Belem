extends Area2D

# Usamos caminhos relativos e proteção para evitar erros de 'Nil'
@onready var label_proposta = $Label

# get_node_or_null evita que o jogo quebre se o caminho estiver errado ou o nó sumir
@onready var area_opc1 = get_node_or_null("../opção_1/Area2D")
@onready var area_opc2 = get_node_or_null("../opção_2/Area2D")
@onready var area_opc3 = get_node_or_null("../opção_3/Area2D")

func configurar(dados: Proposta):
	# 1. Proteção: Se não houver dados, não faz nada
	if dados == null: 
		return
	
	# 2. O PULO DO GATO: Espera o nó entrar na árvore e estar pronto
	# Isso resolve o erro de "Attempt to call function on a null instance"
	if not is_node_ready():
		await ready

	# 3. Verificamos se cada nó realmente existe antes de atribuir valores
	if label_proposta:
		label_proposta.text = dados.texto_proposta
	
	# Configuramos as opções apenas se os nós foram encontrados
	if area_opc1:
		area_opc1.configurar_opcao(dados.texto_opc1, dados.opc1_floresta, dados.opc1_industria, dados.opc1_verba, dados.opc1_popularidade)
		if not area_opc1.is_connected("escolhida", _ao_escolher_opcao):
			area_opc1.escolhida.connect(_ao_escolher_opcao)

	if area_opc2:
		area_opc2.configurar_opcao(dados.texto_opc2, dados.opc2_floresta, dados.opc2_industria, dados.opc2_verba, dados.opc2_popularidade)
		if not area_opc2.is_connected("escolhida", _ao_escolher_opcao):
			area_opc2.escolhida.connect(_ao_escolher_opcao)

	if area_opc3:
		area_opc3.configurar_opcao(dados.texto_opc3, dados.opc3_floresta, dados.opc3_industria, dados.opc3_verba, dados.opc3_popularidade)
		if not area_opc3.is_connected("escolhida", _ao_escolher_opcao):
			area_opc3.escolhida.connect(_ao_escolher_opcao)

func _ao_escolher_opcao(impactos: Dictionary):
	# Segurança extra: se o GameManager sumir durante o fechamento, não trava
	if Engine.is_editor_hint(): return
	
	GameManager.aplicar_mudancas(
		impactos.floresta, 
		impactos.industria, 
		impactos.verba, 
		impactos.popularidade
	)
	
	animar_saida()

func animar_saida():
	# Verifica se o pai ainda existe para evitar erro ao deletar
	var pai = get_parent()
	if pai:
		var tween = create_tween()
		tween.tween_property(pai, "modulate:a", 0, 0.4)
		tween.finished.connect(func(): 
			if is_instance_valid(pai):
				pai.queue_free()
		)
		
