extends Area2D

@export var _damage: int = 1


func _on_area_entered(area: Area2D) -> void:
	area.hit_damage(_damage)
