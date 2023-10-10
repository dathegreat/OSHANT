extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("click"):
		var explosive = load("res://DA/ExplosiveBall.tscn").instantiate()
		explosive.set_position(Vector3(10,2,0))
		add_child(explosive)
		explosive.explode()
