extends Sprite


const VELOCITY: float = -1.0
var g_texture_width: float = 0



	
func _process(delta: float) -> void:
	position.x += VELOCITY
	_attempt_reposition()
	
func _attempt_reposition() -> void:
	if position.x < -g_texture_width:
		position.x += 2 * g_texture_width


