extends CharacterBody2D

signal game_over

const VELOCIDAD = 100
const DISPARO = preload("res://Scenes/disparo_jugador.tscn")

var vidas = 3
var cont_formacion = 0
var inmune = false

func _physics_process(delta):
	var direccion: Vector2 = Input.get_vector("left", "right", "up", "down")
	
	velocity = direccion*VELOCIDAD
	
	if cont_formacion == 2:
		velocity /= 1.75
	
	if Input.is_action_pressed("slow"):
		%AnimatedSprite2D.play("crouch")
		%MostrarColision.visible = true
		
		velocity /= 2
		
	else:
		%AnimatedSprite2D.play("default")
		
		%MostrarColision.visible = false
	
	move_and_slide()
	
	if Input.is_action_pressed("shoot"):
		%Timer.paused = false
	else:
		%Timer.paused = true
	
	if Input.is_action_just_pressed("formation"):
		cont_formacion += 1
		if cont_formacion > 2:
			cont_formacion = 0
		
		formation()

func _process(delta):
	var hurtbox_overlap = %HurtboxContacto.get_overlapping_bodies()
	if hurtbox_overlap.size() > 0:
		impacto()

func disparar():
	var nuevo_disparo = DISPARO.instantiate()
	
	# Disparo del personaje principal
	nuevo_disparo.global_position = %OrigenDisparo.global_position
	%OrigenDisparo.add_child(nuevo_disparo)

func formation():
	match cont_formacion:
		# Formación 1: Frente
		0:
			%PosCompanionMagenta.position.x = 20
			
			%PosCompanionBlue.position.x = 15
			%PosCompanionBlue.position.y = 15
			
			%PosCompanionGreen.position.x = 15
			%PosCompanionGreen.position.y = -15
			
		# Formación 2: Retaguardia
		1:
			%PosCompanionMagenta.position.x = -20
			%PosCompanionMagenta.rotation_degrees = 180
			
			%PosCompanionBlue.position.x = -15
			%PosCompanionBlue.position.y = 15
			%PosCompanionBlue.rotation_degrees = 180
			
			%PosCompanionGreen.position.x = -15
			%PosCompanionGreen.position.y = -15
			%PosCompanionGreen.rotation_degrees = 180
			
		# Formación 3: Concentrado
		2:
			%PosCompanionMagenta.position.x = 20
			%PosCompanionMagenta.rotation_degrees = 0
			
			%PosCompanionBlue.position.x = 10
			%PosCompanionBlue.position.y = 0
			%PosCompanionBlue.rotation_degrees = 0
			
			%PosCompanionGreen.position.x = 30
			%PosCompanionGreen.position.y = 0
			%PosCompanionGreen.rotation_degrees = 0

func impacto():
	if inmune == false:
		vidas -= 1
		
		if vidas < 1:
			game_over.emit()
		else:
			%Timer2.start()
			
			inmune = true

func _on_timer_timeout():
	disparar()

func _on_timer_2_timeout():
	inmune = false
