extends Node

@export var anim_cam : Camera3D
@export var game_cam : Camera3D
@export var player : CharacterBody3D
@onready var rich_text_label: RichTextLabel = $anim_cam/CanvasLayer/RichTextLabel

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var orbit_cam_position : Vector3
var orbit_cam_rotation

func _ready() -> void:
	EventBus.end_level.connect(exit_level)
	orbit_cam_position = anim_cam.global_position
	orbit_cam_rotation = anim_cam.global_rotation
	intro()
	animation_player.animation_finished.connect(finished_intro)

func intro():
	player.can_move = false
	anim_cam.make_current()
	await get_tree().create_timer(0.25).timeout
	animation_player.play("cam_animation")
	var tween = get_tree().create_tween()
	tween.tween_property(rich_text_label, "visible_ratio", 1, 4)


func finished_intro():
	var tween = get_tree().create_tween()
	tween.tween_property(anim_cam, "global_position", game_cam.global_position, 2)
	await tween.finished
	$anim_cam/CanvasLayer.hide()
	game_cam.make_current()
	player.can_move = true



func exit_level():
	print("exit level")
	anim_cam.global_position = game_cam.global_position
	anim_cam.look_at(self.global_position)
	anim_cam.make_current()
	var tween = get_tree().create_tween()

	tween.tween_property(anim_cam, "global_position", orbit_cam_position, 2)
	
	await tween.finished
	animation_player.play("cam_animation")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	finished_intro()
