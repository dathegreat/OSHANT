extends Node
@export var pause_menu_handler : MenuHandler

func _ready() -> void:
	pause_menu_handler.button_in_menu_pressed.connect(button_pressed)

func button_pressed(item):
	match item:
		0:
			pause_menu_handler.close()
			MusicManager.normal_effect()
		1:
			get_tree().paused = false
			MusicManager.play_intro()
			SceneTransition.change_scene("res://Menus/main/MainMenu.tscn")
		2:
			get_tree().quit()

