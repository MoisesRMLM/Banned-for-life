extends Marker2D

const VELOCIDAD = 75
const MAX_MOVIMIENTO = 100
var movimiento = 0
var direccion = 1

func _ready():
	%RefAltura.position.y = -randf()*144

func _process(delta):
	if movimiento < MAX_MOVIMIENTO:
		position -= transform.x*VELOCIDAD*direccion*delta
		movimiento += 1
	else:
		if movimiento == MAX_MOVIMIENTO && direccion == 1:
			direccion = 0
			%Timer.start()
			
			movimiento += 1
	
	if movimiento == MAX_MOVIMIENTO && direccion == -1:
		global_position.y = 1250
		%Borrar.start()

func _on_timer_timeout():
	direccion = -1
	movimiento = 0

func _on_borrar_timeout() -> void:
	queue_free()
