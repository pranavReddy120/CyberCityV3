extends Node2D

var enemy_scene = preload("res://Scenes/enemy.tscn")

func _on_enemy_spawner_timeout():
	var enemy_instance = enemy_scene.instantiate()  # Instantiate the enemy scene
	if enemy_instance:
		var enemy_position = Vector2(randi_range(-190, 190), randi_range(-105, 105))  # Random position within camera-view
		while enemy_position.x < -25 and enemy_position.x > 25 or enemy_position.y < -30 or enemy_position.y > 30: #ensures enemy does not spawn on player
			enemy_position = Vector2(randi_range(-190, 190), randi_range(-105, 105))
	
		enemy_instance.position = enemy_position  # Set the enemy's positio
		add_child(enemy_instance)  # Add the enemy to the scene
