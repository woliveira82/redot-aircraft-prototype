extends Node

signal on_g_turn_on
signal on_g_turn_off
signal on_high_g_barrel_left
signal on_high_g_barrel_right


func _input(event: InputEvent) -> void:
	if event.is_action("g_turn"):
		if event.is_pressed():
			on_g_turn_on.emit()

		else:
			on_g_turn_off.emit()


func get_input_direction() -> Vector2:
	var direction := Vector2.ZERO

	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	
	return direction.normalized()
