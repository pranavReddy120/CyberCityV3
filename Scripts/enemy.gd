extends Node2D

@onready var timer = $Timer
var main_menu = preload("res://Scenes/main_menu.tscn")

func _on_area_2d_body_entered(body):
	if body.is_in_group("bullet"):
		$AnimatedSprite2D.modulate = Color(1, 0, 0)  # RGB values for red
		await get_tree().create_timer(0.2).timeout
		queue_free() #removes enemy from scene
	elif body.is_in_group("player"):
		body.get_node("AnimatedSprite2D").modulate = Color(1,0,0)
		await get_tree().create_timer(0.2).timeout
		timer.start()
		

func _on_timer_timeout():
	GameManager.transition_to_scene(main_menu.resource_path)
