extends Node2D

@export var bullet_scene: PackedScene

var _rof := 0.2

@onready var timer: Timer = $Timer


func _ready() -> void:
	InputHandler.on_shoot_started.connect(_on_shooting_cannon_started)
	InputHandler.on_shoot_stoped.connect(_on_shooting_cannon_stoped)


func _shoot():
	var bullet = bullet_scene.instantiate()
	get_tree().root.add_child(bullet)
	bullet.position = global_position
	bullet.set_angle(global_rotation)


func _on_shooting_cannon_started() -> void:
	timer.start(_rof)


func _on_shooting_cannon_stoped() -> void:
	timer.stop()


func _on_timer_timeout() -> void:
	_shoot()
