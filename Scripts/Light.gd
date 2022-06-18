extends Light2D


export var light_distortion = 0.99
export(PackedScene) var break_sound
export var light_enabled = true setget set_light
export(bool) var can_destroy = true

const time_distortion = 0.4

var start_scale = 0.0
var destroyed = false


func _ready():
	start_scale = texture_scale
	$OrbSprite/Spot.material = create_material() if light_enabled else null
	start_light_distorsion()


func destroy_light():
	if (not light_enabled) or (not can_destroy) or destroyed:
		return
	
	var player = break_sound.instance() as AudioStreamPlayer2D
	get_parent().add_child(player)
	player.position = position
	player.play()
	
	enabled = false
	destroyed = true
	
	$OrbSprite/Spot.visible = false
	$ExplosionParticle.play_particle()


func init_light():
	destroyed = false
	$OrbSprite/Spot.visible = true
	
	set_light(true)


func set_light(is_enable):
	light_enabled = is_enable
	enabled = is_enable
	
	$OrbSprite/Spot.material = create_material() if is_enable else null
	
	property_list_changed_notify()


func _on_Area2D_body_entered(body:Node):
	if body.is_in_group("player"):
		init_light()
		print("light collision player")


func start_light_distorsion():
	var tween = get_node("Tween")
	var tween_start = start_scale * light_distortion
	var tween_finish = start_scale
	
	tween.interpolate_property( self, "texture_scale",
		tween_start, tween_finish, time_distortion,
		Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
	tween.start()
	
	if get_tree() == null:
		return
	
	yield(get_tree().create_timer(tween.get_runtime()), "timeout")
	start_light_distorsion()

func create_material():
	var material = CanvasItemMaterial.new()
	material.blend_mode = CanvasItemMaterial.BLEND_MODE_MIX
	material.light_mode = CanvasItemMaterial.LIGHT_MODE_UNSHADED
	
	return material

