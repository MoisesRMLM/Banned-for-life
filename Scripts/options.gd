extends Control


func _on_boton_volver_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu_inicio.tscn")
