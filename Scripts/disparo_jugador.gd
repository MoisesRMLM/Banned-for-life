extends Area2D

const VELOCIDAD = 200
const MAX_DISTANCIA = 2000

var distancia = 0

func _physics_process(delta):
	position.x += VELOCIDAD*delta
	
	distancia += VELOCIDAD*delta
	if distancia > MAX_DISTANCIA:
		queue_free()

func _on_body_entered(body: Node2D):
	queue_free()
	
	if body.has_method("impacto"):
		body.impacto()
