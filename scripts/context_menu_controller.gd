class_name ContextMenuController extends Node

@export var thrash_node : Node2D

func _ready() -> void:
	for node in get_tree().get_nodes_in_group('icons'):
		if node.context_menu_component:
			node.context_menu_component.context_menu_button_pressed.connect(_on_context_menu_button_clicked)


func _on_context_menu_button_clicked(os_icon : SOIcon, command : ContextMenu.ContextMenuCommand) -> void:
	match command:
		ContextMenu.ContextMenuCommand.DELETE:
			var delete_tween = create_tween().set_parallel()
			delete_tween.tween_property(os_icon, 'global_position', thrash_node.global_position, 0.25)
			delete_tween.tween_property(os_icon, 'scale', Vector2.ZERO, 0.25)
			await delete_tween.finished
			os_icon.queue_free()
