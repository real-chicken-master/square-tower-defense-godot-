extends levelParent

func _ready():
	Globals.reset()
	connectSignals()
	$UI/UI.tutorial()
