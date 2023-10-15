extends CharacterBody3D

@export_group("nodes to hook up")
@export var interaction_area : Node
@export var rotation_node : Node3D

@export_group("player movement variables")
@export var speed := 0.01
@export var sprint_multiplier := 1.25

@export_group("player jump variables")
@export var jump_height : float = 5
@export var jump_peak_time : float = 0.2
@export var jump_descent_time : float = 0.3
@onready var coyote_timer: Timer = $Systems/CoyoteTimer

var jump_velocity : float = (2.0 * jump_height) / jump_peak_time
var jump_gravity : float = (-2.0 * jump_height) / (jump_peak_time * jump_peak_time)
var fall_gravity : float = (-2.0 * jump_height) / (jump_descent_time * jump_descent_time)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = get_gravity()
var was_on_floor = false

func _ready() -> void:
	rotation_node = get_parent()

var can_move = true
func _physics_process(delta: float) -> void:
	# Add the gravity.
	was_on_floor = is_on_floor()
	if not is_on_floor():
		velocity.y += get_gravity() * delta
	var player_speed = speed
	
	if can_move:
		if Input.is_action_pressed("sprint"):
			player_speed *= sprint_multiplier
		
		if Input.is_action_pressed("move_left"):
			rotation_node.rotate_player(-player_speed)
		if Input.is_action_pressed("move_right"):
			rotation_node.rotate_player(player_speed)
		
		
		
		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and (is_on_floor() || !coyote_timer.is_stopped()):
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
	if was_on_floor && !is_on_floor():
			coyote_timer.start()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		print("intercacting")
		for area in interaction_area.get_overlapping_areas():
			if area is InteractableGame:
				area.interact()
				return

func get_gravity() -> float:
	return jump_gravity if velocity.y > 0.0 else fall_gravity

func jump():
	velocity.y = jump_velocity

