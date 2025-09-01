class_name SOIcon extends Node2D

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

func _on_note_snapped(target_pos : Vector2) -> void:
	current_snapped_position = target_pos
	attempt_to_snap.emit(self)
	drag_component.target_pos = current_snapped_position

func enter_folder() -> void:
	var tween := create_tween()
	
	tween.tween_property(self, "scale", Vector2.ZERO, 0.15) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN)
	
	tween.tween_callback(Callable(self, "queue_free"))
