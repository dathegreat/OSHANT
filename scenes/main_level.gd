extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	var player_position = get_node("Building").player_starting_position
	var player_height = get_node("Building").player_starting_height
	get_node("RotationAnchor/PlayerCharacter").look_at_from_position(player_position, Vector3(0, player_height, 0))
	print(player_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
