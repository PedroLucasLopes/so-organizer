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


func select_icons_in_area() -> void:
	pass
