extends Node3D
@export_category("Building Parameters")
@export var steps: int = 100
var rotation_step_size: float = (2 * PI) / steps
@export var cylinder_radius: float = 10
@export var height: float = 20
@export var brick_height: float = 0.5
var brick_width: float = (2 * PI * cylinder_radius) / steps
@export var brick_depth: float = 1
var brick_size: Vector3 = Vector3(brick_width, brick_height, brick_depth)

# Called when the node enters the scene tree for the first time.
func _ready():
	for step in range(0, steps):
		for y in range(0, height):
			#determine if the given brick should be created or left empty
			if randi_range(0, 100) < 5:
				continue
			#the center of the cylinder
			var center: Vector3 = Vector3(0, y * brick_height, 0)
			var theta: float = rotation_step_size * step
			var brick: MeshInstance3D = MeshInstance3D.new()
			brick.mesh = BoxMesh.new()
			brick.mesh.size = brick_size
			brick.mesh.material = StandardMaterial3D.new()
			brick.mesh.material.albedo_color = Color(lerpf(0, 1, float(step) / steps), y / height, 0)
			var collision_shape = CollisionShape3D.new()
			collision_shape.shape = BoxShape3D.new()
			collision_shape.shape.size = brick_size
			var rigid_body = RigidBody3D.new()
			#move each brick to its given position on the cylinder and then
			#point its face toward the center of the cylinder
			rigid_body.look_at_from_position(
				Vector3(
					cylinder_radius * cos(theta), 
					y * brick_height,  
					cylinder_radius * sin(theta)
				), 
				center)
			rigid_body.freeze = true
			rigid_body.add_child(collision_shape)
			rigid_body.add_child(brick)
			add_child(rigid_body)
	

func redraw():
	self._ready()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
