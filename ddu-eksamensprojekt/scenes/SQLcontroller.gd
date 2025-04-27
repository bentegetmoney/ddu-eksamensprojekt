extends Control

var database : SQLite
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	database = SQLite.new()
	database.path = "res://data.db"
	database.open_db()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_start_spil_button_down() -> void:
	var color1 = $Color1.text
	var color2 = $Color2.text
	database.update_rows("playerColor", "id = 1", {"color": color1})
	database.update_rows("playerColor", "id = 2", {"color": color2})
