extends Node

@export var anim_cam : Camera3D
@export var game_cam : Camera3D
@export var player : CharacterBody3D
@export var player_rotater : Node3D
@onready var rich_text_label: RichTextLabel = $anim_cam/CanvasLayer/RichTextLabel
@onready var cam_rotator: Node3D = $Cam_rotator
@onready var end_game_canvas: CanvasLayer = $"Cam_rotator/anim_cam/End Game Canvas"
@onready var end_game_label: RichTextLabel = $"Cam_rotator/anim_cam/End Game Canvas/EndGameLabel"
@onready var button: Button = $"Cam_rotator/anim_cam/End Game Canvas/Button"

var ending_rotation = false

var orbit_cam_position : Vector3
var orbit_cam_rotation

func _ready() -> void:
	EventBus.end_level.connect(exit_level)
	EventBus.score.connect(show_score)
	orbit_cam_position = anim_cam.position
	orbit_cam_rotation = anim_cam.rotation
	intro()
func _process(delta: float) -> void:
	if ending_rotation:
		cam_rotator.rotate_object_local(Vector3(0, 1, 0), 0.015)

func intro():
	player.can_move = false
	anim_cam.make_current()
	await get_tree().create_timer(0.15).timeout
	self.rotation = player.rotation
	await get_tree().create_timer(0.25).timeout
	var rotation_tween = get_tree().create_tween()
	rotation_tween.tween_property(cam_rotator, "rotation", Vector3(0,0,0), 4)
	var tween = get_tree().create_tween()
	tween.tween_property(rich_text_label, "visible_ratio", 1, 4)
	await rotation_tween.finished
	finished_intro()


func finished_intro():
	var tween = get_tree().create_tween()
	tween.tween_property(anim_cam, "global_position", game_cam.global_position, 2)
	await tween.finished
	$Cam_rotator/anim_cam/CanvasLayer.hide()
	game_cam.make_current()
	player.can_move = true



func exit_level():
	anim_cam.position = orbit_cam_position
	self.rotation = Vector3(0, player.rotation.y + player_rotater.rotation.y, 0)
	print("exit level")
	
	var tween = get_tree().create_tween()
	tween.tween_property(game_cam, "global_position", anim_cam.global_position, 2)
	await tween.finished
	anim_cam.make_current()
	ending_rotation = true
	#var rotation_tween = get_tree().create_tween()
	#rotation_tween.tween_property(cam_rotator, "rotation", Vector3(0,5,0), 4)
	#await rotation_tween

func show_score(won:bool, bricks:int):
	end_game_canvas.show()
	if won:
		end_game_label.text = "[center]You won and destroyed " +str(bricks) + " bricks! press esc to exit[/center]"
	else:
		end_game_label.text = "[center]You lost and destroyed " + str(bricks) + " bricks! press esc to exit[/center]"
	var tween = get_tree().create_tween()
	tween.tween_property(end_game_label, "visible_ratio", 1, 3)
	await tween.finished
	button.show()
	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	finished_intro()


func _on_button_pressed() -> void:
	MusicManager.play_intro()
	SceneTransition.change_scene("res://Menus/main/MainMenu.tscn")
