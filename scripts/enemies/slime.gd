extends CharacterBody3D

var health := 3

func _ready():
	print("SLIME CARGADO")

func take_damage(amount):
	health -= amount

	print("Slime HP:", health)

	if health <= 0:
		print("Slime muerto")
		queue_free()