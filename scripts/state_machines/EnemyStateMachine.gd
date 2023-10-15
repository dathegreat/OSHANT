@icon("res://Art/Icons/node_icons/network-right (1).svg")
class_name StateMachine
extends Node

signal transitioned_to_state(state_name)

@export var initial_state : State

@onready var state: State = initial_state

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await owner.ready
	# The state machine assigns itself to the State objects' state_machine property.
	for child in get_children():
		child.state_machine = self
	state.enter()

# Called every frame. 'delta' is the elapsed time since the previous frame.

# This function calls the current state's exit() function, then changes the active state,
# and calls its enter function.
# It optionally takes a `msg` dictionary to pass to the next state's enter() function.
func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	# Safety check, you could use an assert() here to report an error if the state name is incorrect.
	# We don't use an assert here to help with code reuse. If you reuse a state in different state machines
	# but you don't want them all, they won't be able to transition to states that aren't in the scene tree.
	if not has_node(target_state_name):
		return

	state.exit()
	state = get_node(target_state_name)
	state.enter(msg)
	emit_signal("transitioned_to_state", state.name)
