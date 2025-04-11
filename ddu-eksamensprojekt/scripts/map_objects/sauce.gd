extends Node2D

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.take_slow(100)

func _on_body_exited(body: Node2D) -> void:
	body.take_slow(150)
	
