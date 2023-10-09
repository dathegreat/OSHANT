extends RayCast3D
class_name InteractionRaycast

@export var interaction_floater : PackedScene
@export var player : Node3D

signal collided(collider)

var last_collider:Object




var can_check = false

var interaction_floater_instance : Node3D = null

func _ready() -> void:
	can_check = true
	collided.connect(show_interaction, 0)

var is_deleted = false

func _physics_process(_delta:float) -> void:
	if can_check:
		if not is_colliding():
			last_collider = null
			if !is_deleted && interaction_floater_instance != null:
				delete_interaction()
			return

		var found_collider : = get_collider()
		if found_collider != last_collider:
			last_collider = found_collider
			emit_signal("collided", found_collider)

	if interaction_floater_instance != null:
		interaction_floater_instance.look_at(get_viewport().get_camera_3d().global_position)

func show_interaction(collider : Node3D):
	is_deleted = false
	print("to show")
	print(collider)
	interaction_floater_instance = interaction_floater.instantiate()
	collider.add_sibling(interaction_floater_instance)

	#set interaction_floater_instance scale to 0
	interaction_floater_instance.scale = Vector3.ZERO

	#have tween set scale to 1
	var show_tween = get_tree().create_tween()
	show_tween.tween_property(interaction_floater_instance, "scale", Vector3(1.5,1.5,1.5) , 0.5)

func delete_interaction():
	is_deleted = true

	#have tween set scale to 0
	var show_tween = get_tree().create_tween()
	show_tween.tween_property(interaction_floater_instance, "scale", Vector3(0,0,0) , 0.5)

	await show_tween.finished
	if interaction_floater_instance != null:
		interaction_floater_instance.queue_free()


func start_interaction():
	print(get_collider())
	var interaction_object = get_collider()
	if interaction_object:
		if interaction_object.has_method("_on_interact"):
			interaction_object._on_interact()
	interaction_object = null

