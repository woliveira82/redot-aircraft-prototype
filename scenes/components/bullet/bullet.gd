class_name Bullet
extends Node2D

@export var _damage: int = 1

var _speed := 600.0
var _direction := Vector2.RIGHT
var _max_lifetime := 4.0
var _lifetime := 0.0

@onready var hurtbox: Area2D = $Hurtbox


func _physics_process(delta: float) -> void:
	position += _direction * _speed * delta
	_lifetime += delta
	if _lifetime > _max_lifetime:
		queue_free()


func set_up(position: Vector2, rotation: float, collision_mask: int):
	global_position = position
	global_rotation = rotation
	_direction = Vector2.from_angle(rotation)
	hurtbox.collision_mask = collision_mask


func _on_hurtbox_area_entered(area: Area2D) -> void:
	area.hit_damage(_damage)
	queue_free()
