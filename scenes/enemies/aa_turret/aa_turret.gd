extends Node2D


func _on_hitbox_on_destroyed() -> void:
	queue_free()
