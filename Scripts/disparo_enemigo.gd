extends Area2D

const VELOCIDAD = 75
const MAX_DISTANCIA = 500

var distancia = 0

func _physics_process(delta):
	position += transform.x*VELOCIDAD*delta
	
	distancia += VELOCIDAD*delta
	if distancia > MAX_DISTANCIA:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	queue_free()
	
	if body.has_method("impacto"):
		body.impacto()
