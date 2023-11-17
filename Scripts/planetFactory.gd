extends Node
signal planet_created

@export var Planet : PackedScene
var zones = [[0,0]]
var planet_names = ["Mercury","Venus","Mars","Jupiter","Saturn","Uranus","Neptune","Ibreon XII","Tulia","Zexade","Iroria 7X","Udarvis","Droutera 4IX","Igolla W8","Estrade","Drehiri","Cothorix","Xelarvis","Druinov","Denkerth","Rion","Merth","Leron","Xochilia VS","Iketer","Brolnaistea 2OA","Nesippe","Ikadus","Kuriuq","Gephahines X","Davinda","Zaphus","Lonadus R2","Uchilles","Taxore"]
var current_zone = 0
var planets_in_zone = 2
var econ
# Called when the node enters the scene tree for the first time.
func _ready():
	econ = get_node("/root/Main/Economy")
	create_planet("Earth",[0,0])
	create_random_planet(zones[0])
	create_random_planet(zones[0])

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_pos_in_zone(zone,range):
	var valid = false
	var x = 0
	var y = 0
	while not valid:
		valid = true
		x = randi_range(zone[0]-range,zone[0]+range)	
		y = randi_range(zone[1]-range,zone[1]+range)	
		for planet in get_tree().get_nodes_in_group("planets"):
			if econ.calc_distance(planet.position,Vector2(x,y)) < 400:
				valid = false
	return [x,y]

func create_random_planet(zone):
	var pos = get_pos_in_zone(zone,500)
	var planet_name = econ.rand_choice(planet_names)
	planet_names.remove_at(planet_names.find(planet_name))
	# print("created",planet_name, "in", current_zone, ". There are %s in this zone" % planets_in_zone)
	create_planet(planet_name,pos)


func create_planet(planet_name,position):
			
	var new_planet = Planet.instantiate()
	new_planet.planetName = planet_name
	new_planet.planetSize = 2
	var r = randi_range(0,255)
	var g = randi_range(0,255)
	var b = randi_range(0,255)
	
	new_planet.get_node("Earth").self_modulate = Color8(r,g,b,255)
	
	new_planet.position = Vector2(position[0],position[1])
	new_planet.add_to_group("planets")
	add_child(new_planet)
	planet_created.emit(planet_name)

func create_zone():
	var prev_zone = zones[current_zone]
	var valid = false
	var zone = []
	while not valid:
		valid = true
		var dist = randi_range(1000,2500)
		var dist_x = randi_range(0,dist)
		var dist_y = dist - dist_x
		if randi_range(0,100) < 50:
			dist_x *= -1
		if randi_range(0,100) < 50:
			dist_y *= -1
		zone = [prev_zone[0] + dist_x,prev_zone[1] + dist_y]
		for planet in get_tree().get_nodes_in_group("planets"):
			if econ.calc_distance(planet.position,Vector2(zone[0],zone[1])) < 700:
				valid = false
	zones.append(zone)

func _on_planet_spawn_timer_timeout():
	if current_zone < len(zones) and len(planet_names) > 0:
		planets_in_zone += 1
		create_random_planet(zones[current_zone])
		if planets_in_zone >= 4:
			planets_in_zone = 0
			create_zone()
			current_zone += 1
