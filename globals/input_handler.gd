extends Node

signal on_g_turn_pressed
signal on_high_g_barrel_left
signal on_high_g_barrel_right


func _input(event: InputEvent) -> void:
	if event.is_action("g_turn"):
		on_g_turn_pressed.emit(event.is_pressed())

	elif event.is_action("high_g_barrel_left"):
		if event.is_pressed():
			on_high_g_barrel_left.emit()
	
	elif event.is_action("high_g_barrel_right"):
		if event.is_pressed():
			on_high_g_barrel_right.emit()


func get_input_direction() -> Vector2:
	var direction := Vector2.ZERO

	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	
	return direction
