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
			var position: Vector3 = Vector3(
				cylinder_radius * cos(theta), 
				y * brick_height,  
				cylinder_radius * sin(theta)
			)
			var color = Color(lerpf(0, 1, float(step) / steps), y / height, 0)
			var brick: RigidBody3D = create_brick(position, center, color)
			add_child(brick)
	#draw staircase on outside of building
	for step in range(0, steps):
		#staricase is generated in a spiral, with the height of each step
		#in the spiral determined by simplex noise
		var noise_generator: FastNoiseLite = FastNoiseLite.new()
		noise_generator.noise_type = FastNoiseLite.TYPE_SIMPLEX_SMOOTH
		var noise_sample: float = noise_generator.get_noise_1d(step)
		var y: float = height * absf(noise_sample)
		#the center of the cylinder
		var center: Vector3 = Vector3(0, y * brick_height, 0)
		var theta: float = rotation_step_size * step
		var position: Vector3 = Vector3(
			(cylinder_radius + brick_depth) * cos(theta), 
			y * brick_height,  
			(cylinder_radius + brick_depth) * sin(theta)
		)
		var color = Color(lerpf(0, 1, float(step) / steps), y / height, 0)
		var brick: RigidBody3D = create_brick(position, center, color)
		add_child(brick)

func create_brick(position: Vector3, center: Vector3, color: Color) -> RigidBody3D:
	var brick: MeshInstance3D = MeshInstance3D.new()
	brick.mesh = BoxMesh.new()
	brick.mesh.size = brick_size
	brick.mesh.material = StandardMaterial3D.new()
	brick.mesh.material.albedo_color = color
	var collision_shape = CollisionShape3D.new()
	collision_shape.shape = BoxShape3D.new()
	collision_shape.shape.size = brick_size
	var rigid_body = RigidBody3D.new()
	#move each brick to its given position on the cylinder and then
	#point its face toward the center of the cylinder
	rigid_body.look_at_from_position(position, center)
	rigid_body.freeze = true
	rigid_body.add_child(collision_shape)
	rigid_body.add_child(brick)
	
	return rigid_body
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
