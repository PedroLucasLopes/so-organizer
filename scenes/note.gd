class_name SOIcon
extends Node2D


signal attempt_to_snap

@onready var drag_component: DragComponent = %DragComponent

var current_snapped_position = Vector2.ZERO
var last_snapped_position = Vector2.ZERO

func _ready() -> void:
	add_to_group('icons')
	drag_component.started_snap.connect(_on_note_started_snap)
	drag_component.snapped.connect(_on_note_snapped)
	current_snapped_position = global_position


func _on_note_started_snap() -> void:
	last_snapped_position = global_position
	print("Last snapp updated!")

func _on_note_snapped(target_pos : Vector2) -> void:
	current_snapped_position = target_pos
	attempt_to_snap.emit(self)
	print("Attempted to snap")
	drag_component.target_pos = current_snapped_position
