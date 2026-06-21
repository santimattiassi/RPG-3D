extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.spawn_point == "from_cave":
		$Player.global_position = $SpawnFromCave.global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_cave_entrance_body_entered(body):
	if body.name == "Player":
		Global.spawn_point = "from_world"
		get_tree().call_deferred(
		"change_scene_to_file",
		"res://scenes/world/cave.tscn"
		)