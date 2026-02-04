extends CharacterBody2D

const VELOCIDAD = 70

func _physics_process(delta):
	var direccion: Vector2 = Input.get_vector("left", "right", "up", "down")
	
	velocity = direccion*VELOCIDAD
	if Input.is_action_pressed("slow"):
		
		
		velocity /= 2
		
		%MostrarColision.visible = true
	else:
		%MostrarColision.visible = false
	
	move_and_slide()
	
	if Input.is_action_pressed("shoot"):
		%Timer.paused = false
	else:
		%Timer.paused = true

func disparar():
	const DISPARO = preload("res://Scenes/disparo_jugador.tscn")
	var nuevo_disparo = DISPARO.instantiate()
	
	nuevo_disparo.global_position = %OrigenDisparo.global_position
	%OrigenDisparo.add_child(nuevo_disparo)

func _on_timer_timeout():
	disparar()
