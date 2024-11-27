extends Node2D

signal on_destroyed

@export var _integrity: int = 1
@export var _hardness: int = 0


func set_integrity(integrity: int) -> void:
	_integrity = integrity


func set_hardness(hardness: int) -> void:
	_hardness = hardness


func hit_damage(damage: int) -> void:
	_integrity -= max(damage - _hardness, 0)
	if _integrity <= 0:
		on_destroyed.emit()
