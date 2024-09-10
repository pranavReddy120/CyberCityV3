extends CharacterBody2D

var speed = 300 

func _physics_process(delta):
	var collision_info = move_and_collide(velocity.normalized() * delta * speed)






func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		queue_free()
