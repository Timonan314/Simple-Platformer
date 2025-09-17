extends AnimatedSprite2D

@export var  ID = 0

var IDa = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		if animation == "down":
			play("up anim")
			print(ID)

#	var(ID + "a") += 1
