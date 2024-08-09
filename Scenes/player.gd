extends CharacterBody2D


const bullet_path = preload("res://Scenes/bullet.tscn")

var speed = 300
var can_shoot = true

func shoot():
	var bullet = bullet_path.instantiate() # instance of a bullet
	get_parent().add_child(bullet) # sets the bullet as the child of the shooter
	bullet.global_position = $Node2D/Marker2D.global_position
	bullet.velocity = get_global_mouse_position() - bullet.position

func _process(delta):
	$Node2D.look_at(get_global_mouse_position())
	if Input.is_action_just_pressed('shoot'):
		if can_shoot:
			shoot()
			can_shoot = false
	elif Input.is_action_just_released('shoot'):
		can_shoot = true
