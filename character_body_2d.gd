extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var facing = 1
@export var SPEED = 100.0
@export var jump_vel = -200.0
@export var dash_vel = 200
@onready var dash_timer: Timer = $"dash timer"
var gravity = 600
var dash_add = 0
var move_add = 0
var jump_mem = 0
var dashed = 0
var coyote = 0
var jumped = false
var coyoted = false
func _physics_process(delta: float) -> void:
	print(coyote)
	if Global.dead == true:
		position = Global.checkpoint
		Global.dead = false
		
	##jump memory
	if not is_on_floor() and Input.is_action_just_pressed("jump"):
		jump_mem = 6

	if jump_mem > 0 and is_on_floor():
		velocity.y = jump_vel
		jump_mem = 0
	
	if jump_mem > 0:
		jump_mem -= 1

	##coyote time
	if coyote > 0:
		coyote -= 1
	if not is_on_floor() and jumped == false and coyoted == false:
		coyote = 6
		coyoted = true
	if Input.is_action_just_pressed("jump") and coyote > 0:
		coyote = 0
		jumped = true
		velocity.y = jump_vel

	if Input.is_action_just_pressed("dash") and dashed == 0:
		dashed = 1
		velocity.y = 0
		dash_add = facing*dash_vel
		dash_timer.start()
		gravity = 0
	if is_on_floor():
		coyote = 0
		jumped = false
		dashed = 0
		coyoted = false
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if gravity == 0:
			dashed = 1
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jumped = true
		velocity.y = jump_vel
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	if direction:
		if move_add == 0:
			move_add = direction * SPEED
	else:
		move_add = move_toward(move_add, 0, SPEED)
		
	velocity.x = dash_add + move_add
		
	move_and_slide()
	
	
	
	if velocity.x > 50:
		facing = 1
	if velocity.x < -50:
		facing = -1
	if velocity.x > 50 and is_on_floor():
		facing = 1
		animated_sprite_2d.play("right walk")
	if velocity.x < -50 and is_on_floor():
		facing = -1
		animated_sprite_2d.play("left walk")
	if not is_on_floor():
		if facing == 1:
			animated_sprite_2d.play("right jump")
		if facing == -1:
			animated_sprite_2d.play("left jump")
	if is_on_floor() and velocity.x == 0:
		if facing == 1:
			animated_sprite_2d.play("right idle")
		if facing == -1:
			animated_sprite_2d.play("left idle")


func _on_deathbox_body_entered(_body: Node2D) -> void:
	Global.dead = true


func _on_dash_timer_timeout() -> void:
	dash_add = 0
	gravity = 600
