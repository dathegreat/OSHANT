extends Node3D

var building_node = preload("res://DA/Building.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	var building = building_node.instantiate()
	add_child(building)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_D):
		get_node("Camera3D").position += Vector3.RIGHT * 0.1
	if Input.is_key_pressed(KEY_A):
		get_node("Camera3D").position += Vector3.RIGHT * -0.1
	if Input.is_key_pressed(KEY_W):
		get_node("Camera3D").position += Vector3.FORWARD * 0.1
	if Input.is_key_pressed(KEY_S):
		get_node("Camera3D").position += Vector3.FORWARD * -0.1
	if Input.is_key_pressed(KEY_Q):
		get_node("Camera3D").position.y += 0.1
	if Input.is_key_pressed(KEY_E):
		get_node("Camera3D").position.y += -0.1
	if Input.is_key_pressed(KEY_UP):
		get_node("Camera3D").rotate_object_local(Vector3(1, 0, 0), 0.01)
	if Input.is_key_pressed(KEY_DOWN):
		get_node("Camera3D").rotate_object_local(Vector3(1, 0, 0), -0.01)
	if Input.is_key_pressed(KEY_LEFT):
		get_node("Camera3D").rotate_object_local(Vector3(0, 1, 0), 0.01)
	if Input.is_key_pressed(KEY_RIGHT):
		get_node("Camera3D").rotate_object_local(Vector3(0, 1, 0), -0.01)
