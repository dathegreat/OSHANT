extends Node3D

var sphere_radius: float = 3.0

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Area3D/CollisionShape3D").shape.radius = sphere_radius
	get_node("Area3D/CSGSphere3D").radius = sphere_radius

func explode():
	await get_tree().create_timer(0.05).timeout
	for body in get_node("Area3D").get_overlapping_bodies():
		if body is RigidBody3D:
			body.freeze = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
