extends CharacterBody3D

@export var interaction_area : Node

const SPEED = 5.0
@export var speed := 200.0
@export var jump_force := 800.0
@export var has_acceleration := false
@export var acceleration := 1_000
@export var deacceleration := 1_000

@export var jump_height : float = 5
@export var jump_peak_time : float = 0.2
@export var jump_descent_time : float = 0.3

var jump_velocity : float = (2.0 * jump_height) / jump_peak_time
var jump_gravity : float = (-2.0 * jump_height) / (jump_peak_time * jump_peak_time)
var fall_gravity : float = (-2.0 * jump_height) / (jump_descent_time * jump_descent_time)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = get_gravity()


func _physics_process(delta: float) -> void:
	print("jump gravity: ", jump_gravity, jump_height)
	print("jump velocity: ", jump_velocity)
	print("fall gravity: ", fall_gravity)
	# Add the gravity.
	if not is_on_floor():
		velocity.y += get_gravity() * delta

	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jump()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	#var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		print("intercactint")
		for area in interaction_area.get_overlapping_areas():
			if area is Interactable:
				area.interact()
				return

func get_gravity() -> float:
	return jump_gravity if velocity.y > 0.0 else fall_gravity

func jump():
	print(jump_velocity)
	velocity.y = jump_velocity

