extends Node


signal level_done


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Finish_body_entered(body:Node):
	print("level completed!")
	emit_signal("level_done")
