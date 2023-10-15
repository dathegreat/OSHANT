extends Node
class_name MenuHandler

@export var menu: Menu

@export var static_buttons : bool = true

@export var transition : bool = false
@export var has_title_transition : bool = false

@export var init_pos : Vector2
@export var final_pos : Vector2
@export var time : float = 0.5
@export var title_time : float = 0.5

@export var game_title : Label

signal finished_start()
signal finished_end()
signal button_in_menu_pressed(pressed_button : int) 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	menu.pointer.hide()
	if static_buttons:
		var counter = 0
		for button in menu.get_children():
			button.button_up.connect(button_pressed.bind(counter))
			counter += 1
			pass
		open()

func open():
	if transition || has_title_transition:
		menu_transition_start()
		await finished_start
		menu.initialize_menu()
		menu.pointer.show()
	else:
		await get_tree().create_timer(0.1).timeout
		menu.initialize_menu()
		menu.pointer.show()

func close():
	menu.pointer.hide()
	if transition:
		menu_transition_end()
	else:
		emit_signal("finished_end")


func menu_transition_start():
	if(has_title_transition):
		title_transition()
	if transition:
		menu.position = init_pos
		var slide_in_tween = self.create_tween()
		slide_in_tween.tween_property(menu, "position", final_pos , time).set_trans(Tween.TRANS_ELASTIC)
	await get_tree().create_timer(time).timeout
	emit_signal("finished_start")
	menu.initialize_menu()
	menu.pointer.show()

func menu_transition_end():
	var slide_in_tween = self.create_tween()
	slide_in_tween.tween_property(menu, "position", init_pos , time).set_trans(Tween.TRANS_ELASTIC)

	await slide_in_tween.finished
	emit_signal("finished_end")
	menu.initialize_menu()

func title_transition():
	game_title.label_settings.set("font_size", 1)
	var title_tween = self.create_tween()
	title_tween.tween_property(game_title.label_settings, "font_size", 150, title_time)

func button_pressed(item):
	emit_signal("button_in_menu_pressed", item)
