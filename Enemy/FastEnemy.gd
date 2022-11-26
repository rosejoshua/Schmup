extends Enemy

export var rotationRate := 20

func _process(delta):
	rotate(deg2rad(rotationRate) * delta)

func _ready():
	setPriColor0(Color("ffd3e1e7"))
	setPriColor1(Color("00d3e1e7"))
	setSecColor0(Color("ffbf5237"))
	setSecColor1(Color("00bf5237"))
	setTertColor0(Color("ff4a3c55"))
	setTertColor1(Color("004a3c55"))
