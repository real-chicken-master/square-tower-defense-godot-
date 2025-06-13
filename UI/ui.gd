extends Control

const discShooterPrice = 50

const sniperPrice = 75

const sprayerPrice = 100

signal towerplace(TowerType)

signal startNextWave(waveNumber)

signal nextLine()

var towerType

var health

var money

var wave

@onready var healthLabel = $"topbar (Stats)/HBoxContainer/heartImage/health"

@onready var waveLabel = $"topbar (Stats)/HBoxContainer/wave"

@onready var moneyLabel = $"topbar (Stats)/HBoxContainer/$image/money"

var upgradeOpen = false

var upgradeTowerType

var upgradeTowerNode

var upgradeBranch1PriceMultiplyer = 1
var upgradeBranch1BasePrice = 30
var upgradeBranch1Price = upgradeBranch1BasePrice * upgradeBranch1PriceMultiplyer

var upgradeBranch2PriceMultiplyer = 1
var upgradeBranch2BasePrice = 40
var upgradeBranch2Price = upgradeBranch2BasePrice * upgradeBranch2PriceMultiplyer

var upgradeBranch3PriceMultiplyer = 1
var upgradeBranch3BasePrice = 50
var upgradeBranch3Price = upgradeBranch3BasePrice * upgradeBranch3PriceMultiplyer

var sellPrice = 0

var upgradecanopen = true

var upgradecanclose = true

func _ready():
	$"sidebar (towers)/HBoxContainer/speedButton".text = "x" + str(round(Engine.time_scale))
	$"sidebar (towers)/VBoxContainer(buttons)/discShooter".text = "discshooter
	$"+str(discShooterPrice)
	$"sidebar (towers)/VBoxContainer(buttons)/sniper".text = "sniper
	$"+str(sniperPrice)
	$"sidebar (towers)/VBoxContainer(buttons)/sprayer".text = "sprayer
	$"+str(sprayerPrice)
	$"sidebar (towers)/VBoxContainer(buttons)".visible = true
	$"sidebar (towers)/VBoxContainer(upgrades)".visible = false
	$tutorialTextBox.visible = false
	$areYouSure.visible = false


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
	updateStats()
	updateTowerButtons()
	if(upgradeOpen):
		if(is_instance_valid(upgradeTowerNode)):
			updateUpgradeButtons()

func updateStats():
	health = Globals.health
	money = Globals.money
	wave = Globals.wave
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
	if(Globals.Tutorial):
		startNextWave.emit(0)
		nextline()
	else:
		if(!Globals.waveInProgress):
			Globals.waveInProgress = true
			Globals.wave += 1
			wave = Globals.wave
			startNextWave.emit(wave)

func towerUpgrade(upgradeBranch1,upgradeBranch2,upgradeBranch3,tower,towerNode):
	if(upgradecanopen):
		if(Globals.Tutorial):
				nextline()
		upgradeOpen = true
		upgradeTowerType = tower
		upgradeTowerNode = towerNode
		upgradeBranch1PriceMultiplyer = upgradeBranch1
		upgradeBranch2PriceMultiplyer = upgradeBranch2
		upgradeBranch3PriceMultiplyer = upgradeBranch3
		updateUpgradeButtons()
		$"sidebar (towers)/VBoxContainer(buttons)".visible = false
		$"sidebar (towers)/VBoxContainer(upgrades)".visible = true

