extends Node3D

var stair_texture_data: PackedByteArray = preload("res://DA/TestStairMap.png").get_image().get_data()

# Called when the node enters the scene tree for the first time.
func _ready():
	#get_node("RotationAnchor/PlayerCharacter").position.z = get_node("Building").cylinder_radius + 1
	position_player_from_texture()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_released("click"):
		var explosive = load("res://DA/ExplosiveBall.tscn").instantiate()
		explosive.set_position(get_node("RotationAnchor/PlayerCharacter").global_position)
		add_child(explosive)
		explosive.explode()

func position_player_from_texture():
	var building_radius: float = get_node("Building").cylinder_radius
	var player_index: int = stair_texture_data.find(169) / 3
	var step: int = player_index % get_node("Building").steps
	var theta: float = step * get_node("Building").rotation_step_size
	var height: float = (get_node("Building").height - (player_index / get_node("Building").steps)) * get_node("Building").brick_height
	#because the image is using a different coordinate space than the world
	#we need to flip the theta and the y axis, but otherwise calculation of
	#player placement is the same as calculation of brick placement
	var player_position = Vector3(
		(building_radius + 1.1) * cos(-theta),
		height,
		(building_radius + 1.1) * sin(-theta)
	)
	get_node("RotationAnchor/PlayerCharacter").look_at_from_position(player_position, Vector3(0, height, 0))
