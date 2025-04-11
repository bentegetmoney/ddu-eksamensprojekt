extends CanvasLayer

@onready var lbl1 = $pl1/player1/Label #(lbl er bare kort label)
@onready var lbl2 = $pl2/Sprite2D/Label
var done = false
var hit1: int=0
var hit2: int=0

func _process(delta: float) -> void:
	lbl1.text = str(Global.hit1)
	lbl2.text = str(Global.hit2)
