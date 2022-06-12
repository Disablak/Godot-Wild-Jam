extends Node2D


export(PackedScene) var key_template
export var speed_rotate = 50.0
export var radius_key = 30.0


var keys : Array


func add_key():
	var key = key_template.instance() as Light2D
	add_child(key)
	keys.append(key)
	
	var key_offset = 360 / keys.size()
	
	var idx = 0
	for cur_key in keys:
		cur_key.position = get_pos_of_key(idx * key_offset)
		print(cur_key.position)
		idx += 1


func _process(delta):
	rotation_degrees += delta * speed_rotate


func get_pos_of_key(degree : float):
	var rad = deg2rad(degree)
	var result : Vector2
	result.x = radius_key * cos(rad)
	result.y = radius_key * sin(rad)
	
	return result
