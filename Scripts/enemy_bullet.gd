extends CharacterBody2D
@onready var timer = $Timer
var main_menu = preload("res://Scenes/main_menu.tscn")
var speed = 300 

func _physics_process(delta):
	var collision_info = move_and_collide(velocity.normalized() * delta * speed)






func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		body.health -=1 
		if body.health <= 0: 
			body.get_node("AnimatedSprite2D").modulate = Color(1,0,0)
			await get_tree().create_timer(0.2).timeout
			timer.start()
			body.healthbar.health = body.health
		else:
			body.healthbar.health = body.health
		
		queue_free()

func _on_timer_timeout():
	GameManager.transition_to_scene(main_menu.resource_path)
