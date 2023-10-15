extends Area3D

func _process(delta: float) -> void:
	if has_overlapping_areas():
		print("should damage")
		var overlapping = get_overlapping_areas()
		for body in overlapping:
			print(body)
