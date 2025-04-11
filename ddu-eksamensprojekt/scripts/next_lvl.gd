extends Node2D

@onready var animation: AnimationPlayer = $Panel/AnimationPlayer
var started = false
var stage = 0 #de lodrette levels. dem er der 3 af (eller måske kun 2 i vores spil)
var level = 3 #her er de vandrette levels. der er 5 levels pr. stage Jeg sætter den i midten til 3 så det måske er nememre at skifte.. ved ik om der vil være problemer med -
const FILE_BEGIN = "res://scenes/level"
#labels
@onready var vinder = $Panel/Label

func _process(delta: float) -> void:
	#her skiftes banerne og der sker animation.
	if started == false:
		if Global.hit1>=3:
			#her vinder player 2
			level +=1
			Global.hit1 = 0
			Global.hit2 = 0
			started = true
			vinder.text = "player 2 har vundet"
			animation.play("ani") #i parenteset hedder den Animation (når man trykker på animationen og kigger ende på navnet!
		elif Global.hit2>=3:
			#her vinder player 1
			level -=1
			Global.hit1 = 0
			Global.hit2 = 0
			started = true
			vinder.text = "player 1 har vundet"
			animation.play("ani")

#bane skifter
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if level < 5 && level > 0:
		print("scenen skal nu skiftes til den næste scene")
		var next_level_path = FILE_BEGIN + str(level) + ".tscn"
		print(next_level_path)
		get_tree().change_scene_to_file(next_level_path)
	else:
		get_tree().change_scene_to_file("res://scenes/startscreen.tscn")
