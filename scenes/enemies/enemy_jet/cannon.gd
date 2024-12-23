extends Node2D

@export var bullet_scene: PackedScene

var _shooting := false
var _rof := 0.15
var _fire_time := 0.0
var _layer_mask := 2


func _physics_process(delta: float) -> void:
	if _shooting:
		_fire_time -= delta
		if _fire_time <= 0.0:
			_shoot()
			_fire_time = _rof


func _shoot():
	var bullet = bullet_scene.instantiate()
	get_tree().root.add_child(bullet)
	bullet.set_up(global_position, global_rotation, _layer_mask)


func _on_shooting_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_area"):
		_fire_time = 0.0
		_shooting = true
		


func _on_shooting_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("player_area"):
		_shooting = false
