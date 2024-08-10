extends Node2D



func _on_area_2d_body_entered(body):
	if body.is_in_group("bullet"):
		$AnimatedSprite2D.modulate = Color(1, 0, 0)  # RGB values for red
		await get_tree().create_timer(0.2).timeout
		queue_free() #removes enemy from scene
