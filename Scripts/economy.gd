extends Node

var money = 10000
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("../Camera/HUD/Money").text = "$" + str(money)
	var over_planets = check_planets_capacity()
	if len(over_planets):
		get_node("../Camera/HUD/Message").text = over_planets[0].planetName + " is over capacity! " + str(int($DeathTimer.time_left)) + " seconds left"
		if $DeathTimer.is_stopped():
			$DeathTimer.start()
	else:
		if not $DeathTimer.is_stopped():
			$DeathTimer.stop()
			get_node("../Camera/HUD/Message").text = "Everything is running smoothly"


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

func check_planets_capacity():
	var over_planets = []
	for planet in get_tree().get_nodes_in_group("planets"):
		if planet.get_num_passengers() > planet.planetSize * 10:
			over_planets.append(planet)	
	return over_planets

func refresh_passengers():
	for planet in get_tree().get_nodes_in_group("planets"):
		for passenger_group in planet.passengers.values():
			if len(passenger_group[0][2]) == 1:
				passenger_group[0][2] = find_route(passenger_group[0][2],passenger_group[0][0])
			for passenger in passenger_group:
				passenger[2] = passenger_group[0][2]

func calc_route_cost(planet1,planet2):
	var dist = calc_distance(planet1.position,planet2.position)
	return int(dist * 1.75)

func calc_distance(point1,point2):
	return sqrt((point2.x - point1.x)**2 + (point2.y - point1.y)**2)

func earn_income(amount):
	money += amount

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
	# If the passenger belongs at this planet, don't add it. Return false
	if passenger[0] == planet:
		return false
	if passenger[0].planetName in planet.passengers:
		planet.passengers[passenger[0].planetName].append(passenger)
	else:
		planet.passengers[passenger[0].planetName] = [passenger]
	return true

func _on_timer_timeout():
	var planets = get_tree().get_nodes_in_group("planets")
	# var planetNames = planets.map(func(planet):return planet.planetName)
	# add_passenger(rand_choice(planets), create_passenger(planets))
	create_passenger(planets)

func create_passenger(planets):
	var planet1 = 0
	var planet2 = 0
	while planet1 == planet2:
		planet1 = rand_choice(planets)
		planet2 = rand_choice(planets)
	if planet1 == planet2:
		print('error. Confused passenger')
	var route = [planet1]
	# A passenger is just an array of a name(destination) for the passenger, and the distance it is going to get there.
	route = find_route(route,planet2)
	add_passenger(planet1,[planet2,calc_distance(planet1.position,planet2.position),route])
	# return [planet2.planetName,calc_distance(planet1,planet2)]

func find_route(route,destination):
	route = find_route_recursive(route,0,destination)
	if route[-1] != destination:
		return [route[0]]
	else:
		return route

func find_route_recursive(route,index,destination):
	if route[-1] == destination:
		return route
	for planet in route[index].connected_planets:
		if planet in route:
			continue
		var new_route = []
		new_route.append_array(route)
		new_route.append(planet)

		new_route = find_route_recursive(new_route,index+1,destination)
		if new_route[-1] == destination:
			return new_route
	return route


func _on_death_timer_timeout():
	print('game over')
