extends Node3D

var facing_left : bool
@export var enemy_mesh : Node3D

func set_enemy_pos(position_to_set : Vector3):
	enemy_mesh.position = position_to_set
