extends Node2D

var _average_speed := 200.0
var _afterburn_speed := 400.0
var _turn_angle := 0.8
var _g_turn_angle := 1.6
var _g_turn_on := false

@onready var remote_transform_2d: RemoteTransform2D = $RemoteTransform2D


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("g_turn"):
		_g_turn_on = true
	elif Input.is_action_just_released("g_turn"):
		_g_turn_on = false

	var turn_angle: float = _g_turn_angle if _g_turn_on else _turn_angle

	var control: Vector2 = InputHandler.get_input_direction()
	var speed: float = _average_speed
	if control.y > 0.0:
		speed = _afterburn_speed * control.y
	elif control.y < 0.0:
		speed = _average_speed / (1.0 + abs(control.y))

	var direction = Vector2.from_angle(rotation)
	_adjust_remote_transform_position(direction)

	rotation += control.x * turn_angle * delta
	position += direction * speed * delta


func _adjust_remote_transform_position(direction: Vector2):
	remote_transform_2d.position.x = 160 + pow(abs(direction.x), 2.0) * 115.0
