extends Node2D

@onready var animation: AnimationPlayer = $AnimatedSprite2D/AnimationPlayer
var started = false
var stage = 0 #de lodrette levels. dem er der 3 af (eller måske kun 2 i vores spil)
#level er de vandrette levels. der er 5 levels pr. stage Jeg sætter den i midten til 3 så det måske er nememre at skifte.. ved ik om der vil være problemer med -
const FILE_BEGIN = "res://scenes/level"
@onready var animated_sprite = $AnimatedSprite2D

func _process(_delta: float) -> void:
	#her skiftes banerne og der sker animation.
	if started == false:
		if Global.hit1<=0:
			#her vinder player 2
			Global.level +=1
			started = true
			animated_sprite.play("winplayer2")
			animation.play("ani") #i parenteset hedder den ani (når man trykker på animationen og kigger på navnet!
		elif Global.hit2<=0:
			#her vinder player 1
			Global.level -=1
			started = true
			animated_sprite.play("winplayer1")
			animation.play("ani")

#bane skifter
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	Global.hit1 = 3
	Global.hit2 = 3
	if get_tree().current_scene.scene_file_path == "res://scenes/tutorial.tscn":
		get_tree().change_scene_to_file("res://scenes/startscreen.tscn")
		Global.level = 3
	else:
		if Global.level < 6 && Global.level > 0:
			print("scenen skal nu skiftes til den næste scene")
			var next_level_path = FILE_BEGIN + str(Global.level) + ".tscn"
			print(next_level_path)
			get_tree().change_scene_to_file(next_level_path)
		else:
			get_tree().change_scene_to_file("res://scenes/startscreen.tscn")
			Global.level = 3
