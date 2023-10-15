extends State

@export_group("Idle Params")
@export var min_idle_time : float = 1.0
@export var max_idle_time : float = 5.0

var interrupted := false
func wait_in_idle():
	interrupted = false
	var time_to_wait = randf_range(min_idle_time, max_idle_time)
	
	await get_tree().create_timer(time_to_wait).timeout
	finished_wait()

func finished_wait():
	if !interrupted:
		state_machine.transition_to("WalkAround")

func enter(message : = {}) -> void:
	wait_in_idle()

func exit():
	interrupted = true
