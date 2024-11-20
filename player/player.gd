extends Node2D

var _speed := 200.0
var _afterburn := 0.0
var _turn := 0.8
var _g_turn := 0.0


func _process(delta: float) -> void:
	var direction = InputHandler.get_input_direction()
	rotation += direction.x * (_turn + _g_turn) * delta
	position += Vector2.from_angle(rotation) * (_speed + _afterburn) * delta

	if Input.is_action_just_pressed("afterburn"):
		_afterburn = 200.0
	if Input.is_action_just_released("afterburn"):
		_afterburn = 0.0
	
	if Input.is_action_just_pressed("g_turn"):
		_g_turn = 0.8
	if Input.is_action_just_released("g_turn"):
		_g_turn = 0.0
	 
