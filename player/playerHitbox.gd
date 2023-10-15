extends Area3D

@export var health_component : HealthComponent

func damage_player():
	health_component.remove_health(10)
