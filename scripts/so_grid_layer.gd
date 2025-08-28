extends Node


var occupied_positions : Array[Vector2] = []


func _ready() -> void:
	for icon in get_tree().get_nodes_in_group('icons'):
		if icon.has_signal('attempt_to_snap'):
			icon.attempt_to_snap.connect(_on_icon_attempt_to_snap)
			occupied_positions.append(icon.current_snapped_position)

func _on_icon_attempt_to_snap(icon : SOIcon) -> void:
	print(occupied_positions)
	var directions = [Vector2.UP, Vector2.DOWN, Vector2.RIGHT, Vector2.LEFT]
	var current_pos : Vector2 = icon.current_snapped_position
	while occupied_positions.has(current_pos):
		if directions.is_empty(): 
			icon.current_snapped_position = icon.last_snapped_position
			return
		current_pos = icon.current_snapped_position + (directions.pop_front() * icon.drag_component.tile_size)
	print("Found snap position!")
	icon.current_snapped_position = current_pos
	occupied_positions.append(icon.current_snapped_position)
	occupied_positions.erase(icon.last_snapped_position)
