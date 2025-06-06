extends CharacterBody2D

var blå_shader = preload("res://assets/shaders/blå.gdshader")
var grøn_shader = preload("res://assets/shaders/grøn.gdshader")
var gul_shader = preload("res://assets/shaders/gul.gdshader")
var lilla_shader = preload("res://assets/shaders/lilla.gdshader")
var orange_shader = preload("res://assets/shaders/orange.gdshader")
var pink_shader = preload("res://assets/shaders/pink.gdshader")
var rød_shader = preload("res://assets/shaders/rød.gdshader")
var hvid_shader = preload("res://assets/shaders/hvid.gdshader")

var database : SQLite
var is_charging: bool = false

@onready var timer: Timer = $Timer
@export var speed: float = 200
@onready var global = get_node("/root/Global")
@onready var charge_1: ProgressBar = $Charge1
@onready var ben: AnimatedSprite2D = $ben

var just_teleported = false
var player_id = 1
var canShoot: bool = true
var ballDirection: Vector2 = Vector2.ZERO

func _ready() -> void:
	database = SQLite.new()
	database.path = "res://data.db"
	database.open_db()
	
	apply_shader_from_database()

func apply_shader_from_database():
	var result = database.select_rows("playerColor", "id = 1", ["color"])
	
	if result.size() > 0:
		var color_name = result[0]["color"].to_lower()
		print("Fetched color from database:", color_name)
		
		match color_name:
			"blå":
				ben.material.shader = blå_shader
			"rød":
				ben.material.shader = rød_shader
			"orange":
				ben.material.shader = orange_shader
			"gul":
				ben.material.shader = gul_shader
			"grøn":
				ben.material.shader = grøn_shader
			"lilla":
				ben.material.shader = lilla_shader
			"pink":
				ben.material.shader = pink_shader
			"lyserød":
				ben.material.shader = pink_shader
			"hvid":
				ben.material.shader = hvid_shader
			_:
				print("No matching shader found for color:", color_name)
	else:
		print("No result found in the database!") 

func _process(delta):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("D"):
		ben.flip_h = false
		direction.x += 1
	if Input.is_action_pressed("A"):
		ben.flip_h = true
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
		
		if !ben.is_playing() or ben.animation != "ben":
			ben.play("ben")
	
	else:
		velocity = Vector2.ZERO
		move_and_slide()
		
		if !ben.is_playing() or ben.animation != "stationary":
			ben.play("stationary")

	# --- Charging logic ---
	if Input.is_action_just_pressed("F") and canShoot:
		is_charging = true
		charge_1.value = 0
		charge_1.visible = true
	elif Input.is_action_pressed("F") and is_charging:
		charge_1.value = min(charge_1.value + delta, 1.0)  # Cap charge time (1 second)
	elif Input.is_action_just_released("F") and is_charging and canShoot:
		is_charging = false
		shoot()
		charge_1.visible = false
	
	#Når man starter spillet og ikke kigger nogen steder hen, sidder bolden fast på spilleren. Nedenstående skyder den bare til højre i stedet :)
	if ballDirection == Vector2.ZERO:
		ballDirection = Vector2.RIGHT

func shoot():
	var sound_shoot = $Sounds/Shoot
	print("player " , player_id , " skyder")
	canShoot = false
	timer.start()
	sound_shoot.play()

	var bullet = preload("res://scenes/ball.tscn").instantiate()
	bullet.get_node("AnimatedSprite2D").play("tomat")
	
	bullet.position = position
	bullet.owner_id = 1
	bullet.direction = ballDirection.normalized() * charge_1.value #retningen kuglen skal flyve i
	get_parent().add_child(bullet)

func _on_timer_timeout() -> void:
	canShoot = true

func take_damage(amount: int):
	var sound_ouch = $Sounds/Ouch
	global.hit1 -= amount
	sound_ouch.play()
	print("Player 1 blev ramt! Hits: " + str(global.hit1))
	if global.hit1 <= 0:
		print("spiller " , player_id , " er død")

func take_slow(amount: int):
	speed=amount
	print("player er slowed")