func updateUpgradeButtons():
		upgradeBranch1PriceMultiplyer = upgradeTowerNode.upgradeBranch1
		upgradeBranch1Price = upgradeBranch1BasePrice * upgradeBranch1PriceMultiplyer
		if(money >= upgradeBranch1Price):
			$"sidebar (towers)/VBoxContainer(upgrades)/upgradeBranch1".modulate = Color.GREEN
		else:
			$"sidebar (towers)/VBoxContainer(upgrades)/upgradeBranch1".modulate = Color.RED
		upgradeBranch2PriceMultiplyer = upgradeTowerNode.upgradeBranch2
		upgradeBranch2Price = upgradeBranch2BasePrice * upgradeBranch2PriceMultiplyer
		if(money >= upgradeBranch2Price):
			$"sidebar (towers)/VBoxContainer(upgrades)/upgradeBranch2".modulate = Color.GREEN
		else:
			$"sidebar (towers)/VBoxContainer(upgrades)/upgradeBranch2".modulate = Color.RED
		upgradeBranch3PriceMultiplyer = upgradeTowerNode.upgradeBranch3
		upgradeBranch3Price = upgradeBranch3BasePrice * upgradeBranch3PriceMultiplyer
		$"sidebar (towers)/VBoxContainer(upgrades)/Label".text = upgradeTowerType + " upgrades"
		$"sidebar (towers)/VBoxContainer(upgrades)/upgradeBranch1".text = "increase attack speed by 10%
		from " + str(snapped(upgradeTowerNode.attackSpeed, 0.01))+ "
		$" + str(upgradeBranch1Price)
		$"sidebar (towers)/VBoxContainer(upgrades)/upgradeBranch2".text = "increase damage by 50%
		from " + str(snapped(upgradeTowerNode.Damage , 0.01)) + "
		$" + str(upgradeBranch2Price)
		sellPrice = floor((upgradeTowerNode.price + (11*upgradeBranch1PriceMultiplyer) + (12*upgradeBranch2PriceMultiplyer) + (11*upgradeBranch3PriceMultiplyer)-34))
		$"sidebar (towers)/VBoxContainer(upgrades)/sell".text = "sell for $" + str(sellPrice)

func _on_upgrade_branch_1_button_down():
	if(Globals.Tutorial):
		nextline()
	if(money >= upgradeBranch1Price):
		upgradeTowerNode.attackSpeed *= 1.1
		upgradeTowerNode.upgradeBranch1 += 1
		Globals.money -= upgradeBranch1Price
		updateUpgradeButtons()


func _on_upgrade_branch_2_button_down():
	if(money >= upgradeBranch2Price):
		upgradeTowerNode.Damage *= 1.5
		upgradeTowerNode.upgradeBranch2 += 1
		Globals.money -= upgradeBranch2Price
	updateUpgradeButtons()

func upgradeStop():
	await get_tree().create_timer(0.01).timeout
	if(upgradecanclose):
		if(Globals.Tutorial):
			nextline()
		if(!anyButtonPressed()):
			upgradeOpen = false
			$"sidebar (towers)/VBoxContainer(buttons)".visible = true
			$"sidebar (towers)/VBoxContainer(upgrades)".visible = false
			upgradeTowerNode = null
			upgradeTowerType = null

func anyButtonPressed():
	var anybuttonpressed = false
	for button in get_tree().get_nodes_in_group("button"):
		if(button.button_pressed):
			anybuttonpressed = true
	return anybuttonpressed

func _on_quit_button_button_down():
	var comformation = await areYouSure()
	if comformation:
		get_tree().quit()


func _on_menu_button_button_down():
	TransitionLayer.changeScene("res://UI/title_screen.tscn")

func disable_buttons():
	for children in $"sidebar (towers)".get_children():
		for button in children.get_children():
			if(button.is_in_group("button")):
				button.set_disabled(true)

func enable_buttons():
	for children in $"sidebar (towers)".get_children():
		for button in children.get_children():
			if(button.is_in_group("button")):
				button.set_disabled(false)

func _on_speed_button_button_down():
	if(Globals.Tutorial):
		nextline()
	var speed = Globals.speed
	if(speed == 1):
		Globals.speed = 2
	if(speed == 2):
		Globals.speed = 1
	Engine.time_scale = Globals.speed
	$"sidebar (towers)/HBoxContainer/speedButton".text = "x" + str(round(Engine.time_scale))

