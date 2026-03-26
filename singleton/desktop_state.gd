extends Node

## controla o estado do desktop

enum State {IDLE, HOVERING, DRAGGING, SELECTING, CONTEXT_MENU}

var current_state : State = State.IDLE

var contexto_atual : String = "desktop" ## muda dependendo do contexto que eu tenho

var dragged_item : Node2D = null

func is_idle() -> bool:
	return current_state == State.IDLE

func can_interact(contexto : String) -> bool:
	if contexto == contexto_atual:
		return current_state == State.IDLE or current_state == State.HOVERING
	return false
