extends CharacterBody2D

const JUMP_VELOCITY = -400.0
const MAX_VELOCITY = 200
const ACCELERATION = 1000

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = $AnimationPlayer

func _ready():
	anim.play("fall")
	

func _physics_process(delta):
	
	if not is_on_floor():
		if velocity.y < gravity*2:
			velocity.y += gravity * delta
		if velocity.y >= 0:
			anim.play("fall")		
	else:
		if Input.is_action_pressed("jump"):
			velocity.y = JUMP_VELOCITY
			anim.play("jump")
			
	if Input.is_action_pressed("move_left"):
		$Sprite2D.flip_h = true
		if velocity.x > -MAX_VELOCITY:
			velocity.x -= ACCELERATION * delta
		if is_on_floor():
			anim.play("run")
	elif Input.is_action_pressed("move_right"):
		$Sprite2D.flip_h = false
		if velocity.x < MAX_VELOCITY:
			velocity.x += ACCELERATION * delta
		if is_on_floor():
			anim.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, ACCELERATION * delta)
		
	if velocity.is_zero_approx():
		anim.play("idle")
		
	move_and_slide()
