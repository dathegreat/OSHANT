extends CanvasLayer

signal finished_transition

func change_scene(scene_to_change: String):
	$AnimationPlayer.play("in")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(scene_to_change)
	$AnimationPlayer.play("out")
	await $AnimationPlayer.animation_finished
	emit_signal("finished_transition")
