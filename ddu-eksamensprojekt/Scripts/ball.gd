extends Area2D

@export var speed: float = 300
var direction: Vector2 = Vector2.RIGHT
var owner_id: int = 1

func _process(delta):
	position += direction * speed * delta
