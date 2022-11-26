extends Enemy
class_name SlowShooter

onready var fireTimer := $FireTimer

export var fireRate: float = 1.0

func _ready():
	setPriColor0(Color("ffeeeeee"))
	setPriColor1(Color("00eeeeee"))
	setSecColor0(Color("ffd3e1e7"))
	setSecColor1(Color("00d3e1e7"))
	setTertColor0(Color("ffaeb762"))
	setTertColor1(Color("00aeb762"))

func _process(delta):
	if fireTimer.is_stopped():
		fire()
		fireTimer.start(fireRate)
