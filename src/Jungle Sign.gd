extends Sprite

const VELOCITY: float = -1.0
var g_texture_width: float = 0

func _ready():
	g_texture_width = texture.get_size().x * scale.x
	
func _process(delta: float) -> void:
	position.x += VELOCITY

	
