extends Area2D

@export var speed: float = 300
var direction: Vector2 = Vector2.RIGHT
var owner_id: int = 0

func _process(delta):
	position += direction * speed * delta

func _on_body_entered(body) -> void:
	if body.is_in_group("player") and body.player_id != owner_id:
		body.take_damage(1)
		queue_free()#fjerner bolden

func _on_screen_exited() -> void:
	queue_free() # Replace with function body.