func tutorial():
	var textLabel = $tutorialTextBox/tutorialText
	tutorialSetup(textLabel)
	await nextLine
	textLabel.text = "WELCOME TO SQUARE TOWER DEFENSE"
	await nextLine
	textLabel.text = "IN THE TOP LEFT CORNER YOU SHOULD SEE 
	A QUIT BUTTON AND MENU BUTTON"
	await nextLine
	textLabel.text = "THE QUIT BUTTON WILL CLOSE THE GAME"
	await nextLine
	textLabel.text = "THE MENU BUTTON WILL TAKE YOU BACK TO THE TITLE SCREEN"
	await nextLine
	textLabel.text = "AT THE TOP OF YOUR SCREEN YOU SHOULD SEE YOUR
	WAVE NUMBER, HEALTH AND MONEY"
	await nextLine
	textLabel.text = "THE WAVE NUMBER WILL INCREASE WHENEVER YOU CLICK THE START WAVE BUTTON"
	await nextLine
	textLabel.text = "YOUR HEALTH WILL DECREASE WHENEVER SQUARES REACH THE END OF THE PATH"
	await nextLine
	textLabel.text = "YOUR MONEY WILL INCREASE WHENEVER YOU DAMAGE A SQUARE"
	await nextLine
	textLabel.text = "ON YOUR LEFT YOU WILL SEE A LIST OF TOWERS,
	THE NEXT WAVE BUTTON AND THE SPEED MULTIPLYER BUTTON"
	await nextLine
	textLabel.text = "THE TOWER AT THE TOP IS CALLED THE DISC SHOOTER IT COSTS $50"
	await nextLine
	textLabel.text = "THE DISC SHOOTER IS THE CHEAPEST BUT MOST BASIC TOWER"
	await nextLine
	textLabel.text = "THE TOWER IN THE MIDDLE IS CALLED THE SNIPER AND COSTS $75"
	await nextLine
	textLabel.text = "THE SNIPER IS THE SLOWEST TOWER BUT DOES THE MOST DAMAGE 
	AND HAS UNLIMITED RANGE"
	await nextLine
	textLabel.text = "THE TOWER AT THE BOTTOM IS CALLED THE SPRAYER AND COSTS $100"
	await nextLine
	textLabel.text = "THE SPRAYER SHOOTS FOUR PROJECTILES AT ONCE"
	await nextLine
	textLabel.text = "THE NEXT WAVE BUTTON STARTS THE NEXT WAVE"
	await nextLine
	textLabel.text = "THE SPEED MULTIPLYER BUTTON SWITCH'S THE GAME SPEED BETWEEN
	TIMES 1 (x1) AND TIMES 2 (x2)"
	await nextLine
	textLabel.text = "LETS TRY PLACE A TOWER CLICK ON THE DISC SHOOTER TOWER (THE TOP TOWER)"
	$tutorialTextBox/nextLine.set_disabled(true)
	$"sidebar (towers)/VBoxContainer(buttons)/discShooter".set_disabled(false)
	await nextLine
	$"sidebar (towers)/VBoxContainer(buttons)/discShooter".set_disabled(true)
	textLabel.text = "NOW PLACE IT ANYWHERE THAT IS GREEN"
	await nextLine
	disable_buttons()
	upgradecanclose = false
	upgradecanopen = true
	textLabel.text = "GREAT NOW LETS TRY UPGRADE IT
	CLICK ON THE TOWER TO OPEN THE UPGRADE MENU"
	await nextLine
	textLabel.text = "NOW CLICK ON THE TOP UPGRADE (ATTACK SPEED) FOR $30"
	$"sidebar (towers)/VBoxContainer(upgrades)/upgradeBranch1".set_disabled(false)
	await nextLine
	$"sidebar (towers)/VBoxContainer(upgrades)/upgradeBranch1".set_disabled(true)
	await get_tree().create_timer(0.001).timeout
	upgradecanclose = true
	upgradecanopen = false
	textLabel.text = "GOOD JOB NOW CLICK ANYWHERE ON THE MAP 
	EXCEPT FOR THE TOWER TO CLOSE THE UPGRADE MENU"
	await nextLine
	upgradecanclose = false
	$"sidebar (towers)/HBoxContainer/start wave".set_disabled(false)
	textLabel.text = "NOW CLICK ON THE START WAVE BUTTON TO SEND SQUARES"
	await nextLine
	$"sidebar (towers)/HBoxContainer/start wave".set_disabled(true)
	textLabel.text = "WATCH YOUR TOWER DESTORY THE SQUARES"
	await get_tree().create_timer(0.001).timeout
	await Globals.waveEnd
	$"sidebar (towers)/HBoxContainer/speedButton".set_disabled(false)
	textLabel.text = "CLICK THE SPEED BUTTON TO CHANGE THE GAME SPEED TO x2"
	await nextLine
	$"sidebar (towers)/HBoxContainer/speedButton".set_disabled(true)
	$"sidebar (towers)/HBoxContainer/start wave".set_disabled(false)
	textLabel.text = "NOW CLICK THE START WAVE BUTTON AGAIN"
	await nextLine
	$"sidebar (towers)/HBoxContainer/start wave".set_disabled(true)
	textLabel.text = "SEE HOW THE SQUARES MOVE TWICE AS FAST AND AS WELL AS THE TOWERS"
	await get_tree().create_timer(0.001).timeout
	await Globals.waveEnd
	upgradecanopen = true
	textLabel.text = "NOW FINALY LETS SELL YOUR TOWER
	OPEN THE UPGRADE MENU AGAIN"
	await nextLine
	$"sidebar (towers)/VBoxContainer(upgrades)/sell".set_disabled(false)
	textLabel.text = "CLICK ON THE RED BUTTON AT THE BOTTOM"
	await nextLine
	upgradecanclose = true
	$areYouSure/no.set_disabled(true)
	$"sidebar (towers)/VBoxContainer(upgrades)/sell".set_disabled(true)
	textLabel.text = "YOU CAN EITHER CLICK YES IF YOU WANT TO SELL THAT TOWER 
	OR NO IF YOU DONT FOR THIS EXAMPLE CLICK YES"
	await nextLine
	upgradecanclose = false
	$tutorialTextBox/nextLine.set_disabled(false)
	textLabel.text = "CONGRATULATIONS YOU HAVE COMPLETED THE TUTORIAL CLICK NEXT TO 
	RETURN TO THE TITLE SCREEN"
	await nextLine
	await get_tree().create_timer(0.001).timeout
	TransitionLayer.changeScene("res://UI/title_screen.tscn")






