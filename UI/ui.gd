extends Control

signal towerplace(TowerType)

var towerType

@onready var healthLabel = $"topbar (Stats)/HBoxContainer/health"

@onready var waveLabel = $"topbar (Stats)/HBoxContainer/wave"

@onready var moneyLabel = $"topbar (Stats)/HBoxContainer/money"


func _on_button_button_down():
	towerType = "disc Shooter"
	towerplace.emit(towerType)

func _process(delta):
	updateUi()

func updateUi():
	healthLabel.text = str(Globals.health)
	moneyLabel.text = str(Globals.money)
	waveLabel.text = str(Globals.wave)

