extends Control

@export var enemy_tracker: PackedScene

var enemies := []


func _ready() -> void:
	enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		var tracker := enemy_tracker.instantiate()
		add_child(tracker)
		tracker.set_enemy(enemy)
