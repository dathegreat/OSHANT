extends Area3D

func _process(delta: float) -> void:
	if has_overlapping_areas():
		var areas = get_overlapping_areas()
		for area in areas:
			if area.has_method("damage_player"):
				area.damage_player()
