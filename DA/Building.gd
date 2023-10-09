extends Node3D

var center: Vector3 = Vector3(0, 0, 0)
var steps: int = 20
var rotation_step_size: float = (2 * PI) / steps
var cylinder_radius: float = 2
var height: float = 10
var brick_height = 1
var brick_width = (2 * PI * cylinder_radius) / steps
var brick_depth = 0.05
var brick_size: Vector3 = Vector3(brick_height, brick_width, brick_depth)

# Called when the node enters the scene tree for the first time.
func _ready():
	for step in range(0, steps):
			for y in range(0, height):
				var brick: MeshInstance3D = MeshInstance3D.new()
				brick.mesh = BoxMesh.new()
				brick.mesh.size = brick_size
				var theta: float = rotation_step_size * step
				brick.set_position( 
					Vector3(
						cylinder_radius * cos(theta), 
						y * brick_height,  
						cylinder_radius * sin(theta)
					)
				)
				var rotation: Vector3 = brick.position.direction_to(center)
				#TODO for tomorrow: fix rotation logic
				brick.rotate_object_local(Vector3(0, 1, 0), rotation.y)
				add_child(brick)
	print(rotation_step_size, " ", steps)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
