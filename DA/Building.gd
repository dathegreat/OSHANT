extends Node3D
@export_category("Building Parameters")
@export var steps: int = 200
var rotation_step_size: float = (2 * PI) / steps
@export var cylinder_radius: float = 50
@export var height: float = 50
@export var brick_height: float = 0.5
var brick_width: float = (2 * PI * cylinder_radius) / steps
@export var brick_depth: float = 1
var brick_size: Vector3 = Vector3(brick_width, brick_height, brick_depth)
var building_texture: Image = preload("res://DA/TestBuildingMap.png").get_image()
var stair_texture: Image = preload("res://DA/TestStairMap.png").get_image()
var brick_shader = preload("res://DA/Brick.gdshader")
var stair_shader = preload("res://DA/Stair.gdshader")

# Called when the node enters the scene tree for the first time.
func _ready():
	for step in range(0, steps):
		for y in range(0, height):
			#determine if the given brick should be created or left empty
			#if randi_range(0, 100) < 5:
				#continue
			#if step % 5 == 0:
				#continue
			#the center of the cylinder
			var center: Vector3 = Vector3(0, y * brick_height, 0)
			var theta: float = rotation_step_size * step
			#for every black pixel in the building map, draw a brick
			if building_texture.get_pixel(building_texture.get_width() - step - 1, building_texture.get_height() - y - 1).v < 0.01:
				var position: Vector3 = Vector3(
					cylinder_radius * cos(theta), 
					y * brick_height,  
					cylinder_radius * sin(theta)
				)
				var color = Color(lerpf(0, 1, float(step) / steps), y / height, 0)
				var brick: RigidBody3D = create_brick(position, center, brick_shader)
				add_child(brick)
			#for every black pixel in the stair map, draw a brick
			if stair_texture.get_pixel(stair_texture.get_width() - step - 1, stair_texture.get_height() - y - 1).v < 0.01:
				var stair_position: Vector3 = Vector3(
					(cylinder_radius + brick_depth) * cos(theta), 
					y * brick_height,  
					(cylinder_radius + brick_depth) * sin(theta)
				)
				var stair_color: Color = Color(0.9, 0.9, 0.9)
				var stair: RigidBody3D = create_brick(stair_position, center, stair_shader)
				add_child(stair)
	#draw staircase on outside of building
	#for step in range(0, steps):
		##staricase is generated in a spiral, with the height of each step
		##in the spiral determined by simplex noise
		#var noise_generator: FastNoiseLite = FastNoiseLite.new()
		#noise_generator.noise_type = FastNoiseLite.TYPE_SIMPLEX_SMOOTH
		#var noise_sample: float = noise_generator.get_noise_1d(step)
		#var y: float = height * absf(noise_sample)
		##the center of the cylinder
		#var center: Vector3 = Vector3(0, y * brick_height, 0)
		#var theta: float = rotation_step_size * step
		#var position: Vector3 = Vector3(
			#(cylinder_radius + brick_depth) * cos(theta), 
			#y * brick_height,  
			#(cylinder_radius + brick_depth) * sin(theta)
		#)
		#var color = Color(lerpf(0, 1, float(step) / steps), y / height, 0)
		#var brick: RigidBody3D = create_brick(position, center, color)
		#add_child(brick)

func create_brick(position: Vector3, center: Vector3, shader: Shader) -> RigidBody3D:
	var brick: MeshInstance3D = MeshInstance3D.new()
	brick.mesh = BoxMesh.new()
	brick.mesh.size = brick_size
	brick.mesh.material = ShaderMaterial.new()
	brick.mesh.material.shader = shader
	#brick.mesh.material.albedo_color = color
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
