extends Node2D

@export var planetName : String
@export var planetSize : int
var connected_planets = []
var passengers = {}
var is_clicked = false 
var box_scale = Vector2(1,1)
var econ
# Called when the node enters the scene tree for the first time.
func _ready():
	econ = get_node("/root/Main/Economy")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$InfoBox.scale = box_scale

func get_num_passengers():
	var total = 0
	for value in passengers.values():
		total += len(value)
	return total

func _on_control_gui_input(event):
	if event.is_action('click') and event.button_mask == 1:
		$InfoBox.visible = !$InfoBox.visible
		is_clicked = $InfoBox.visible

func take_passengers(destination):
	var leaving = passengers[destination]
	passengers.erase(destination)
	return leaving

func accept_passengers(new_passengers):
	for passenger_list in new_passengers.values():
		for passenger in passenger_list:	
			if not econ.add_passenger(self,passenger):
				econ.earn_income(floor(passenger[1]/40))

