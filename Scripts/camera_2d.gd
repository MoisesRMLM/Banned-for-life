extends Camera2D

var velocidad = 0

func _process(delta):
	position.x += velocidad*delta
