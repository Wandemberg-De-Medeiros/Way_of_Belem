extends Node

signal jogo_encerrado
signal status_atualizado

var papel_sendo_arrastado = null 
var mensagem_final: String = ""

# Valores iniciais
var floresta: int = 70
var industria: int = 70
var verba: int = 70
var popularidade: int = 70

var contador_cartas: int = 0
const meta_vitoria: int = 48

func aplicar_mudancas(f: int, i: int, v: int, p: int, ignorar_contagem: bool = false):
	# 1. Aplicamos a soma PRIMEIRO
	floresta += f
	industria += i
	verba += v
	popularidade += p
	
	# 2. Incrementamos o contador de cartas
	if not ignorar_contagem:
		contador_cartas += 1
	
	# 3. Emitimos o sinal para a UI (ícones) atualizar ANTES do Game Over
	status_atualizado.emit()
	
	# 4. Chamamos a checagem
	_checar_fim_de_jogo()
	
	# 5. Só depois da checagem aplicamos o clamp para a interface não bugar 
	# (Mas a checagem acima já terá pego se passou de 150 ou caiu de 0)
	floresta = clampi(floresta, 0, 150)
	industria = clampi(industria, 0, 150)
	verba = clampi(verba, 0, 150)
	popularidade = clampi(popularidade, 0, 150)

func _checar_fim_de_jogo():
	print("Checando fim de jogo... Cartas: ", contador_cartas, " F:", floresta, " I:", industria)
	
	# DERROTA POR FALTA (0 ou menos)
	if floresta <= 0:
		terminar_jogo("A floresta foi totalmente devastada. O calor em Belém tornou-se insuportável.", false)
		return # O 'return' impede que ele cheque as outras condições se já perdeu
	if industria <= 0:
		terminar_jogo("A economia parou. Sem indústria, o estado faliu miseravelmente.", false)
		return
	if verba <= 0:
		terminar_jogo("Os cofres públicos estão vazios. O governo não consegue mais operar.", false)
		return
	if popularidade <= 0:
		terminar_jogo("O povo se rebelou contra sua má gestão e você foi deposto.", false)
		return
	
	# DERROTA POR EXCESSO (150 ou mais)
	if floresta >= 150:
		terminar_jogo("A selva cresceu sem controle, engolindo as estradas e isolando as cidades.", false)
		return
	if industria >= 150:
		terminar_jogo("A poluição industrial tornou o ar de Belém irrespirável.", false)
		return
	if verba >= 150:
		terminar_jogo("O excesso de impostos e acúmulo de capital gerou uma revolução armada.", false)
		return
	if popularidade >= 150:
		terminar_jogo("Seu governo tornou-se uma tirania absoluta, sufocando a liberdade do povo.", false)
		return
	
	# VITÓRIA
	if contador_cartas >= meta_vitoria:
		terminar_jogo("Você conseguiu equilibrar os interesses do Pará e completou seu mandato!", true)

func terminar_jogo(texto, vitoria):
	print("FIM DE JOGO: ", texto)
	mensagem_final = texto
	jogo_encerrado.emit()
	
	await get_tree().create_timer(0.2).timeout
	
	var caminho_cena = "res://Cenas/vitoria.tscn" if vitoria else "res://Cenas/game_over.tscn"
	
	# Verifica se o arquivo existe antes de mudar, para não travar o executável
	if ResourceLoader.exists(caminho_cena):
		get_tree().change_scene_to_file(caminho_cena)
	else:
		print("ERRO: Cena não encontrada em: ", caminho_cena)
