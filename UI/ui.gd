extends Control

signal towerplace(TowerType)

signal startNextWave(waveNumber)

var towerType

var health

var money

var wave

@onready var healthLabel = $"topbar (Stats)/HBoxContainer/health"

@onready var waveLabel = $"topbar (Stats)/HBoxContainer/wave"

@onready var moneyLabel = $"topbar (Stats)/HBoxContainer/money"

const discShooterPrice = 50

func _on_button_button_down():
	if(money >= discShooterPrice):
		Globals.money -= discShooterPrice
		towerType = "disc Shooter"
		towerplace.emit(towerType)

func _process(_delta):
	health = Globals.health
	money = Globals.money
	wave = Globals.wave
	updateStats()
	updateTowerButtons()
	

func updateStats():
	healthLabel.text = str(health)
	moneyLabel.text = str(money)
	waveLabel.text = str(wave)

func updateTowerButtons():
	if(money >= discShooterPrice):
		$"sidebar (towers)/VBoxContainer/discShooter".modulate = Color.WHITE
	else:
		$"sidebar (towers)/VBoxContainer/discShooter".modulate = Color.RED


func _on_start_wave_button_down():
	if(!Globals.waveInProgress):
		Globals.waveInProgress = true
		Globals.wave += 1
		wave = Globals.wave
		startNextWave.emit(wave)
