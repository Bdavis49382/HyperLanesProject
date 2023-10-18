extends Node2D

var lane_name : String
var level = 1
var ships = 1
var speed = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for ship in $Path2D.get_children():
		ship.move(speed)

func _draw():
	var par = get_parent()
	draw_line(par.lanes[par.most_recent_lane][0],par.lanes[par.most_recent_lane][1],Color(255,255,255),20)
	par.most_recent_lane += 1
