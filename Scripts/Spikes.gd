extends Area2D



func _on_Spikes_body_entered(body:Node):
	if body.is_in_group("player"):
		SignalBus.emit_signal(SignalBus.player_died_name)
