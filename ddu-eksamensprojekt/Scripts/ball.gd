extends Area2D

@export var speed: float = 300
var direction: Vector2 = Vector2.RIGHT
var owner_id: int = 1

func _process(delta):
	position += direction * speed * delta

func _on_area_entered(area):
	if area.is_in_group("player") and area.player_id != owner_id:
		print("Spiller rammes")
		area.take_damage(1)
		queue_free()#fjerner bolden
