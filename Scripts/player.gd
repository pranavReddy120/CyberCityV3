extends CharacterBody2D


const bullet_path = preload("res://Scenes/bullet.tscn")
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D
#@onready var main_menu = preload("res://Menus/main_menu.tscn") as PackedScene

const SPEED = 150
const JUMP_VELOCITY = -300
var speed = 300
var can_shoot = true
var direction = Vector2.RIGHT

func Facing_Direction():
	#default is to look right
	if Input.is_action_pressed("right"):
		direction = Vector2.RIGHT
	if Input.is_action_pressed("left"):
		direction = Vector2.LEFT
	if Input.is_action_pressed("jump"):
		direction = Vector2.UP
	if Input.is_action_pressed("down"):
		direction = Vector2.DOWN
		
	
		
		
func shoot():
	var bullet = bullet_path.instantiate() # instance of a bullet
	get_parent().add_child(bullet) # sets the bullet as the child of the shooter
	bullet.global_position = $Node2D/Marker2D.global_position
	Facing_Direction()
	if (direction==Vector2.RIGHT):
			bullet.velocity = Vector2(20,0)
	if (direction==Vector2.LEFT):
			bullet.velocity = Vector2(-20,0)
			if (animated_sprite.get_animation()=="run"):
				bullet.global_position.x -=25

	if (direction==Vector2.DOWN):
			bullet.velocity = Vector2(0,20)
			bullet.global_position.y +=20
			bullet.global_position.x -=5
	if (direction==Vector2.UP):
			bullet.velocity = Vector2(0,-20)
			bullet.global_position.y -=20
			bullet.global_position.x -=5

func _process(delta):
	$Node2D.look_at(get_global_mouse_position())
	if Input.is_action_just_pressed('shoot'):
		if can_shoot:
			shoot()
			can_shoot = false
	elif Input.is_action_just_released('shoot'):
		can_shoot = true
		
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
	elif direction < 0:
		animated_sprite.flip_h = true
	
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
	
	
