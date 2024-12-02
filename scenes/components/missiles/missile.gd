extends Node2D

@export var _damage := 10

var _speed := 500.0
var _target: Node2D
var _turn_angle := 2.4

@onready var hurtbox: Area2D = $Hurtbox

func _process(delta: float) -> void:
	if _target:
		var angle_diff: float = angle_difference(global_rotation, _get_angle_to_target())
		rotation +=  _turn_angle * sign(angle_diff) * delta
	
	position += Vector2.from_angle(rotation) * _speed * delta


func set_up(rotation: float, target: Node2D = null):
	global_rotation = rotation
	_target = target


func _get_angle_to_target() -> float:
	var target_direction: Vector2 = (_target.position - position).normalized()
	return target_direction.angle()


func _on_timer_timeout() -> void:
	queue_free()


func _on_hurtbox_area_entered(area: Area2D) -> void:
	area.hit_damage(_damage)
	queue_free()


func _on_activate_timer_timeout() -> void:
	hurtbox.monitoring = true
