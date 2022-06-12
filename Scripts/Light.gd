tool
extends Light2D


export var light_enabled = true setget set_light
export(bool) var can_destroy = true
var destroyed = false


func destroy_light():
	if destroyed:
		return
	
	enabled = false
	destroyed = true
	
	$ExplosionParticle.play_particle()


func init_light():
	if not destroyed:
		return
	
	enabled = true
	destroyed = false


func set_light(is_enable):
	light_enabled = is_enable
	enabled = is_enable
	
	property_list_changed_notify()


func _on_Area2D_body_entered(body:Node):
	if body.is_in_group("player"):
		init_light()
		print("light collision player")
