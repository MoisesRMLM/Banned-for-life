extends Node2D

const SPAWNER_BLUE = preload("res://Scenes/spawner_enemigo_1_1.tscn")
const SPAWNER_GREEN = preload("res://Scenes/spawner_enemigo_1_2.tscn")

var cont_oleadas = 0
var vidas_jugador = 5

func _ready():
	%Vidas.text = "Vidas: " + str(vidas_jugador)
	%ContOleadas.text = "Oleada: " + str(cont_oleadas)

func _on_spawn_timeout():	
	for i in randf()*2 + 1:
		var nuevo_blue = SPAWNER_BLUE.instantiate()
		%PosBlue.add_child(nuevo_blue)
	
	for i in randf()*2 + 1:
		var nuevo_green = SPAWNER_GREEN.instantiate()
		%PosGreen.add_child(nuevo_green)
	
	cont_oleadas += 1
	%ContOleadas.text = "Oleada: " + str(cont_oleadas)

func _on_jugador_game_over():
	%GameOver.visible = true
	
	get_tree().paused = true

func _on_jugador_hit():
	vidas_jugador -= 1
	%Vidas.text = "Vidas: " + str(vidas_jugador)
	
