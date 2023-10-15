extends Node3D

var sphere_radius: float = 3.0

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Area3D/CollisionShape3D").shape.radius = sphere_radius

func explode() -> int:
	var flash_sphere = get_node("FlashSphere")
	var charge_sprite = get_node("ChargeSprite")
	var explosion_sprite = get_node("ExplosionSprite")
	var boom_boom_counter: int = 0
	await get_tree().create_timer(0.05).timeout
	flash_sphere.visible = true
	charge_sprite.visible = false
	explosion_sprite.visible = true
	explosion_sprite.play()
	for body in get_node("Area3D").get_overlapping_bodies():
		if body is RigidBody3D:
			body.freeze = false
			boom_boom_counter += 1
	await get_tree().create_timer(0.5).timeout
	queue_free()
	return boom_boom_counter
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
