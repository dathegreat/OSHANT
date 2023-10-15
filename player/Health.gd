extends Node
class_name HealthComponent

@export var current_health : int = 100
@export var max_health : int = 100

signal health_is_zero

func add_health(health_to_add : int):
	current_health += health_to_add
	if current_health > max_health:
		current_health = max_health

func remove_health(health_to_remove : int):
	current_health -= health_to_remove
	print("removing health ", health_to_remove)
	if(current_health < 0):
		health_reached_zero()

func set_max_health(new_max_health : int):
	max_health = new_max_health

func health_reached_zero():
	emit_signal("health_is_zero")
	print("health has reached zero")
