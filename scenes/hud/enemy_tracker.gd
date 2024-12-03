extends RayCast2D

const VIEWPORT_CENTER := Vector2(320, 180)

var _enemy_tracked: Node2D

@onready var out_screen_sprite: Sprite2D = $OutScreenSprite
@onready var on_screen_sprite: Sprite2D = $OnScreenSprite


func _process(_delta: float) -> void:
	if not _enemy_tracked:
		queue_free()
		return
	
	var camera = get_viewport().get_camera_2d()
	var relative_position: Vector2 = _enemy_tracked.position - camera.get_screen_center_position()
	target_position = relative_position * camera.zoom
	
	if is_colliding():
		on_screen_sprite.hide()
		out_screen_sprite.show()
		var collision_point := get_collision_point() - position
		out_screen_sprite.position = collision_point
		out_screen_sprite.rotation = collision_point.angle()
	
	else:
		out_screen_sprite.hide()
		on_screen_sprite.show()
		on_screen_sprite.position = relative_position * camera.zoom


func set_enemy(enemy: Node2D):
	_enemy_tracked = enemy


func _on_on_screen_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if (event as InputEventMouseButton).button_index == MOUSE_BUTTON_RIGHT:
			InputHandler.on_missile_launched.emit(_enemy_tracked)


func _on_out_screen_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if (event as InputEventMouseButton).button_index == MOUSE_BUTTON_RIGHT:
			InputHandler.on_missile_launched.emit(_enemy_tracked)
