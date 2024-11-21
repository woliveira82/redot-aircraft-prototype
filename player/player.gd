extends Node2D

var _average_speed := 200.0
var _afterburn_speed := 400.0
var _turn_angle := 0.8
var _g_turn_angle := 1.6
var _g_turn_on := false
var maneuvering := false

@onready var remote_transform_2d: RemoteTransform2D = $RemoteTransform2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	InputHandler.on_g_turn_pressed.connect(_set_g_force)
	InputHandler.on_high_g_barrel_left.connect(_on_high_g_barrel_left)
	InputHandler.on_high_g_barrel_right.connect(_on_high_g_barrel_right)


func _process(delta: float) -> void:
	var turn_angle: float
	var control: Vector2
	var speed: float

	if maneuvering:
		turn_angle = _turn_angle
		control = Vector2.ZERO
		speed = _average_speed
	
	else:
		turn_angle = _g_turn_angle if _g_turn_on else _turn_angle

		control = InputHandler.get_input_direction()
		if control.y > 0.0:
			speed = _afterburn_speed * control.y
		elif control.y < 0.0:
			speed = _average_speed / (1.0 + abs(control.y))
		else:
			speed = _average_speed

	var direction = Vector2.from_angle(rotation)
	_adjust_remote_transform_position(direction)

	rotation += control.x * turn_angle * delta
	position += direction * speed * delta


func _adjust_remote_transform_position(direction: Vector2):
	remote_transform_2d.position.x = 160 + pow(abs(direction.x), 2.0) * 115.0


func _set_g_force(g_force: bool):
	_g_turn_on = g_force


func _on_high_g_barrel_left():
	maneuvering = true
	animation_player.play("high_g_barrel_left")


func _on_high_g_barrel_right():
	maneuvering = true
	animation_player.play("high_g_barrel_right")


func turn_off_maneuvering():
	maneuvering = false
