extends Node3D

var building_node = preload("res://DA/Building.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	var building = building_node.instantiate()
	add_child(building)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("move_right"):
		get_node("Camera3D").position.x += 0.1
	if Input.is_action_pressed("move_left"):
		get_node("Camera3D").position.x += -0.1
	if Input.is_action_pressed("move_up"):
		get_node("Camera3D").position.z += 0.1
	if Input.is_action_pressed("move_down"):
		get_node("Camera3D").position.z += -0.1
