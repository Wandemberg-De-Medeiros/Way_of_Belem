@tool
extends Node

@export var GERAR_AGORA: bool = false : 
	set(valor):
		if valor == true:
			gerar_arquivos()
			GERAR_AGORA = false 

# Dados das cartas
var lista_para_gerar = [
	{"id": "001", "txt": "Construir uma serraria na reserva?", "flo": -20, "ind": +15, "ver": +10, "pop": -5},
	{"id": "002", "txt": "Investir em reflorestamento?", "flo": +25, "ind": -5, "ver": -15, "pop": +10},
	{"id": "003", "txt": "Subsidiar novas fábricas?", "flo": 0, "ind": +20, "ver": -10, "pop": +5},
	{"id": "004", "txt": "Taxar indústrias poluentes?", "flo": +10, "ind": -15, "ver": +20, "pop": -5}
]

func gerar_arquivos():
	var pasta = "res://Propostas/"
	
	# Garante que a pasta existe
	if not DirAccess.dir_exists_absolute(pasta):
		DirAccess.make_dir_absolute(pasta)
		print("Pasta Propostas criada!")
		
	for item in lista_para_gerar:
		# Se 'Proposta.new()' falhar, tente carregar o script manualmente:
		var script_proposta = load("res://scripts/Proposta.gd") # AJUSTE O CAMINHO SE PRECISAR
		var nova_proposta = script_proposta.new()
		
		# Preenchendo os dados (certifique-se que os nomes batem com o Proposta.gd)
		nova_proposta.texto = item["txt"]
		nova_proposta.floresta = item["flo"]
		nova_proposta.industria = item["ind"]
		nova_proposta.verba = item["ver"]
		nova_proposta.popularidade = item["pop"] # Nome exato do seu Proposta.gd
		
		var nome_arquivo = pasta + "carta_" + item["id"] + ".tres"
		var resultado = ResourceSaver.save(nova_proposta, nome_arquivo)
		
		if resultado == OK:
			print("Sucesso ao gerar: ", nome_arquivo)
		else:
			print("Erro ao salvar ", nome_arquivo, ". Código: ", resultado)
	
	# Avisa o Godot para mostrar os novos arquivos no FileSystem
	EditorInterface.get_resource_filesystem().scan()
