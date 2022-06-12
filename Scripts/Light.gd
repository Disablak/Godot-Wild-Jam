extends Light2D


export(bool) var can_destroy = true


func destroy_light():
	enabled = false
