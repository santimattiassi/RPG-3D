extends CharacterBody3D

@export var speed := 5.0

func _physics_process(_deltaa):

	var input_dir := Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		input_dir.x += 1

	if Input.is_action_pressed("ui_left"):
		input_dir.x -= 1

	if Input.is_action_pressed("ui_down"):
		input_dir.y += 1

	if Input.is_action_pressed("ui_up"):
		input_dir.y -= 1

	var direction = Vector3(
		input_dir.x,
		0,
		input_dir.y
	).normalized()

	velocity.x = direction.x * speed
	velocity.z = direction.z * speed

	#if direction.length() > 0:
		#look_at(global_position + direction, Vector3.UP)

	move_and_slide()
