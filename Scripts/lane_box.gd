extends Node2D
signal create
signal upgrade
signal add_ship

@export var ship : PackedScene
var econ
var ships = 0
var level = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	econ = get_node("/root/Main/Economy")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Ships.visible:
		$Ships.text = "Ships: " + str(ships)
		$Level.text = "Level: " + str(level)


func _on_create_pressed():
	if econ.buy_route(get_parent().planet1,get_parent().planet2):
		create.emit()
		remove_child($Create)
		$Ships.visible = true
		$Level.visible = true
		$AddShip.visible = true
		$Upgrade.visible = true

func _on_upgrade_pressed():
	upgrade.emit()

func _on_add_ship_pressed():
	add_ship.emit()
