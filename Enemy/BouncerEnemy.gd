extends SlowShooter

export var horizontalSpeed := 50.0

var horizontalDirection: int = 1

func _ready():
	setPriColor0(Color("ffeeeeee"))
	setPriColor1(Color("00eeeeee"))
	setSecColor0(Color("ff62a4b7"))
	setSecColor1(Color("0062a4b7"))
	setTertColor0(Color("ffe7d3de"))
	setTertColor1(Color("00e7d3de"))

func _physics_process(delta):
	position.x += horizontalSpeed * delta * horizontalDirection
	var viewRect := get_viewport_rect()
	if position.x < viewRect.position.x or position.x > viewRect.end.x:
		horizontalDirection = -horizontalDirection
