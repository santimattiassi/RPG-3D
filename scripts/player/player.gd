extends CharacterBody3D

@export var speed := 4.0
@export var run_speed := 7.0

@onready var animated_knight = $AnimatedKnight
@onready var animation_player = $AnimatedKnight/AnimationPlayer

func _physics_process(_deltaa):
	var current_speed = speed

	if Input.is_key_pressed(KEY_SHIFT):
		current_speed = run_speed
		
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

	velocity.x = direction.x * current_speed
	velocity.z = direction.z * current_speed
	
	if direction.length() > 0:

		if current_speed == run_speed:
			if animation_player.current_animation != "/Player/Running_B":
				animation_player.play("Player/Running_B")
		else:

			if animation_player.current_animation != "/Player/Walking_A":
				animation_player.play("Player/Walking_A")
		
		animated_knight.look_at(
			animated_knight.global_position - direction,
			Vector3.UP
		)
	else:
		if animation_player.current_animation != "/Player/Idle_A":
			animation_player.play("Player/Idle_A")
	
		

	move_and_slide()
