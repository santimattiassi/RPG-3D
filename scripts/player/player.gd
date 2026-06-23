extends CharacterBody3D

@export var speed := 4.0
@export var run_speed := 7.0

@onready var animated_knight = $AnimatedKnight
@onready var animation_player = $AnimatedKnight/AnimationPlayer

var is_attacking := false
var attack_index := 0
var combo_queued := false
var combo_timer := 0.0
const COMBO_RESET_TIME := 0.8
var combo_cooldown := false

func _physics_process(_delta):

	# Ataque

	combo_timer += _delta

	if combo_timer > COMBO_RESET_TIME:
		attack_index = 0

	if Input.is_action_just_pressed("attack"):

		if combo_cooldown:
			return

		if is_attacking:
			combo_queued = true
		else:
			start_attack()

	# Mientras ataca no puede moverse
	if is_attacking:
		velocity = Vector3.ZERO
		move_and_slide()
		return

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

			if animation_player.current_animation != "Player/Running_B":
				animation_player.play("Player/Running_B")

		else:

			if animation_player.current_animation != "Player/Walking_A":
				animation_player.play("Player/Walking_A")

		animated_knight.look_at(
			animated_knight.global_position - direction,
			Vector3.UP
		)

	else:

		if animation_player.current_animation != "Player/Idle_A":
			animation_player.play("Player/Idle_A")

	move_and_slide()


func start_attack():

	combo_timer = 0.0

	is_attacking = true
	velocity = Vector3.ZERO

	animation_player.speed_scale = 1.5


	match attack_index:

		0:
			animation_player.play("Player/Melee_1H_Attack_Slice_Diagonal")

		1:
			animation_player.play("Player/Melee_1H_Attack_Chop")

		2:
			animation_player.play("Player/Melee_1H_Attack_Stab")

	attack_index += 1

	if attack_index > 2:
		attack_index = 0
		combo_cooldown = true


func _on_animation_player_animation_finished(anim_name):

	if anim_name.begins_with("Player/Melee_1H_Attack"):

		if combo_queued:

			combo_queued = false
			start_attack()

		else:

			is_attacking = false
			animation_player.play("Player/Idle_A")

			if combo_cooldown:

				await get_tree().create_timer(0.5).timeout

			combo_cooldown = false