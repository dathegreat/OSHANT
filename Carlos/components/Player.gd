@icon("res://icon.svg")
extends Node

@export var char_body : CharacterBody3D
@export var interaction_script : InteractionRaycast

const MOVE_SPEED = 5
const SPRINT_SPEED = 7
const TURN_SPEED = 180
const GRAVITY = 98
const MAX_FALL_SPEED = 30

var y_velocity = 0
var grounded=false

var should_player_move = true

func _ready() -> void:
	EventBus.connect("player_movement_active", set_player_movement, 1)

func set_player_movement(should_move : bool):
	should_player_move = should_move

func _physics_process(delta: float) -> void:
	if should_player_move:
		var move_dir = 0
		var turn_dir = 0

		if Input.is_action_just_pressed("interact"):
			Interact()

		#print(Input.get_vector("left","right","forward","backward"))
		if Input.is_action_pressed("forward"):
			move_dir +=1
		if Input.is_action_pressed("backward"):
			move_dir -=1
		if Input.is_action_pressed("left"):
			turn_dir +=1
		if Input.is_action_pressed("right"):
			turn_dir -=1

		char_body.rotation_degrees.y += turn_dir * TURN_SPEED * delta

		var move_vec

		if Input.is_action_pressed("sprint"):
			move_vec = char_body.global_transform.basis.z * SPRINT_SPEED * move_dir
		else:
			move_vec = char_body.global_transform.basis.z * MOVE_SPEED * move_dir

		move_vec.y = y_velocity

		char_body.velocity = move_vec
		char_body.move_and_slide()

		var _was_grounded = grounded
		grounded = char_body.is_on_floor()
		y_velocity -= GRAVITY * delta
		if grounded:
			y_velocity = -0.1
		if y_velocity < -MAX_FALL_SPEED:
			y_velocity = -MAX_FALL_SPEED

func Interact():
	interaction_script.start_interaction()
