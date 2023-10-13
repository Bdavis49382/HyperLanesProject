extends Node2D

var lane_name : String
var level = 1
var ships = 1
var speed = .001
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print($Path2D)
	for lane_path in $Path2D.get_children():
		# var lanePath = $Path2D.get_child(i)
		if lane_path.progress_ratio > 1 - speed:
			lane_path.progress_ratio = 0
		else:
			lane_path.progress_ratio += speed

func _draw():
	var par = get_parent()
	draw_line(par.lanes[par.most_recent_lane][0],par.lanes[par.most_recent_lane][1],Color(255,255,255),20)
	par.most_recent_lane += 1
