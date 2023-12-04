extends AudioStreamPlayer

@export var streams : Array[AudioStream]
# Called when the node enters the scene tree for the first time.
func _ready():
	_start_song()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _start_song():
	stream = streams[randi_range(0,len(streams)-1)]
	playing = true
	$SongTimer.start(stream.get_length())

func _on_song_timer_timeout():
	_start_song()
