extends Node

signal on_g_turn_pressed
signal on_high_g_barrel_left
signal on_high_g_barrel_right
signal on_shoot_started
signal on_shoot_stoped


func _input(event: InputEvent) -> void:
	if event.is_action("g_turn"):
		on_g_turn_pressed.emit(event.is_pressed())

	if event.is_action("high_g_barrel_left"):
		if event.is_pressed():
			on_high_g_barrel_left.emit()
	
	elif event.is_action("high_g_barrel_right"):
		if event.is_pressed():
			on_high_g_barrel_right.emit()
	
	if event.is_action("shoot_cannon"):
		if event.is_released():
			on_shoot_stoped.emit()
		elif Input.is_action_just_pressed("shoot_cannon"):
			on_shoot_started.emit()


func get_input_direction() -> Vector2:
	var direction := Vector2.ZERO

	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	
	return direction
