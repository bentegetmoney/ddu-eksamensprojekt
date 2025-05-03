extends Area2D

@export var portal_id: String
@export var target_portal_id: String
@export var entered: bool = false

func _on_body_entered(body):
	if body.is_in_group("player") and not body.just_teleported:
		var portals = get_tree().get_nodes_in_group("portals")
		for portal in portals:
			if portal.portal_id == target_portal_id:
				body.just_teleported = true
				body.global_position = portal.global_position
				$AudioStreamPlayer.play()
				break

func _on_body_exited(body: Node2D) -> void:
	body.just_teleported = false
