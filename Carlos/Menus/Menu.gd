extends Control

@export var menu: Menu

@export var transition : bool = false

@export var init_pos : Vector2
@export var final_pos : Vector2
@export var time : float = 1.5

signal finished_start()
signal finished_end()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	menu.pointer.hide()
	for button in menu.get_children():
		button.button_up.connect(button_pressed.bind(button))
		pass
	open()

func open():
	menu.position = init_pos

	if transition:
		menu_transition_start()
	else:
		emit_signal("finished_start")

	await finished_start
	menu.initialize_menu()
	menu.pointer.show()

func close():
	menu.pointer.hide()
	if transition:
		menu_transition_end()
	else:
		emit_signal("finished_end")

func menu_transition_start():
	var slide_in_tween = self.create_tween()
	slide_in_tween.EASE_OUT
	slide_in_tween.tween_property(menu, "position", final_pos , time).set_trans(Tween.TRANS_ELASTIC)

	await slide_in_tween.finished
	emit_signal("finished_start")

func menu_transition_end():
	var slide_in_tween = self.create_tween()
	slide_in_tween.EASE_OUT
	slide_in_tween.tween_property(menu, "position", init_pos , time).set_trans(Tween.TRANS_ELASTIC)

	await slide_in_tween.finished
	emit_signal("finished_end")

func button_pressed(item):
	print(item)

