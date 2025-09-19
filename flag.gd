extends AnimatedSprite2D

@export var  ID = 1

var IDa = 1
var spawn = {0:Vector2(0,0), 1:Vector2(168.0,16.0),2:Vector2(424.0,296.0),3:Vector2(752.0,232.0), 4:Vector2(912.0,232.0), 5:Vector2(1136.0,72.0), 6:Vector2(1392.0,32.0), 7:Vector2(1176.0, -32.0)}
var state = "down"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	print(ID, "  ", state)
	if not(spawn[ID] == Global.checkpoint):
		state = "down"
	
	if state == "up":
		if animation == "down anim" or animation == "down":
			play("up anim")
	if state == "down":
		if animation == "up anim":
			play("down anim")



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		if state == "down":
			state = "up"
			Global.checkpoint = spawn[ID]
