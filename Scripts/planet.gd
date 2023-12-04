extends Node2D

@export var planetName : String
@export var planetSize : int
var connected_planets = []
var passengers = {}
var is_clicked = false 
var box_scale = Vector2(1,1)
var econ
var old_color
var flash_on
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

func flash():
	old_color = self_modulate
	if $Flash.is_stopped():
		$Flash.start(1)
		$Flash.one_shot = false
		flash_on = false

func reset_color():
	get_node("Earth").self_modulate = old_color

func accept_passengers(new_passengers):
	for passenger_list in new_passengers.values():
		for passenger in passenger_list:	
			if not econ.add_passenger(self,passenger):
				econ.earn_income(floor(passenger[1]/40))



func _on_flash_timeout():
	if flash_on:
		reset_color()
		flash_on = false
	else:
		get_node("Earth").self_modulate = Color8(255,0,0)
		flash_on = true

