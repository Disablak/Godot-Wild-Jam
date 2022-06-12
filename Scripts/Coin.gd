extends Area2D


export(PackedScene) var particle_temple


func _on_Coin_body_entered(body):
	if body.is_in_group("player"):
		SignalBus.emit_signal(SignalBus.coin_took_name)
		
		var particle = particle_temple.instance() as CPUParticles2D
		get_parent().add_child(particle)
		particle.position = position
		particle.color = $Sprite.self_modulate
		particle.play_particle()
		
		queue_free()
