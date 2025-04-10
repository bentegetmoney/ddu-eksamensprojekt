extends CharacterBody2D

@onready var timer: Timer = $Timer
@export var speed: float = 150
@onready var global = get_node("/root/Global")
@onready var charge_1: ProgressBar = $Charge1

@onready var figur = $figur
@onready var ben = $ben
@onready var ansigt = $ansigt

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
	
	# flip
	var flip_direction = 0
	
	if Input.is_action_pressed("A"):
		flip_direction -= 1 # venstre
	if Input.is_action_pressed("D"):
		flip_direction += 1 # højre
	
	# flipper sprite
	if flip_direction > 0:
		figur.flip_h = false
		ben.flip_h = false
		ansigt.flip_h = false
	elif flip_direction < 0:
		figur.flip_h = true
		ben.flip_h = true
		ansigt.flip_h = true
	
	# if Global.hiit == false: # eventuelt
		if flip_direction == 0:
			ben.play("idle") # selve animationen mangler
			#print(flip_direction)
		else:
			ben.play("run")
			#print(flip_direction)
	
	
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		ballDirection = direction#gemmer retning til skud

	velocity = direction * speed
	move_and_slide()

	#her skyder spilleren
	if Input.is_action_just_pressed("F") and canShoot:
		print("Charging")
		charge_1.value = 0
		charge_1.visible = true
	if Input.is_action_just_released("F") and canShoot:
		shoot()
		charge_1.visible = false
	
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
	bullet.direction = ballDirection.normalized() * charge_1.value #retningen kuglen skal flyve i
	get_parent().add_child(bullet)

func _on_timer_timeout() -> void:
	canShoot = true

func take_damage(amount: int):
	global.hit1 += amount
	print("Player 1 blev ramt! Hits: " + str(global.hit1))
	if global.hit1 >= 3:
		print("spiller " , player_id , " er død")
		#die() der skal laves en funktion som dræber dem
