extends CharacterBody2D

const PROYECTIL = preload("res://Scenes/disparo_enemigo.tscn")
const VEL_ROTACION = 0.4
const MAX_PROYECTILES = 50

var hp = 3
var empezar_disparar = false
var num_proyectiles = 0

func _process(delta):
	if empezar_disparar:
		%Rotater.rotate(VEL_ROTACION)
		disparar()
		
		num_proyectiles += 1
		
		if num_proyectiles >= MAX_PROYECTILES:
			empezar_disparar = false

func disparar():
	var nuevo_proyectil = PROYECTIL.instantiate()
	nuevo_proyectil.global_position = %Rotater.global_position
	nuevo_proyectil.global_rotation = %Rotater.global_rotation
	%Rotater.add_child(nuevo_proyectil)

func impacto():
	hp -= 1
	
	if hp <= 0:
		eliminado()

func eliminado():
	global_position.y = 1250
	%Borrar.start()

func _on_empezar_disparar_timeout() -> void:
	empezar_disparar = true

func _on_borrar_timeout() -> void:
	queue_free()
