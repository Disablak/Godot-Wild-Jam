extends Light2D


export(bool) var can_destroy = false


func destroy_light():
	enabled = false
