extends Control

@onready var animation: AnimationPlayer = $Panel/animation
var started = false

func _process(_delta):
	if started == false:
		if Global.hit1>=3:
			#her skal der stå player 2 vandt
			started = true
			animation.play("Animation") #den hedder Animation når man trykker på animationen og kigger ende på navnet!
		elif Global.hit2>=3:
			#her skal der stå player 1 vandt
			started = true
			#$Panel.position.x+200
			animation.play("Animation")

func _on_animation_animation_finished(Animation) -> void:
	print("scenen skal nu skiftes til den næste scene")
	get_tree().change_scene_to_file("res://scenes/startscreen.tscn")
