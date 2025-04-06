class_name Item extends RigidBody3D

var item_name: String = "item"
var item_burn_time: float = 50.0


func _to_string() -> String:
	return "%s" % [item_name]
