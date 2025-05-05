extends CanvasLayer

@onready var lbl1 = $pl1/player1/Label #(lbl er bare kort label)
@onready var lbl2 = $pl2/Sprite2D/Label
var done = false

func _process(_delta) -> void:
	lbl1.text = "Liv: " + str(Global.hit1)
	lbl2.text = "Liv:" + str(Global.hit2)