func tutorialSetup(textLabel):
	upgradecanclose = false
	upgradecanopen = false
	Globals.Tutorial = true
	for children in $"sidebar (towers)".get_children():
		for button in children.get_children():
			if(button.is_in_group("button")):
				button.set_disabled(true)
	$tutorialTextBox.visible = true
	textLabel.text = "HELLO CLICK NEXT TO CONTINUE"


func _on_sell_button_down():
	if(Globals.Tutorial):
		nextLine.emit()
	var temp_time = Engine.time_scale
	var comformation = await areYouSure()
	if(comformation):
		Globals.money += sellPrice
		upgradeTowerNode.queue_free()
		Engine.time_scale = temp_time
		$areYouSure.visible = false
	else :
		Engine.time_scale = temp_time
		$areYouSure.visible = false
	

func areYouSure():
	$areYouSure/no.set_pressed(false)
	Engine.time_scale = 0
	$areYouSure.visible = true
	var buttonClicked = false
	while (!buttonClicked):
		if($areYouSure/yes.button_pressed):
			return true
		if($areYouSure/no.button_pressed):
			return false
		if(is_instance_valid(get_tree())):
			await get_tree().create_timer(0.0000001,true,false,true).timeout
	$areYouSure.visible = false



func _on_next_line_button_down():
	nextline()

func  nextline():
	nextLine.emit()

func towerPlace():
	disable_buttons()
	$"sidebar (towers)/VBoxContainer(buttons)/trash".enabled = true

func stopTowerPlace():
	enable_buttons()
	$"sidebar (towers)/VBoxContainer(buttons)/trash".enabled = false
