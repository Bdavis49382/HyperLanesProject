extends Node2D

@export var lane_box: PackedScene
@export var lane: PackedScene
var lanes = {}
var most_recent_lane = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var clicked_planets = get_tree().get_nodes_in_group("planets").filter(func(planet):return planet.is_clicked)
	for planet in clicked_planets:
		planet.box_scale = Vector2(1,1) / $Camera.zoom
	if (len(clicked_planets) == 2):
		var key_string = str(clicked_planets[0].planetName) + '-' + str(clicked_planets[1].planetName)
		if key_string not in lanes:
			lanes[key_string] = lane.instantiate()
			lanes[key_string].get_child(0).get_child(1).text = key_string
			var midpoint = Vector2.ZERO
			midpoint.x = (clicked_planets[0].position.x + clicked_planets[1].position.x)/2
			midpoint.y = (clicked_planets[0].position.y + clicked_planets[1].position.y)/2
			lanes[key_string].get_node("LaneBox").position = midpoint	
			lanes[key_string].planet1 = clicked_planets[0]
			lanes[key_string].planet2 = clicked_planets[1]
			add_child(lanes[key_string])
		else:
			lanes[key_string].get_node("LaneBox").visible = true
			if $Camera.zoom != Vector2.ZERO:
				lanes[key_string].get_node("LaneBox").scale = Vector2(1,1) / $Camera.zoom
	else:
		for key_string in lanes:
			lanes[key_string].get_node("LaneBox").visible = false
