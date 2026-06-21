extends Node3D

func _on_area_3d_body_entered(body):
	if body.name != "Player":
		return

	if Global.has_key:
		print("La puerta se abre")
		queue_free()
	else:
		print("La puerta está cerrada")