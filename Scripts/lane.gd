extends Node2D

var lane_name : String
var level = 1
var ships = 1
# var speed = 2
var planet1
var planet2
var box : PackedScene
@export var ship_scene : PackedScene
@export var line : PackedScene
var econ
# Called when the node enters the scene tree for the first time.
func _ready():
	econ = get_node("/root/Main/Economy")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for ship in $Path2D.get_children():
		ship.move(level*2)
	$LaneBox.ships = ships
	$LaneBox.level = level



func _on_lane_box_create():
	planet1.connected_planets.append(planet2)
	planet2.connected_planets.append(planet1)
	var curve = Curve2D.new()
	curve.add_point(planet1.position)
	curve.add_point(planet2.position)
	curve.add_point(planet1.position)
	$Path2D.set_curve(curve)
	econ.refresh_passengers()
	add_ship()
	add_child(line.instantiate())

func add_ship():
	var new_ship = ship_scene.instantiate()
	new_ship.planet1 = planet1
	new_ship.planet2 = planet2
	$Path2D.add_child(new_ship)


func _on_lane_box_add_ship():
	if econ.buy_ship(ships):
		ships += 1
		add_ship()


func _on_lane_box_upgrade():
	if econ.buy_route(planet1,planet2):
		# speed *= 2
		level += 1
