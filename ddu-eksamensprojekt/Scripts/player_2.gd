extends CharacterBody2D

var blå_shader = preload("res://Assets/shaders/blå.gdshader")
var grøn_shader = preload("res://Assets/shaders/grøn.gdshader")
var gul_shader = preload("res://Assets/shaders/gul.gdshader")
var lilla_shader = preload("res://Assets/shaders/lilla.gdshader")
var orange_shader = preload("res://Assets/shaders/orange.gdshader")
var pink_shader = preload("res://Assets/shaders/pink.gdshader")
var rød_shader = preload("res://Assets/shaders/rød.gdshader")
var hvid_shader = preload("res://Assets/shaders/hvid.gdshader")

var database : SQLite

@onready var timer: Timer = $Timer
@export var speed: float = 200
@onready var global = get_node("/root/Global")
@onready var charge_2: ProgressBar = $charge2
@onready var ben: AnimatedSprite2D = $ben

var just_teleported = false
var player_id = 2
var canShoot: bool = true
var ballDirection: Vector2 = Vector2.ZERO

func _ready() -> void:
	database = SQLite.new()
	database.path = "res://data.db"
	database.open_db()
	
	apply_shader_from_database()

func apply_shader_from_database():
	var result = database.select_rows("playerColor", "id = 2", ["color"])
	
	if result.size() > 0:
		var color_name = result[0]["color"].to_lower()
		print("Fetched color from database:", color_name)
		
		match color_name:
			"blå":
				ben.material = blå_shader
			"rød":
				ben.material = rød_shader
			"orange":
				ben.material = orange_shader
			"gul":
				ben.material = gul_shader
			"grøn":
				ben.material = grøn_shader
			"lilla":
				ben.material = lilla_shader
			"pink":
				ben.material = pink_shader
			"lyserød":
				ben.material = pink_shader
			"hvid":
				ben.material = hvid_shader
			_:
				print("No matching shader found for color:", color_name)
	else:
		print("No result found in the database!")

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
	bullet.get_node("AnimatedSprite2D").play("krymmel")

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
