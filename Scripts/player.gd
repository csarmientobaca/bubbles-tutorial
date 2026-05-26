extends CharacterBody2D

var timeLeft = 60

var SPEED = 300.0
var JUMP_VELOCITY = -400.0

var myGravity = 5

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += myGravity

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _process(delta: float) -> void:
	timeLeft -= delta

	print(timeLeft)

	if timeLeft <= 0:
		die()

func add_oxygen(amount) -> void:
	timeLeft += amount

func die() -> void:
	print("Player died")
	get_tree().reload_current_scene()
	
