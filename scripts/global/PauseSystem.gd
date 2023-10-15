extends Node

@export var pause_menu_ui : PackedScene

var is_paused = false

var menu_instance = null

var can_press = true

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		print("pause")
		pause()

func pause():
	if is_paused:
		if menu_instance:
			menu_instance.close()

		await menu_instance.finished_end
		menu_instance.queue_free()
		get_tree().paused = false
		is_paused = false
	else:
		print("instantiating")
		menu_instance = pause_menu_ui.instantiate()
		menu_instance.finished_end.connect(remove_instance)
		get_tree().root.add_child(menu_instance)
		#menu_instance.
		get_tree().paused = true
		is_paused = true

func remove_instance():
	if menu_instance:
		menu_instance.queue_free()
		get_tree().paused = false
		is_paused = false
