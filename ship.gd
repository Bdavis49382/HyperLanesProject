extends PathFollow2D
signal planet1
signal planet2


var passengers = {}
var at_planet2 = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func move(speed):
	if progress_ratio < .55 and progress_ratio > .5 and not at_planet2:
		planet2.emit()
		at_planet2 = true
	elif progress_ratio > .55:
		at_planet2 = false
	if progress_ratio > 1:
		progress_ratio = 0
		planet1.emit()
	else:
		progress += speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
