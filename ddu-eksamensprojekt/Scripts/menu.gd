extends Button

@onready var pop = $PopupMenu

func _on_pressed():
	pop.show()

#id er deres array plads ting
func _on_popup_menu_id_pressed(id):
	match id:
		0: #fortsæt
			pop.hide()
		1: #Startskærm
			Global.level = 3
			get_tree().change_scene_to_file("res://scenes/startscreen.tscn")
		2: #luk spil
			Global.level = 3
			get_tree().quit()
