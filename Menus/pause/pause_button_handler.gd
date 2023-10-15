extends Node
@export var pause_menu_handler : MenuHandler

func _ready() -> void:
	pause_menu_handler.button_in_menu_pressed.connect(button_pressed)

func button_pressed(item):
	match item:
		0:
			pause_menu_handler.close()
		1:
			print("1")

