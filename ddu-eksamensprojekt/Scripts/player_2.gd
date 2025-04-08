extends CharacterBody2D

@onready var timer: Timer = $Timer
@export var speed: float = 150
@onready var global = get_node("/root/Global")

var player_id = 2

var canShoot: bool = true
var ballDirection: Vector2 = Vector2.ZERO

func _process(delta):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	if direction != Vector2.ZERO:
		direction = direction.normalized()
		ballDirection = direction#gemmer retning til skud

	velocity = direction * speed
	move_and_slide()

	#her skyder spilleren
	if Input.is_action_just_pressed("Space") and canShoot:
		shoot()
	
	#Når man starter spillet og ikke kigger nogen steder hen, sidder bolden fast på spilleren. Nedenstående skyder den bare til højre i stedet :)
	if ballDirection == Vector2.ZERO:
		ballDirection = Vector2.RIGHT

func shoot():
	print("player " , player_id , " skyder")
	canShoot = false
	timer.start()

	var bullet = preload("res://scenes/ball.tscn").instantiate()
	bullet.position = position
	bullet.owner_id = 1
	bullet.direction = ballDirection.normalized()#Retningen kuglen skal flyve i
	get_parent().add_child(bullet)

func _on_timer_timeout() -> void:
	canShoot = true

func take_damage(amount: int):
	global.hit2 += amount
	print("Player 2 blev ramt! Hits: " + str(global.hit2))
	if global.hit2 >= 3:
		print("spiller " , player_id , " er død")
		#die() der skal laves en funktion der dræber spilleren
