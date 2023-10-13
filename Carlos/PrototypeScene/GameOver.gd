extends Node

@export var game_over_ui : PackedScene

@onready var player_health: HealthComponent = $"../Health"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_health.health_is_zero.connect(player_death)

func player_death() -> void:
	print("player has died")
	var menu_instance = game_over_ui.instantiate()
	get_tree().root.add_child(menu_instance)
	get_tree().paused = true


