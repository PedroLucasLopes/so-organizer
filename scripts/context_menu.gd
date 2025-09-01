class_name ContextMenu extends Control

enum ContextMenuCommand {DELETE}

signal context_menu_button_pressed

@onready var edit_button: Button = %EditButton
@onready var delete_button: Button = %DeleteButton

func _ready() -> void:
	delete_button.pressed.connect(_on_context_menu_button_pressed.bind(ContextMenuCommand.DELETE))

func reveal_context_menu(context_menu_size : Vector2) -> void:
	var tween = create_tween().set_parallel()
	tween.tween_property(self, "size:x", context_menu_size.x, 0.5).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "size:y", context_menu_size.y, 0.5).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_IN_OUT)


func _on_context_menu_button_pressed(command : ContextMenuCommand) -> void:
	context_menu_button_pressed.emit(command)
