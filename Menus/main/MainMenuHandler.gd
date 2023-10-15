extends Node
@export var menu_handler : MenuHandler
@export var level_to_load_path : String

func _ready() -> void:
	menu_handler.button_in_menu_pressed.connect(button_interact)

func button_interact(item : int):
	match item:
		0:
			print("you pressed 0!")
			SceneTransition.change_scene(level_to_load_path)
		1:
			print("you pressed 1!")
		2:
			print("you pressed 2")
