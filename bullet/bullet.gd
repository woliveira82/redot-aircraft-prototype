extends Node2D

var _speed := 500.0
var _direction := Vector2.RIGHT
var _max_lifetime := 4.0
var _lifetime := 0.0


func _physics_process(delta: float) -> void:
	position += _direction * _speed * delta
	_lifetime += delta
	if _lifetime > _max_lifetime:
		queue_free()


func set_angle(angle: float):
	rotation = angle
	_direction = Vector2.from_angle(angle)
