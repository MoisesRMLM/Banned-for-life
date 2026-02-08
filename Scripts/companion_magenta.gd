extends CharacterBody2D

const DISPARO = preload("res://Scenes/disparo_companion.tscn")

func _physics_process(delta):
	if Input.is_action_pressed("shoot"):
		%Timer.paused = false
	else:
		%Timer.paused = true

func disparar():
	var nuevo_disparo = DISPARO.instantiate()
	
	nuevo_disparo.global_position = %OrigenDisparo.global_position
	nuevo_disparo.global_rotation = %OrigenDisparo.global_rotation
	%OrigenDisparo.add_child(nuevo_disparo)
	
	%AudioStreamPlayer2.play()

func _on_timer_timeout():
	disparar()
