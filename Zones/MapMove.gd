extends Area2D

export(PackedScene) var desitnation_stage

func _on_MapMove_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.get_name() == "Player":
		get_tree().change_scene_to(desitnation_stage)
