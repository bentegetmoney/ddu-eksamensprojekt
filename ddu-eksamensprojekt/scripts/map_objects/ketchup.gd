extends Area2D

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.take_slow(100)
		print("player slowed")

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_slow(200) #tilbage til den normale
		print("player unslowed")
