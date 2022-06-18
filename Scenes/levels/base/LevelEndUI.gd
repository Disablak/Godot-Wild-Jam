extends CanvasLayer


export var secret_collected_text: String
export var secret_not_collected_text: String

var coin_collected: bool = false

func _ready():
	SignalBus.connect(SignalBus.level_comleted_name, self, "_show")
	SignalBus.connect(SignalBus.coin_took_name, self, "coin_collected")


func _show():
	$EndUI.visible = true
	if coin_collected:
		$EndUI/VBoxContainer2/Secret.text = secret_collected_text
	else:
		$EndUI/VBoxContainer2/CenterContainer/Coin.visible = false
		$EndUI/VBoxContainer2/Secret.text = secret_not_collected_text
	
func coin_collected():
	coin_collected = true
