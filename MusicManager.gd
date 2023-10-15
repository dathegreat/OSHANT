extends Node
@onready var streamplay: AudioStreamPlayer = $AudioStreamPlayer

@export var music_to_play : Array[AudioStream]


func _ready() -> void:
	streamplay.play()

func play_intro():
	streamplay.stream = music_to_play[0]
	streamplay.play()

func play_main():
	streamplay.stream = music_to_play[1]
	streamplay.play()

func fade_effect():
	print("tweenign")
	var tween = get_tree().create_tween()
	tween.set_pause_mode(2) 
	tween.tween_property(streamplay, "pitch_scale", 0.5, 0.3)
	tween.tween_property(streamplay, "volume_db", -5, 1)
	

func normal_effect():
	var tween = get_tree().create_tween()
	tween.set_pause_mode(2) 
	tween.tween_property(streamplay, "pitch_scale", 1,  0.3)
	tween.tween_property(streamplay, "volume_db", 0, 1)
	
