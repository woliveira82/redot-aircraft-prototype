extends Area2D

signal on_hit_damage


func hit_damage(damage: int):
	on_hit_damage.emit(damage)
