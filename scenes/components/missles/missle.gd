extends Node2D

var _speed := 500.0
var _target: Node2D
var _turn_angle := 6.0


func _physics_process(delta: float) -> void:
	if _target:
		var angle_diff: float = angle_difference(rotation, _get_angle_to_target())
		var max_turn_angle: float = clamp(angle_diff, - _turn_angle, _turn_angle)
		rotation +=  max_turn_angle * delta
	
	position += Vector2.from_angle(rotation) * _speed * delta


func set_up(rotation: float, target: Node2D = null):
	global_rotation = rotation
	_target = target


func _get_angle_to_target() -> float:
	var target_direction: Vector2 = (_target.position - position).normalized()
	return target_direction.angle()


func _on_timer_timeout() -> void:
	queue_free()
