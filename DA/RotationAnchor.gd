extends Node3D

func rotate_player(player_speed : float):
	var calculated_player_speed = player_speed
	self.rotate_object_local(Vector3(0, 1, 0), calculated_player_speed)
