extends Node2D

@export var bullet_scene: PackedScene

var _player: Node2D
var _turn_speed := 1.8
var _cannon_tip := Vector2(14.0, 0.0)
var _layer_mask := 2

@onready var timer: Timer = $Timer


func _ready() -> void:
	_player = get_tree().get_first_node_in_group("player")


func _process(delta: float) -> void:
	if _player:
		var angle: float = (_predict_player_position() - global_position).angle()
		var dif_rotation = rotate_toward(rotation, angle, _turn_speed) - rotation
		var max_rotation: float = min(abs(dif_rotation), _turn_speed)
		rotation += max_rotation * sign(dif_rotation) * delta


func _on_radar_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_area"):
		timer.start()


func _on_radar_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("player_area"):
		timer.stop()


func _on_timer_timeout() -> void:
	var bullet: Bullet = bullet_scene.instantiate()
	get_tree().root.add_child(bullet)
	bullet.set_up(global_position, global_rotation, _layer_mask)


func _predict_player_position() -> Vector2:
	return _player.global_position
