extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("move_left"):
		self.rotate_object_local(Vector3(0, 1, 0), -0.01)
	if Input.is_action_pressed("move_right"):
		self.rotate_object_local(Vector3(0, 1, 0), 0.01)
	
	get_node("Camera3D").position.y = get_node("PlayerCharacter").position.y + 1.0
