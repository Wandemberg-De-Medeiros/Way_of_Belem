@tool
extends Node

# O botão mágico no Inspetor
@export var GERAR_AGORA: bool = false : 
	set(valor):
		if valor == true:
			gerar_arquivos_v1()
			GERAR_AGORA = false 

func gerar_arquivos_v1():
	# DADOS DIRETAMENTE DENTRO DA FUNÇÃO (SOLUÇÃO MARRETA)
	var lista_local = [
		{
			"id": "001",
			"pergunta": "Grande jazida de ferro descoberta na Amazônia. O que fazer?",
			"opc1": {"txt": "Proibir Extração", "flo": 10, "ind": -10, "ver": -5, "pop": 5},
			"opc2": {"txt": "Extração Estatal", "flo": -15, "ind": 10, "ver": 20, "pop": 0},
			"opc3": {"txt": "Leiloar para Empresas", "flo": -25, "ind": 25, "ver": 40, "pop": -10}
		},
		{
			"id": "002",
			"pergunta": "O povo exige mais empregos na indústria pesada. Como reagir?",
			"opc1": {"txt": "Focar em TI (Verde)", "flo": 5, "ind": 5, "ver": -20, "pop": 5},
			"opc2": {"txt": "Abrir Fábricas", "flo": -20, "ind": 25, "ver": 15, "pop": 20},
			"opc3": {"txt": "Ignorar", "flo": 0, "ind": -10, "ver": 5, "pop": -25}
		},
		{
			"id": "003",
			"pergunta": "O setor agrícola pede subsídios para expandir pastagens.",
			"opc1": {"txt": "Negar Subsídio", "flo": 15, "ind": -5, "ver": 10, "pop": -15},
			"opc2": {"txt": "Apoio Moderado", "flo": -10, "ind": 5, "ver": -5, "pop": 10},
			"opc3": {"txt": "Apoio Total", "flo": -30, "ind": 15, "ver": -20, "pop": 20}
		},
		{
			"id": "004",
			"pergunta": "Crise energética iminente. Qual fonte priorizar?",
			"opc1": {"txt": "Energia Solar", "flo": 5, "ind": 10, "ver": -30, "pop": 10},
			"opc2": {"txt": "Hidrelétricas", "flo": -20, "ind": 15, "ver": -10, "pop": 5},
			"opc3": {"txt": "Termelétricas (Carvão)", "flo": -40, "ind": 25, "ver": 10, "pop": -5}
		},
		{
			"id": "005",
			"pergunta": "Movimentos sociais pedem demarcação de terras protegidas.",
			"opc1": {"txt": "Demarcar Tudo", "flo": 25, "ind": -20, "ver": -5, "pop": 15},
			"opc2": {"txt": "Demarcar Parte", "flo": 10, "ind": -5, "ver": 0, "pop": 5},
			"opc3": {"txt": "Priorizar Indústria", "flo": -25, "ind": 20, "ver": 15, "pop": -20}
		},
		{
			"id": "006",
			"pergunta": "Investidores estrangeiros querem construir um mega-porto.",
			"opc1": {"txt": "Rejeitar (Eco)", "flo": 10, "ind": -15, "ver": -10, "pop": -5},
			"opc2": {"txt": "Licença Restrita", "flo": -5, "ind": 10, "ver": 15, "pop": 5},
			"opc3": {"txt": "Licença Livre", "flo": -30, "ind": 30, "ver": 40, "pop": 10}
		},
		{
			"id": "007",
			"pergunta": "O ar das grandes cidades está irrespirável por poluição.",
			"opc1": {"txt": "Multar Indústrias", "flo": 5, "ind": -25, "ver": 20, "pop": 15},
			"opc2": {"txt": "Filtros Obrigatórios", "flo": 0, "ind": -10, "ver": -10, "pop": 5},
			"opc3": {"txt": "Não intervir", "flo": -15, "ind": 10, "ver": 0, "pop": -20}
		},
		{
			"id": "008",
			"pergunta": "Descoberta de nova tecnologia de reciclagem industrial.",
			"opc1": {"txt": "Investimento Público", "flo": 20, "ind": 10, "ver": -40, "pop": 10},
			"opc2": {"txt": "Isenção Fiscal", "flo": 10, "ind": 15, "ver": -15, "pop": 5},
			"opc3": {"txt": "Vender Patente", "flo": -5, "ind": 5, "ver": 30, "pop": -5}
		},
		{
			"id": "009",
			"pergunta": "Pescadores artesanais protestam contra pesca industrial.",
			"opc1": {"txt": "Banir Grandes Barcos", "flo": 20, "ind": -20, "ver": -5, "pop": 15},
			"opc2": {"txt": "Cotas de Pesca", "flo": 10, "ind": -5, "ver": 5, "pop": 0},
			"opc3": {"txt": "Liberar Geral", "flo": -30, "ind": 20, "ver": 15, "pop": -10}
		},
		{
			"id": "010",
			"pergunta": "A verba do governo está no fim. Onde cortar?",
			"opc1": {"txt": "Fiscalização Ambiental", "flo": -40, "ind": 10, "ver": 30, "pop": -10},
			"opc2": {"txt": "Subsídios Industriais", "flo": 5, "ind": -30, "ver": 30, "pop": -15},
			"opc3": {"txt": "Salário dos Políticos", "flo": 0, "ind": 0, "ver": 10, "pop": 50}
		}
	]

	var pasta = "res://Propostas/"
	
	# Garante que a pasta existe
	if not DirAccess.dir_exists_absolute(pasta):
		DirAccess.make_dir_absolute(pasta)
		print("Pasta Propostas criada agora!")

	for dados in lista_local:
		# Cria uma nova instância do recurso Proposta
		var p = Proposta.new()
		
		# Preenche os dados básicos
		p.id = dados["id"]
		p.texto_proposta = dados["pergunta"]
		
		# Preenche Opção 1
		p.texto_opc1 = dados["opc1"]["txt"]
		p.opc1_floresta = dados["opc1"]["flo"]
		p.opc1_industria = dados["opc1"]["ind"]
		p.opc1_verba = dados["opc1"]["ver"]
		p.opc1_popularidade = dados["opc1"]["pop"]
		
		# Preenche Opção 2
		p.texto_opc2 = dados["opc2"]["txt"]
		p.opc2_floresta = dados["opc2"]["flo"]
		p.opc2_industria = dados["opc2"]["ind"]
		p.opc2_verba = dados["opc2"]["ver"]
		p.opc2_popularidade = dados["opc2"]["pop"]
		
		# Preenche Opção 3
		p.texto_opc3 = dados["opc3"]["txt"]
		p.opc3_floresta = dados["opc3"]["flo"]
		p.opc3_industria = dados["opc3"]["ind"]
		p.opc3_verba = dados["opc3"]["ver"]
		p.opc3_popularidade = dados["opc3"]["pop"]
		
		# Salva o arquivo .tres
		var nome_arq = pasta + "carta_" + p.id + ".tres"
		var erro = ResourceSaver.save(p, nome_arq)
		
		if erro == OK:
			print("Sucesso! Arquivo gerado: ", nome_arq)
		else:
			print("Erro ao salvar: ", erro)

	# Força o Godot a mostrar os arquivos na aba FileSystem
	EditorInterface.get_resource_filesystem().scan()
	
