extends Area2D


signal key_took(key, body)

export(PackedScene) var particle_temple


func _on_Key_body_entered(body):
	emit_signal("key_took", self, body)
	SignalBus.emit_signal("key_took")

	var particle = particle_temple.instance() as CPUParticles2D
	get_parent().add_child(particle)
	particle.position = position
	particle.color = $OrbSprite.self_modulate
	particle.play_particle()

	queue_free()
