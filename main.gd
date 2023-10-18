extends Node2D

@export var lane_box: PackedScene
@export var lane: PackedScene
var lane_boxes = {}
var lanes = []
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
		if key_string not in lane_boxes:
			lane_boxes[key_string] = lane_box.instantiate()
			lane_boxes[key_string].get_child(1).text = key_string
			var midpoint = Vector2.ZERO
			midpoint.x = (clicked_planets[0].position.x + clicked_planets[1].position.x)/2
			midpoint.y = (clicked_planets[0].position.y + clicked_planets[1].position.y)/2
			lane_boxes[key_string].position = midpoint	
			lane_boxes[key_string].planet1 = clicked_planets[0]
			lane_boxes[key_string].planet2 = clicked_planets[1]
			add_child(lane_boxes[key_string])
			lane_boxes[key_string].connect("create",self._on_create)
		else:
			lane_boxes[key_string].visible = true
			if $Camera.zoom != Vector2.ZERO:
				lane_boxes[key_string].scale = Vector2(1,1) / $Camera.zoom
	else:
		for key_string in lane_boxes:
			lane_boxes[key_string].visible = false


func _on_create():
	var clicked_planets = get_tree().get_nodes_in_group("planets").filter(func(planet):return planet.is_clicked)
	lanes.append([clicked_planets[0].position,clicked_planets[1].position])
	var this_lane = lane.instantiate()
	this_lane.lane_name = clicked_planets[0].planetName + "-" + clicked_planets[1].planetName
	lane_boxes[this_lane.lane_name].created(this_lane)
	var curve = Curve2D.new()
	curve.add_point(clicked_planets[0].position)
	curve.add_point(clicked_planets[1].position)
	curve.add_point(clicked_planets[0].position)
	this_lane.get_child(0).set_curve(curve)
	add_child(this_lane)
