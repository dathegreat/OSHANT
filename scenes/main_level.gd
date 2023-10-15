extends Node3D

@export var brick_count_to_win: int = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	var player_position = get_node("Building").player_starting_position
	var player_height = get_node("Building").player_starting_height
	get_node("RotationAnchor/PlayerCharacter").look_at_from_position(player_position, Vector3(0, player_height, 0))
	print(player_position)
	EventBus.end_level.connect(_on_level_end)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("right_click"):
		var explosive = load("res://DA/ExplosiveBall.tscn").instantiate()
		explosive.set_position(get_node("RotationAnchor/PlayerCharacter").global_position)
		get_node("ChargeContainer").add_child(explosive)
	if Input.is_key_pressed(KEY_9):
		EventBus.emit_signal("end_level")

func _on_level_end():
	var brick_demolition_count: int = 0
	for explosive in get_node("ChargeContainer").get_children():
		var bricks_destroyed = await explosive.explode()
		brick_demolition_count += bricks_destroyed
	if brick_demolition_count >= brick_count_to_win:
		print("sweet, you won")
		EventBus.emit_signal("score", false, brick_demolition_count)
	else: 
		print("you lost and destroyed", brick_demolition_count, " bricks")
		EventBus.emit_signal("score", true, brick_demolition_count)
	
