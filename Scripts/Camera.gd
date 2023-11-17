extends Camera2D


var movement_map = {
	"camera_left": [-1, 0],
	"camera_right": [1,0],
	"camera_down": [0,1],
	"camera_up": [0,-1],
}
var zoom_map = {
	"zoom_in": [1,1],
	"zoom_out": [-1,-1]
}
var _speed = 450
var _zoom_speed = .5
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	var zoom_velocity = Vector2.ZERO
	for key in movement_map:
		if Input.is_action_pressed(key):
			velocity.x += movement_map[key][0]
			velocity.y += movement_map[key][1]
	position += velocity * delta * _speed
	for key in zoom_map:
		if Input.is_action_pressed(key):
			zoom_velocity.x += zoom_map[key][0]
			zoom_velocity.y += zoom_map[key][1]
	zoom += zoom_velocity * delta * _zoom_speed
	zoom = zoom.clamp(Vector2(.1,.1),Vector2(3,3))


func _on_planet_factory_planet_created():
	pass # Replace with function body.
