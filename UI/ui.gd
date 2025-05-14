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

const sniperPrice = 100

func _on_disc_shooter_button_down():
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
	if(money >= sniperPrice):
		$"sidebar (towers)/VBoxContainer/sniper".modulate = Color.WHITE
	else:
		$"sidebar (towers)/VBoxContainer/sniper".modulate = Color.RED


func _on_start_wave_button_down():
	if(!Globals.waveInProgress):
		Globals.waveInProgress = true
		Globals.wave += 1
		wave = Globals.wave
		startNextWave.emit(wave)


func _on_sniper_button_down():
		if(money >= sniperPrice):
			Globals.money -= sniperPrice
			towerType = "sniper"
			towerplace.emit(towerType)
