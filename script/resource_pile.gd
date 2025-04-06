class_name ResourcePile extends StaticBody3D

enum PileResource { ONE }

@export var pile_resource: PileResource = PileResource.ONE

var doing = false
var worktime: float = 2
var total_time: float = 0
var item = preload("res://item.tscn")
@onready var particles: GPUParticles3D = $GPUParticles3D


func _process(delta: float) -> void:
	if not doing:
		total_time = 0
		particles.emitting = false
		return
	print(total_time)
	if total_time >= worktime:
		place_item()
		total_time = 0

	total_time += delta


func place_item() -> void:
	var it = item.instantiate()
	add_child(it)
	it.global_position.y += 2
	it.freeze = false


func do_action(doing: bool = true) -> void:
	self.doing = doing
	if self.doing:
		particles.emitting = true
