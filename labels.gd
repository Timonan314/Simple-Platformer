extends Node
@onready var label_7: Label = $Label7
@onready var label_3: Label = $Label3
@onready var label_2: Label = $Label2
@onready var label: Label = $Label
@onready var label_5: Label = $Label5
@onready var label_6: Label = $Label6
@onready var label_8: Label = $Label8


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_box_body_entered(body: Node2D) -> void:
	Global.boxed = true
	label_7.text = "Now just bring it back home! :)
	Jump and dash <--"
	
	label_3.text = "Nice!"
	
	label_2.text = "You're almost there :)"
	
	label.text = "You did it!
	thats the end of the game ig"
	
	label_5.text = "haha you fell lol
	you need to replay it now :)"
	
	label_6.text = "You could've just skipped the checkpoint
	and died, to skip this whole section
	But you didn't :D"
	
	label_8.text = "Spikes still hurt
	:("
