extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Name.text = get_parent().planetName
	var passengers_str = ""
	var passengers = get_parent().passengers
	var count = 0
	for place in passengers:
		var spaceNum = 10 - len(place)
		var space = ""
		for i in range(spaceNum):
			space += " "
		passengers_str += place + space + str(passengers[place]) + ("\n" if count % 2 == 1 else "       	")
		count += 1
	$Passengers.text = passengers_str
