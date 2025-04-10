extends Control

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level3.tscn")
	
func _on_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn")

func _on_slut_pressed() -> void:
	get_tree().quit()
