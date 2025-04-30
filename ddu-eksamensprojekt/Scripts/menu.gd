extends Button

func _on_pressed():
	$PopupMenu.show()

#id er deres array plads ting
func _on_popup_menu_id_pressed(id):
	match id:
		0: #fortsæt
			$PopupMenu.hide()
		1: #instruktion
			$PopupMenu.hide()
			$PopupPanel.show()
		2: #Startskærm
			get_tree().change_scene_to_file("res://scenes/startscreen.tscn")
		3: #luk spil
			get_tree().quit()
