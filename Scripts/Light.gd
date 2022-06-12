extends Light2D


export(bool) var can_destroy = true
var destroyed = false


func destroy_light():
	if destroyed:
		return
	
	enabled = false
	destroyed = true
	
	$ExplosionParticle.play_particle()
