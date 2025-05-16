extends Control

const discShooterPrice = 50

const sniperPrice = 75

const sprayerPrice = 100

signal towerplace(TowerType)

signal startNextWave(waveNumber)

var towerType

var health

var money

var wave

@onready var healthLabel = $"topbar (Stats)/HBoxContainer/heartImage/health"

@onready var waveLabel = $"topbar (Stats)/HBoxContainer/wave"

@onready var moneyLabel = $"topbar (Stats)/HBoxContainer/$image/money"

var upgradeTowerType

var upgradeTowerNode

func _ready():
	$"sidebar (towers)/VBoxContainer(buttons)/discShooter".text = "$"+str(discShooterPrice)
	$"sidebar (towers)/VBoxContainer(buttons)/sniper".text = "$"+str(sniperPrice)
	$"sidebar (towers)/VBoxContainer(buttons)/sprayer".text = "$"+str(sprayerPrice)
	$"sidebar (towers)/VBoxContainer(buttons)".visible = true
	$"sidebar (towers)/VBoxContainer(upgrades)".visible = false


func _on_disc_shooter_button_down():
	if(money >= discShooterPrice):
		Globals.money -= discShooterPrice
		towerType = "disc Shooter"
		towerplace.emit(towerType)

func _on_sniper_button_down():
		if(money >= sniperPrice):
			Globals.money -= sniperPrice
			towerType = "sniper"
			towerplace.emit(towerType)


func _on_sprayer_button_down():
		if(money >= sprayerPrice):
			Globals.money -= sprayerPrice
			towerType = "sprayer"
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
	waveLabel.text = "wave
		" + str(wave)

func updateTowerButtons():
	if(money >= discShooterPrice):
		$"sidebar (towers)/VBoxContainer(buttons)/discShooter".modulate = Color.WHITE
	else:
		$"sidebar (towers)/VBoxContainer(buttons)/discShooter".modulate = Color.RED
	if(money >= sniperPrice):
		$"sidebar (towers)/VBoxContainer(buttons)/sniper".modulate = Color.WHITE
	else:
		$"sidebar (towers)/VBoxContainer(buttons)/sniper".modulate = Color.RED
	if(money >= sprayerPrice):
		$"sidebar (towers)/VBoxContainer(buttons)/sprayer".modulate = Color.WHITE
	else:
		$"sidebar (towers)/VBoxContainer(buttons)/sprayer".modulate = Color.RED


func _on_start_wave_button_down():
	if(!Globals.waveInProgress):
		Globals.waveInProgress = true
		Globals.wave += 1
		wave = Globals.wave
		startNextWave.emit(wave)

func towerUpgrade(_upgradeBranch1,tower,towerNode):
	upgradeTowerType = tower
	upgradeTowerNode = towerNode
	updateUpgradeButtons()
	$"sidebar (towers)/VBoxContainer(buttons)".visible = false
	$"sidebar (towers)/VBoxContainer(upgrades)".visible = true

func updateUpgradeButtons():
		$"sidebar (towers)/VBoxContainer(upgrades)/Label".text = upgradeTowerType + " upgrades"
		$"sidebar (towers)/VBoxContainer(upgrades)/upgradeBranch1".text = "increase attack speed by 10% 
		from " + str(snapped(upgradeTowerNode.attackSpeed, 0.01))
		$"sidebar (towers)/VBoxContainer(upgrades)/upgradeBranch2".text = "increase attack damage by 10%
		 from " + str(snapped(upgradeTowerNode.Damage , 0.01))

func _on_upgrade_branch_1_button_down():
	upgradeTowerNode.attackSpeed *= 1.1
	updateUpgradeButtons()


func _on_upgrade_branch_2_button_down():
		upgradeTowerNode.Damage *= 1.1
		updateUpgradeButtons()

func upgradeStop():
	if(anybuttonpressed()):
		$"sidebar (towers)/VBoxContainer(buttons)".visible = true
		$"sidebar (towers)/VBoxContainer(upgrades)".visible = false
		upgradeTowerNode = null
		upgradeTowerType = null

func anybuttonpressed():
	for button in get_tree().get_nodes_in_group("button"):
		pass
	



