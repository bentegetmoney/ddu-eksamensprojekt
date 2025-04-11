extends Area2D

func _ready() -> void:
	print("hej")
	
func _on_body_entered(body):
	print("player unslowed")
	if body.is_in_group("player"):
		body.take_slow(100)
		print("player slowed")

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_slow(150)
		print("player unslowed")
