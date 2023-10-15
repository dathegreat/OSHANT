extends AnimatedSprite3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$"../../EnemyStateMachine".transitioned_to_state.connect(_on_state_change)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_state_change(state):
	match state:
		"Idle":
			play("idle")
		"Chase":
			play("moving")
		"WalkAround":
			play("moving")
