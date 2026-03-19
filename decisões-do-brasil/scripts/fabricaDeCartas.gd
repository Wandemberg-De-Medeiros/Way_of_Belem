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
	
