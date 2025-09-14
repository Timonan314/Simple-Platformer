extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var facing = "right"
@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0

var jump_mem = 0

func _physics_process(delta: float) -> void:
	if Global.dead == true:
		position = Vector2(0,0)
		Global.dead = false
		
	##jump memory
	print(jump_mem)
	if not is_on_floor() and Input.is_action_just_pressed("jump"):
		jump_mem = 6

	if jump_mem > 0 and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_mem = 0
	
	if jump_mem > 0:
		jump_mem -= 1



	# Add the gravity.
	if not is_on_floor():
		velocity.y += 600 * delta
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	
	
	
	if velocity.x > 50:
		facing = "right"
	if velocity.x < -50:
		facing = "left"
	if velocity.x > 50 and is_on_floor():
		facing = "right"
		animated_sprite_2d.play("right walk")
	if velocity.x < -50 and is_on_floor():
		facing = "left"
		animated_sprite_2d.play("left walk")
	if not is_on_floor():
		if facing == "right":
			animated_sprite_2d.play("right jump")
		if facing == "left":
			animated_sprite_2d.play("left jump")
	if is_on_floor() and velocity.x == 0:
		if facing == "right":
			animated_sprite_2d.play("right idle")
		if facing == "left":
			animated_sprite_2d.play("left idle")


func _on_deathbox_body_entered(body: Node2D) -> void:
	Global.dead = true
