extends Node2D

var _speed := 200.0
var _turn_angle := 0.8
var _player: Node2D

@onready var hitbox: Area2D = $Hitbox


func _ready() -> void:
	_player = get_tree().get_first_node_in_group("player")
	hitbox.on_destroyed.connect(_on_destroyed)


func _process(delta: float) -> void:
	var angle_diff: float = angle_difference(rotation, _get_player_angle())
	var max_turn_angle: float = clamp(angle_diff, - _turn_angle, _turn_angle)
	rotation +=  max_turn_angle * delta
	position += Vector2.from_angle(rotation) * _speed * delta


func _get_player_angle() -> float:
	var player_direction: Vector2 = (_player.position - position).normalized()
	return player_direction.angle()


func _on_destroyed() -> void:
	queue_free()
