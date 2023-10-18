extends Node2D
signal create

var lane
@export var ship : PackedScene
var planet1
var planet2
var econ
# Called when the node enters the scene tree for the first time.
func _ready():
	econ = get_node("/root/Main/Economy")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if lane:
		$Ships.text = "Ships: " + str(lane.ships)
		$Level.text = "Level: " + str(lane.level)


func _on_create_pressed():
	if econ.buy_route(planet1,planet2):
		create.emit()

func created(lane_node):
	lane = lane_node
	remove_child($Create)
	$Ships.visible = true
	$Level.visible = true
	$AddShip.visible = true
	$Upgrade.visible = true



func _on_upgrade_pressed():
	if econ.buy_route(planet1,planet2):
		lane.speed *= 2
		lane.level += 1


func _on_add_ship_pressed():
	if econ.buy_ship(lane.ships):
		lane.ships += 1
		var new_ship = ship.instantiate()
		lane.get_child(0).add_child(new_ship)
