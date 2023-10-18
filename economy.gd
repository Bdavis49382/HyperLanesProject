extends Node

var money = 10000
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("../Camera/HUD/Money").text = "$" + str(money)

func rand_choice(arr):
	return arr[randi() % arr.size()]

func buy_route(planet1,planet2):
	"""Returns false if unable to buy, true if buy was successful"""
	var cost = calc_route_cost(planet1,planet2)
	if cost > money:
		return false
	else:
		money -= cost
		return true

func calc_route_cost(planet1,planet2):
	var dist = calc_distance(planet1,planet2)
	return int(dist * 1.75)

func calc_distance(planet1,planet2):
	var pos1 = planet1.position
	var pos2 = planet2.position
	return sqrt((pos2.x - pos1.x)**2 + (pos2.y - pos1.y)**2)


func calc_ship_cost(ships):
	return 100 * ships**2 + 300

func buy_ship(ships):
	"""Returns false if unable to buy, true if buy worked"""
	var cost = calc_ship_cost(ships)
	if cost > money:
		return false
	else:
		money -= cost
		return true

func add_passenger(planet,passenger):
	# If the passenger belongs at this planet, don't add it
	if passenger[0] == planet.planetName:
		return
	if passenger[0] in planet.passengers:
		planet.passengers[passenger[0]].append(passenger)
	else:
		planet.passengers[passenger[0]] = [passenger]

func _on_timer_timeout():
	var planets = get_tree().get_nodes_in_group("planets")
	# var planetNames = planets.map(func(planet):return planet.planetName)
	add_passenger(rand_choice(planets), create_passenger(rand_choice(planets),rand_choice(planets)))

func create_passenger(planet1,planet2):
	# A passenger is just an array of a name(destination) for the passenger, and the distance it is going to get there.
	return [planet2.planetName,calc_distance(planet1,planet2)]


