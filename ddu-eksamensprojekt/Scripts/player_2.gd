extends CharacterBody2D

@onready var timer: Timer = $Timer
@export var speed: float = 150
@onready var global = get_node("/root/Global")
@onready var charge_2: ProgressBar = $charge2
@onready var ben: AnimatedSprite2D = $ben

var player_id = 2

var canShoot: bool = true
var ballDirection: Vector2 = Vector2.ZERO

func _process(delta):
	charge_2.value += delta
	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		ben.flip_h = false
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		ben.flip_h = true
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
		
		if !ben.is_playing() or ben.animation != "ben":
			ben.play("ben")
			
			
	
	else:
		velocity = Vector2.ZERO
		move_and_slide()
		
		if !ben.is_playing() or ben.animation != "stationary":
			ben.play("stationary")
	
	#her skyder spilleren
	if Input.is_action_just_pressed("Space") and canShoot:
		print("Charging")
		charge_2.value = 0
		charge_2.visible = true
	if Input.is_action_just_released("Space") and canShoot:
		shoot()
		charge_2.visible = false
	
	#Når man starter spillet og ikke kigger nogen steder hen, sidder bolden fast på spilleren. Nedenstående skyder den bare til højre i stedet :)
	if ballDirection == Vector2.ZERO:
		ballDirection = Vector2.RIGHT

func shoot():
	print("player " , player_id , " skyder")
	canShoot = false
	timer.start()

	var bullet = preload("res://scenes/ball.tscn").instantiate()
	bullet.position = position
	bullet.owner_id = 2
	bullet.direction = ballDirection.normalized() * charge_2.value #retningen kuglen skal flyve i
	get_parent().add_child(bullet)

func _on_timer_timeout() -> void:
	canShoot = true

func take_damage(amount: int):
	global.hit2 += amount
	print("Player 2 blev ramt! Hits: " + str(global.hit2))
	if global.hit2 >= 3:
		print("spiller " , player_id , " er død")
		#die() der skal laves en funktion der dræber spilleren
func take_slow(amount: int):
	speed=amount
	print("player er slowed")
