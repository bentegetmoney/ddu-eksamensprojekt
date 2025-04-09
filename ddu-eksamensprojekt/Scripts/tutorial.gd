extends Node

var has_moved = false
var has_shot = false
var taken_health = false

@onready var move = $instructions/movement
@onready var attack = $instructions/attack
@onready var health = $instructions/health
@onready var timer: Timer = $Timer

func _process(delta):
	if has_moved == false:
		if Input.is_action_pressed("D") or Input.is_action_pressed("ui_right"):
			has_moved = true
			await get_tree().create_timer(1).timeout #meget nemmere måde at lave timer på
			move.visible = false
			attack.visible = true
	elif has_shot == false:
		if Input.is_action_just_pressed("F") or Input.is_action_just_pressed("Space"):
			has_shot = true
			await get_tree().create_timer(1).timeout
			attack.visible = false
	elif taken_health == false:
		if Global.hit1>=1 or Global.hit2>=1:
			taken_health = true
			health.visible = true
			timer.start(5)

func _on_timer_timeout() -> void:
	#spil winning screen. når den er spillet skal skærmen tilbage til menu :)
	print("nu skal der skiftes scene til vinderskærm")
