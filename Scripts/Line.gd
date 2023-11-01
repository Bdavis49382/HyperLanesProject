extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _draw():
	if get_parent().planet1:
		draw_line(get_parent().planet1.position,get_parent().planet2.position,Color(255,255,255),20)
	else:
		print('error drawing line')
