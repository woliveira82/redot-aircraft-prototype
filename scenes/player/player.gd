extends Node2D

var maneuvering := false
var _min_speed := 100.0
var _max_speed := 400.0
var _avg_speed := 200.0
var _speed := 200
var _acc := 200.0
var _skew := 0
var _skew_current := 0.0
var _skew_times := [0.05, 0.15, 0.25, 0.35, 0.4]

@onready var remote_transform_2d: RemoteTransform2D = $RemoteTransform2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var hitbox: Area2D = $Hitbox
@onready var launcher: Node2D = $Launcher


func _ready() -> void:
	InputHandler.on_high_g_barrel_left.connect(_on_high_g_barrel_left)
	InputHandler.on_high_g_barrel_right.connect(_on_high_g_barrel_right)
	hitbox.on_destroyed.connect(_on_destroyed)


func _process(delta: float) -> void:
	var control: Vector2

	if maneuvering:
		control = Vector2.ZERO
		_speed = _avg_speed
	
	else:
		control = InputHandler.get_input_direction()
		_skew = _update_skew(control.x, delta)
		sprite_2d.update_skew(_skew)
		
		if control.y != 0.0:
			_speed = clamp(_speed + _acc * delta * control.y, _min_speed, _max_speed)
		else:
			if _speed > _avg_speed:
				_speed = clamp(_speed - _acc * delta, _avg_speed, _max_speed)
			elif _speed < _avg_speed:
				_speed = clamp(_speed + _acc * delta, _avg_speed, _max_speed)

	var direction = Vector2.from_angle(rotation)
	_adjust_remote_transform_position(direction)

	rotation += 0.4 * _skew * delta
	position += direction * _speed * delta


func turn_off_maneuvering():
	maneuvering = false


func _update_skew(skew_control: float, delta: float) -> int:
	_skew_current += delta * skew_control
	_skew_current = clamp(_skew_current, -_skew_times[-1], _skew_times[-1])
	
	for i in _skew_times.size():
		if abs(_skew_current) <= _skew_times[i]:
			return i * sign(_skew_current)
	
	return 0


func _adjust_remote_transform_position(direction: Vector2):
	remote_transform_2d.position.x = 160 + pow(abs(direction.x), 2.0) * 115.0


func _on_high_g_barrel_left():
	maneuvering = true
	animation_player.play("high_g_barrel_left")


func _on_high_g_barrel_right():
	maneuvering = true
	animation_player.play("high_g_barrel_right")


func _on_destroyed():
	queue_free()
