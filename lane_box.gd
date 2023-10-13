extends Node2D
signal create

var lane
@export var ship : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if lane:
		$Ships.text = "Ships: " + str(lane.ships)
		$Level.text = "Level: " + str(lane.level)


func _on_create_pressed():
	create.emit()

func created(lane_node):
	lane = lane_node
	remove_child($Create)
	$Ships.visible = true
	$Level.visible = true
	$AddShip.visible = true
	$Upgrade.visible = true



func _on_upgrade_pressed():
	lane.speed *= 2
	lane.level += 1


func _on_add_ship_pressed():
	lane.ships += 1
	var new_ship = ship.instantiate()
	lane.get_child(0).add_child(new_ship)
