class_name SelectionController extends Node


@onready var selection_rect: ColorRect = %SelectionRect

var start_drag_position = Vector2.ZERO

var is_dragging = false


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			is_dragging = true
			start_drag_position = selection_rect.get_global_mouse_position()
			selection_rect.visible = false
		else:
			is_dragging = false
			selection_rect.visible = false
			select_icons_in_area()
	
	if event is InputEventMouseMotion and is_dragging:
		update_selection_box()


func update_selection_box() -> void:
	var current_mouse_position = selection_rect.get_global_mouse_position()
	
	var top_left = Vector2(
		min(start_drag_position.x, current_mouse_position.x),
		min(start_drag_position.y, current_mouse_position.y)
	)
	
	var size = Vector2(
		abs(current_mouse_position.x - start_drag_position.x),
		abs(current_mouse_position.y - start_drag_position.y)
	)
	
	selection_rect.position = top_left
	selection_rect.size = size
	selection_rect.visible = true

func select_icons_in_area() -> void:
	pass
