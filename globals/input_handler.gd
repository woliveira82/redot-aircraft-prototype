extends Node

# signal on_shoot_pressed
# signal on_shoot_released
# signal on_secondary_weapon

# signal on_transform_pressed


# func _input(event: InputEvent) -> void:
# 	if event is InputEventMouseButton:
# 		match event.button_index:
# 			MOUSE_BUTTON_LEFT:
# 				if event.pressed:
# 					on_shoot_pressed.emit()
# 				else:
# 					on_shoot_released.emit()
# 			MOUSE_BUTTON_RIGHT:
# 				if event.pressed:
# 					on_secondary_weapon.emit()

# 	elif event is InputEventKey:
# 		if event.is_action_pressed("Transform"):
# 			on_transform_pressed.emit()


func get_input_direction() -> Vector2:
	var direction := Vector2.ZERO

	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	
	return direction.normalized()
