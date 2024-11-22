extends Node2D

var _enemy_tracked: Node2D


func _process(delta: float) -> void:
	if not _enemy_tracked:
		queue_free()
		return
	
	var camera = get_viewport().get_camera_2d()
	var canvas = get_canvas_transform()
	var top_left = -canvas.origin / canvas.get_scale()
	var size = get_viewport_rect().size / canvas.get_scale()
	
	var relative_position = _enemy_tracked.position - camera.get_screen_center_position() + Vector2(320, 180)
	position.x = clamp(relative_position.x, top_left.x, top_left.x + size.x)
	position.y = clamp(relative_position.y, top_left.y, top_left.y + size.y)
	
	print(position)


func set_enemy(enemy: Node2D):
	_enemy_tracked = enemy
