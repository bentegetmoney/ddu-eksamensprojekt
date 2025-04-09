extends Control

@onready var animation: AnimationPlayer = $animation

func _process(delta):
	if Global.hit1>=3:
		#her skal der stå player 2 vandt
		animation.play()
	elif Global.hit2>=3:
		#her skal der stå player 1 vandt
		animation.play()

func _on_animation_animation_finished(anim_name: StringName) -> void:
	print("scenen skal nu skiftes til den næste scene")
	#get_tree().change_scene_to_file(hmm her skal vi navngive filerne noget smart :) )
