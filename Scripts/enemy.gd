extends Node2D

@onready var timer = $Timer
@onready var healthbar = $HealthBar
var main_menu = preload("res://Scenes/main_menu.tscn")
var health = 3

func _ready():
	healthbar.init_health(health) 
	
func _on_area_2d_body_entered(body):
	if body.is_in_group("bullet"):
		health -= 1 
		body.queue_free()
		if health <= 0: 
			$AnimatedSprite2D.modulate = Color(1, 0, 0)  # RGB values for red
			await get_tree().create_timer(0.2).timeout
			queue_free() #removes enemy from scene
		healthbar.health = health
	elif body.is_in_group("player"):
		body.health -=1 
		if body.health <= 0: 
			body.get_node("AnimatedSprite2D").modulate = Color(1,0,0)
			await get_tree().create_timer(0.2).timeout
			timer.start()
			body.healthbar.health = body.health
		else:
			body.healthbar.health = body.health
		
		

func _on_timer_timeout():
	GameManager.transition_to_scene(main_menu.resource_path)
