extends PathFollow2D


var planet1
var planet2
var passengers = {}
var capacity = 15
var red = false
var at_planet2 = false
var at_planet1 = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	z_index = 100

func get_num_passengers():
	var total = 0
	for key in passengers:
		total += len(passengers[key])
	return total

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
		if len(planet.passengers[destination][0][2]) > 1 and planet.passengers[destination][0][2][1] in [planet2,planet1] and get_num_passengers() < capacity:
			pick_up(planet,destination)

func pick_up(planet,destination):
	if destination in planet.passengers:
		var new_passengers = planet.take_passengers(destination)
		if destination in passengers:
			passengers[destination].append_array(new_passengers)
		else:
			passengers[destination] = new_passengers

func drop_off(planet):
	# Remove the previous planet from the passenger's routes
	for passenger_group in passengers.values():
		passenger_group[0][2].pop_front()
	planet.accept_passengers(passengers)
	passengers.clear()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Keep the sprite pointed the right way.
	if progress_ratio < .55:
		$Sprite2D.look_at(planet1.position)
	else:
		$Sprite2D.look_at(planet2.position)
	
	# Update progress bar showing capacity
	var percentage = get_num_passengers() * 100 / capacity
	$ProgressBar.value = percentage
	if percentage > 90 and not red:
		red = true
	if red and percentage < 90:
		red = false
		$ProgressBar.add_theme_color_override("font_color",Color(1,1,1))

	if red:
		$ProgressBar.add_theme_color_override("font_color",Color(1,0,0))
	
	
	# $ProgressBar.theme.font_color = Color(1,0,0)



