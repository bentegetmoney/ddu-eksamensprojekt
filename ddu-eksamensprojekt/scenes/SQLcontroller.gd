extends Control

var database : SQLite
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	database = SQLite.new()
	database.path = "res://data.db"
	database.open_db()
	
	
	var result1 = database.select_rows("playerColor", "id = 1", ["color"])
	if result1.size() > 0:
		$Color1.text = result1[0]["color"]

	
	var result2 = database.select_rows("playerColor", "id = 2", ["color"])
	if result2.size() > 0:
		$Color2.text = result2[0]["color"]

func _on_start_spil_button_down() -> void:
	var color1 = $Color1.text
	var color2 = $Color2.text
	database.update_rows("playerColor", "id = 1", {"color": color1})
	database.update_rows("playerColor", "id = 2", {"color": color2})
	get_tree().change_scene_to_file("res://scenes/level3.tscn")
