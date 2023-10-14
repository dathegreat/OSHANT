extends State

@export_group("Node to move")
@export var movement_node : Node3D

@export_group("walk params")
@export var min_move_time : float = 0.5
@export var max_move_time : float = 3.0

var should_move : = false
var move_left : = false

var interrupted := false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if should_move:
		if move_left:
			movement_node.position.x += 0.05
		else:
			movement_node.position.x -= 0.05

func move():
	interrupted = false
	var amount_to_move = randf_range(min_move_time, max_move_time)
	move_left = randi_range(0,1)
	should_move = true
	
	await get_tree().create_timer(amount_to_move).timeout
	finished_walk()

func finished_walk():
	if !interrupted:
		should_move = false
		state_machine.transition_to("Idle", {"finished_walking" = true})

func enter(msg : = {} ):
	move()

func exit():
	interrupted = true
	should_move = false

