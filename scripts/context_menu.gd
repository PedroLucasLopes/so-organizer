class_name ContextMenu extends Control


func reveal_context_menu(context_menu_size : Vector2) -> void:
	var tween = create_tween().set_parallel()
	tween.tween_property(self, "size:x", context_menu_size.x, 0.5).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "size:y", context_menu_size.y, 0.5).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_IN_OUT)
