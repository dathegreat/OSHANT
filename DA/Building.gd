extends Node3D

@export_group("Levels")
@export var level_group : LevelGroup
var building_texture: Image = preload("res://DA/TestBuildingMap.png").get_image()
var stair_texture: Image = preload("res://DA/TestStairMap.png").get_image()
var enemy_placement_texture : Image = preload("res://DA/TestStairMap.png").get_image()
var player_placement_texture : Image = preload("res://DA/TestStairMap.png").get_image()
var level_exit_texture : Image = preload("res://DA/TestStairMap.png").get_image()

var current_level := 0

@export_category("object to Instantiate")
@export var enemy_scene : PackedScene
@export var level_exit_scene : PackedScene


@export_category("Building Parameters")
@export var steps: int = 200
@export var height: float = 50
@export var cylinder_radius: float = 50
@export var brick_height: float = 0.5
@export var brick_depth: float = 1

var rotation_step_size: float = (2 * PI) / steps
var brick_width: float = (2 * PI * cylinder_radius) / steps
var brick_size: Vector3 = Vector3(brick_width, brick_height, brick_depth)

var brick_shader = preload("res://DA/Brick.gdshader")
var stair_shader = preload("res://DA/Stair.gdshader")

var player_starting_position: Vector3
var player_starting_height: float

var enemy_starting_positions = []
var enemy_starting_heights = []
# Called when the node enters the scene tree for the first time.
func _ready():
	generate_building(current_level)
	pass

func generate_building(level_to_build : int):
	var build_level = level_group.levels[level_to_build]
	print("now building ", build_level.level_name)
	building_texture = build_level.background_layer.get_image()
	stair_texture = build_level.stair_layer.get_image()
	level_exit_texture = build_level.exit_level_layer.get_image()
	enemy_placement_texture = build_level.enemy_layer.get_image()
	player_placement_texture = build_level.player_layer.get_image()
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
				var converted_position := Vector3(
					cylinder_radius * cos(theta), 
					y * brick_height,  
					cylinder_radius * sin(theta)
				)
				var brick: RigidBody3D = create_brick(converted_position, center, brick_shader)
				add_child(brick)
			#for every black pixel in the stair map, draw a brick
			if stair_texture.get_pixel(stair_texture.get_width() - step - 1, stair_texture.get_height() - y - 1).v < 0.01:
				var stair_position := Vector3(
					(cylinder_radius + brick_depth) * cos(theta), 
					y * brick_height,  
					(cylinder_radius + brick_depth) * sin(theta)
				)
				var stair: RigidBody3D = create_brick(stair_position, center, stair_shader)
				add_child(stair)
			if player_placement_texture.get_pixel(player_placement_texture.get_width() - step - 1, player_placement_texture.get_height() - y - 1).v < 0.01:
				player_starting_position = Vector3(
					(cylinder_radius + 0.5 + brick_depth) * cos(theta), 
					y * brick_height,  
					(cylinder_radius + 0.5 + brick_depth) * sin(theta)
				)
				player_starting_height = y * brick_height
			if enemy_placement_texture.get_pixel(enemy_placement_texture.get_width() - step - 1, enemy_placement_texture.get_height() - y - 1).v < 0.01:
				enemy_starting_positions.append( Vector3(
					(cylinder_radius + 0.5 + brick_depth) * cos(theta), 
					y * brick_height,  
					(cylinder_radius + 0.5 + brick_depth) * sin(theta)
				))
				enemy_starting_heights.append(y * brick_height)
			if level_exit_texture.get_pixel(level_exit_texture.get_width() - step - 1, level_exit_texture.get_height() - y - 1).v < 0.01:
				var level_exit_pos:= Vector3(
					(cylinder_radius + brick_depth) * cos(theta), 
					y * brick_height,  
					(cylinder_radius + brick_depth) * sin(theta)
				)
				create_level_exit(level_exit_pos)
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


func create_brick(position_to_create: Vector3, center: Vector3, shader: Shader) -> RigidBody3D:
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
	rigid_body.look_at_from_position(position_to_create, center)
	rigid_body.freeze = true
	rigid_body.add_child(collision_shape)
	rigid_body.add_child(brick)
	
	return rigid_body

func create_enemy():
	pass

func create_level_exit(instantiate_position : Vector3):
	await get_tree().create_timer(1).timeout
	print("instantiating exit at ", instantiate_position)
	var level_exit = level_exit_scene.instantiate()
	self.add_sibling(level_exit)
	level_exit.position = instantiate_position
	print(level_exit, level_exit.position)
