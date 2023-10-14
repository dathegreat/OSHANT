extends CharacterBody3D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= 9.8 * delta
	move_and_slide()