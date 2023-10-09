extends Node3D

var steps: int = 200
var rotation_step_size: float = (2 * PI) / steps
var cylinder_radius: float = 2
var height: float = 20
var brick_height: float = 0.5
var brick_width: float = (2 * PI * cylinder_radius) / steps
var brick_depth: float = 0.05
var brick_size: Vector3 = Vector3(brick_width, brick_height, brick_depth)

# Called when the node enters the scene tree for the first time.
func _ready():
	for step in range(0, steps):
		for y in range(1, height):
			#the center of the cylinder
			var center: Vector3 = Vector3(0, y * brick_height, 0)
			var theta: float = rotation_step_size * step
			var brick: MeshInstance3D = MeshInstance3D.new()
			brick.mesh = BoxMesh.new()
			brick.mesh.size = brick_size
			brick.mesh.material = StandardMaterial3D.new()
			brick.mesh.material.albedo_color = Color(lerpf(0, 1, float(step) / steps), y / height, 0)
			#move each brick to its given position on the cylinder and then
			#point its face toward the center of the cylinder
			brick.look_at_from_position(
				Vector3(
					cylinder_radius * cos(theta), 
					y * brick_height,  
					cylinder_radius * sin(theta)
				), 
				center)
			#add brick to scene
			add_child(brick)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
