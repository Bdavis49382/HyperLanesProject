extends PathFollow2D


var planet1
var planet2
var passengers = {}
var at_planet2 = false
var at_planet1 = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func move(speed):
	if progress_ratio < .55 and progress_ratio > .5 and not at_planet2:
		drop_off(planet2)
		pick_up_all(planet2)
		at_planet2 = true
	elif progress_ratio > .55:
		at_planet2 = false
	if progress_ratio < .1 and not at_planet1:
		drop_off(planet1)
		pick_up_all(planet1)
		at_planet1 = true
	elif progress_ratio > .1:
		at_planet1 = false
	progress += speed

func pick_up_all(planet):
	var destinations = planet.passengers.keys()
	for destination in destinations:
		pick_up(planet,destination)

func pick_up(planet,destination):
	if destination in planet.passengers:
		var new_passengers = planet.take_passengers(destination)
		if destination in passengers:
			passengers[destination].append_array(new_passengers)
		else:
			passengers[destination] = new_passengers

func drop_off(planet):
	planet.accept_passengers(passengers)
	passengers.clear()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
