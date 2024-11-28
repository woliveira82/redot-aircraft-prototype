extends Node2D

@export var missile_scene: PackedScene

var _reloading := false

@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var reload_timer: Timer = $ReloadTimer


func _ready() -> void:
	InputHandler.on_missile_launched.connect(_on_missile_launched)


func _on_missile_launched(target: Node2D):
	if not _reloading:
		_reloading = true
		cpu_particles_2d.emitting = true
		var missile: Node2D = missile_scene.instantiate()
		missile.global_position = global_position
		get_tree().root.add_child(missile)
		missile.set_up(global_rotation, target)
		reload_timer.start()


func _on_reload_timer_timeout() -> void:
	_reloading = false
