extends Area3D

# Teleport the player when they enter the death zone
func _on_area_entered(area: Node3D) -> void:
	await get_tree().create_timer(3).timeout
	if area.is_in_group("player"):
		var player = area  # The player node
		print("Teleporting to last grounded position:", Global.last_grounded_position)

		# Ensure you teleport the root player node, not a collider
		if player is CharacterBody3D:
			# Teleport and reset velocity
			player.get_parent().global_transform.origin = Global.last_grounded_position
			player.get_parent().velocity = Vector3.ZERO  # Reset velocity to prevent continued falling

			# Immediately apply the position to avoid physics delay
			player.get_parent().move_and_slide()
