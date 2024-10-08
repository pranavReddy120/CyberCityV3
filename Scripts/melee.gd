extends CharacterBody2D

var speed = 60.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var timer = $Timer
var main_menu = preload("res://Scenes/main_menu.tscn")
@onready var healthbar = $HealthBar
var health = 3
var facing_right = true

func _ready():
	$AnimatedSprite2D.play("run")
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
	
func hit():
	speed = 0
	$AnimatedSprite2D.play("attack")
	await get_tree().create_timer(0.7).timeout
	
func start_walk():
	$AnimatedSprite2D.play("run")

func _on_attack_body_entered(body):
	if body.is_in_group("player"):
		hit()
		await get_tree().create_timer(0.5).timeout
		$Swing.monitoring = true
		await get_tree().create_timer(0.2).timeout
		$Swing.monitoring = false




func _on_attack_body_exited(body):
	speed = 60
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1
	start_walk()
	

func _on_swing_body_entered(body):
	if body.is_in_group("player"):
			body.health -=1 
			if body.health <= 0: 
				body.get_node("AnimatedSprite2D").modulate = Color(1,0,0)
				await get_tree().create_timer(0.2).timeout
				timer.start()
				body.healthbar.health = body.health
			else:
				body.healthbar.health = body.health
		


func _on_bullet_detector_body_entered(body):
	if body.is_in_group("bullet"):
		health -= 1 
		body.queue_free()
		if health <= 0: 
			$AnimatedSprite2D.modulate = Color(1, 0, 0)  # RGB values for red
			await get_tree().create_timer(0.2).timeout
			queue_free() #removes enemy from scene
		healthbar.health = health

