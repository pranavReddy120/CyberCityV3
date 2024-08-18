extends Node2D

var level_2 = preload("res://Scenes/level_2.tscn")

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		print("teleporting")
		for i in 3: 
			await get_tree().create_timer(0.5).timeout
			body.modulate.a8 = 100
			await get_tree().create_timer(0.5).timeout
			body.modulate.a8 = 255
		
		GameManager.transition_to_scene(level_2.resource_path)
