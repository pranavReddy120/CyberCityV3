extends CharacterBody2D
var speed = 60.0
var facing_right = true
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const bullet_path = preload("res://Scenes/enemy_bullet.tscn")
var main_menu = preload("res://Scenes/main_menu.tscn")
var in_range = false
@onready var healthbar = $HealthBar
var health = 3

func _ready():
	$AnimatedSprite2D.play("walk")
	healthbar.init_health(health) 

func _physics_process(delta):
		
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if !$RayCast2D.is_colliding() && is_on_floor():
		flip()
	
	velocity.x = speed
	move_and_slide()
	
func flip():
	facing_right = !facing_right
	scale.x = abs(scale.x) * -1
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1
		
func _on_timer_timeout():
	GameManager.transition_to_scene(main_menu.resource_path)
	
func start_walk():
	$AnimatedSprite2D.play("walk")

func _on_detector_body_entered(body):  #For some reason the exit detector is running even while the player hasn't left
	if body.is_in_group("player"):
		in_range = true
		while in_range:
			fire()
			await get_tree().create_timer(2).timeout
	

func _on_detector_body_exited(body):
	if body.is_in_group("player"):
		print("left")
		in_range = false
		speed = 60
		if facing_right:
			speed = abs(speed)
		else:
			speed = abs(speed) * -1
		start_walk()


func fire():
	speed = 0
	$AnimatedSprite2D.play("Stand")
	var bullet = bullet_path.instantiate() 
	get_parent().add_child(bullet) # sets the bullet as the child of the shooter
	bullet.global_position = $Node2D/Marker2D.global_position
	bullet.velocity = $Aim.global_position - bullet.position
	


func _on_bullet_detector_body_entered(body):
	if body.is_in_group("bullet"):
		health -= 1 
		body.queue_free()
		if health <= 0: 
			$AnimatedSprite2D.modulate = Color(1, 0, 0)  # RGB values for red
			await get_tree().create_timer(0.2).timeout
			queue_free() #removes enemy from scene
		healthbar.health = health
