extends Area2D
#fungerer bare som ketchup men er sat i sin egen scene alligevel

func _ready() -> void:
	if(get_tree().current_scene.scene_file_path == "res://scenes/level3.tscn"):
		$Instructions.show()

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.take_slow(300)
		print("player slowed")
		$Instructions.hide()

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_slow(200) #tilbage til den normale
		print("player unslowed")
