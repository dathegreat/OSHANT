extends Node
class_name HealthComponent

@export var current_health : int = 100
@export var max_health : int = 100
@export var has_invincibility_cooldown :=false

signal health_is_zero

var can_be_damaged = true

func add_health(health_to_add : int):
	current_health += health_to_add
	if current_health > max_health:
		current_health = max_health

func remove_health(health_to_remove : int):
	if(can_be_damaged):
		current_health -= health_to_remove
		print("removing health ", health_to_remove)
		if(current_health < 0):
			health_reached_zero()
		if has_invincibility_cooldown:
			can_be_damaged = false
			await get_tree().create_timer(1).timeout
			can_be_damaged = true
	print("can't be damaged")

func set_max_health(new_max_health : int):
	max_health = new_max_health

func health_reached_zero():
	emit_signal("health_is_zero")
	print("health has reached zero")
