extends CharacterBody2D


const bullet_path = preload("res://Scenes/bullet.tscn")
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D
@onready var healthbar = $CanvasLayer/HealthBar


const SPEED = 150
const JUMP_VELOCITY = -300
var speed = 300
var can_shoot = true
var facing = true
var health = 10


func _ready():
	healthbar.init_health(health) 
		
		
func shoot():
	var bullet = bullet_path.instantiate() # instance of a bullet
	get_parent().add_child(bullet) # sets the bullet as the child of the shooter
	if facing:
		bullet.global_position = $Node2D/Marker2D.global_position
		bullet.velocity = $Aim1.global_position - bullet.position
	elif !facing:
		bullet.global_position = $Node2D/Marker2D2.global_position
		bullet.velocity = $Aim2.global_position - bullet.position
	

func _process(delta):
	if Input.is_action_just_pressed('shoot'):
		if GameManager.current_ammo == 0: 
			can_shoot = false
		if can_shoot:
			shoot()
			GameManager.current_ammo -= 1
			can_shoot = false
	elif Input.is_action_just_released('shoot'):
		can_shoot = true
		
	elif Input.is_action_just_pressed('reload'): 
		if GameManager.reserve_ammo > 0:
			if GameManager.reserve_ammo + GameManager.current_ammo <= GameManager.max_ammo:
				GameManager.current_ammo += GameManager.reserve_ammo
				GameManager.reserve_ammo = 0
			else: 
				GameManager.reserve_ammo -= GameManager.max_ammo - GameManager.current_ammo
				GameManager.current_ammo = GameManager.max_ammo
				
		else:
			return
		
	elif Input.is_action_just_pressed('esc'):
		GameManager.pause_game()
	
		
# making movement
# I was thinking arrows for movement and space for shoot. if we have interactions and maybe like inventory slots
# We should use the number keys. we can have like movement in the right hand and interaction in the left
func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var direction = Input.get_axis("left","right")
	
	if direction > 0:
		animated_sprite.flip_h = false
		facing = true
	elif direction < 0:
		animated_sprite.flip_h = true
		facing = false
	
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	



