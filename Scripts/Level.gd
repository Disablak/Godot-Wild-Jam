extends Node



func _on_Finish_body_entered(body:Node):
	SignalBus.emit_signal(SignalBus.level_comleted_name)
