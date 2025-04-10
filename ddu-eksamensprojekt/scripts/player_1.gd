extends CharacterBody2D

@onready var timer: Timer = $Timer
@export var speed: float = 150
@onready var global = get_node("/root/Global")
@onready var charge_1: ProgressBar = $Charge1

var player_id = 1

var canShoot: bool = true
var ballDirection: Vector2 = Vector2.ZERO

func _process(delta):
	charge_1.value += delta
	var direction = Vector2.ZERO
	if Input.is_action_pressed("D"):
		direction.x += 1
	if Input.is_action_pressed("A"):
		direction.x -= 1
	if Input.is_action_pressed("S"):
		direction.y += 1
	if Input.is_action_pressed("W"):
		direction.y -= 1

	if direction != Vector2.ZERO:
		direction = direction.normalized()
		ballDirection = direction#gemmer retning til skud

	velocity = direction * speed
	move_and_slide()

	#her skyder spilleren
	if Input.is_action_just_pressed("F"):
		print("Charging")
		charge_1.value = 0
		charge_1.visible = true
	if Input.is_action_just_released("F"):
		charge_1.visible = false
		shoot()
	
	#Når man starter spillet og ikke kigger nogen steder hen, sidder bolden fast på spilleren. Nedenstående skyder den bare til højre i stedet :)
	if ballDirection == Vector2.ZERO:
		ballDirection = Vector2.RIGHT

func shoot():
	print("player " , player_id , " skyder")
	

	var bullet = preload("res://scenes/ball.tscn").instantiate()
	bullet.position = position
	bullet.owner_id = 1
	bullet.direction = ballDirection.normalized() * charge_1.value #retningen kuglen skal flyve i
	get_parent().add_child(bullet)



func take_damage(amount: int):
	global.hit1 += amount
	print("Player 1 blev ramt! Hits: " + str(global.hit1))
	if global.hit1 >= 3:
		print("spiller " , player_id , " er død")
		#die() der skal laves en funktion som dræber dem
