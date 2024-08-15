extends Area2D

@onready var timer = $Timer
var main_menu = preload("res://Scenes/main_menu.tscn")

func _on_timer_timeout():
	GameManager.transition_to_scene(main_menu.resource_path)




func _on_body_entered(body):
	timer.start()
