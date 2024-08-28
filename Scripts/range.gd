extends CharacterBody2D
var speed = 60.0
var facing_right = true
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const bullet_path = preload("res://Scenes/enemy_bullet.tscn")
var main_menu = preload("res://Scenes/main_menu.tscn")

func _ready():
	$AnimatedSprite2D.play("walk")

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

func _on_detector_body_entered(body):
	facing_right = true
	fire()
	await get_tree().create_timer(0.5).timeout

func _on_detector_body_exited(body):
	start_walk()


func fire():
	$AnimatedSprite2D.play("Stand")
	var bullet = bullet_path.instantiate() 
	get_parent().add_child(bullet) # sets the bullet as the child of the shooter
	bullet.global_position = $Node2D/Marker2D.global_position
	bullet.velocity = $Aim.global_position - bullet.position


func _on_detector_2_body_entered(body):
	facing_right = false
	fire_left()
	await get_tree().create_timer(0.5).timeout

func fire_left():
	$AnimatedSprite2D.play("Stand")
	var bullet = bullet_path.instantiate() 
	get_parent().add_child(bullet)
	bullet.global_position = $Node2D/Marker2D2.global_position
	bullet.velocity = $Aim2.global_position - bullet.position 

func _on_detector_2_body_exited(body):
	start_walk()
