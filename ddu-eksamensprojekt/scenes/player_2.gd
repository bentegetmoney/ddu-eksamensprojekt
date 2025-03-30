extends CharacterBody2D

@export var speed: float = 150  # Hastighed i pixels per sekund

func _process(delta):
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
		direction = direction.normalized()  # Normaliser for ensartet hastighed i diagonale retninger
	
	velocity = direction * speed
	move_and_slide()
