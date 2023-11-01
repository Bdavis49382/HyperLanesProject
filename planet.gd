extends Node2D

@export var planetName : String
@export var planetSize : int
@export var passengers = {}
var is_clicked = false 
var box_scale = Vector2(1,1)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$InfoBox.scale = box_scale

func _on_control_gui_input(event):
	if event.is_action('click') and event.button_mask == 1:
		$InfoBox.visible = !$InfoBox.visible
		is_clicked = $InfoBox.visible
