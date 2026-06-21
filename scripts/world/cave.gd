extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(Global.spawn_point)

	if Global.spawn_point == "from_world":
		$Player.global_position = $SpawnFromWorld.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_pickup_area_body_entered(body):
	if body.name == "Player":
		Global.has_key = true
		print(Global.has_key)
		print("¡Conseguiste una llave!")
		$Key.queue_free()

func _on_exit_cave_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		Global.spawn_point = "from_cave"
		get_tree().call_deferred(
		"change_scene_to_file",
		"res://scenes/world/world.tscn"
		)
