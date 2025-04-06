class_name Door extends StaticBody3D

var heat: float = 0
var furnace
var locked: bool = true
@export var heat_needed: float = 32
@onready var animation = $AnimationPlayer


func _process(_delta: float) -> void:
	if not furnace:
		return
	heat = furnace.temp
	#print(heat)
	if  locked and heat >= heat_needed:
		animation.play("open")
		locked = false
