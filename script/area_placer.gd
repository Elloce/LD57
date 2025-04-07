extends Area3D
const MAX_INSTANCES: int = 100

@export var instances: Node3D
@export var scene: PackedScene
@export var wait_time: float = 5
@export var heat_giver: Node3D

@onready var influence: CollisionShape3D = $CollisionShape3D
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D

var total_time: float
var can_place: bool = false


func _ready() -> void:
	body_entered.connect(_body_entered)
	body_exited.connect(_body_exited)


func _process(delta: float) -> void:
	check_instances_within_sphere()
	if not can_place:
		return
	if total_time >= wait_time and influence.shape.radius > 3:
		if instances.get_child_count() < MAX_INSTANCES:
			place_scenes_randomly()
		total_time = 0
	total_time += delta


func change_influnce(val: float) -> void:
	var rad: float = (influence.shape as SphereShape3D).radius
	mesh_instance_3d.mesh.radius = val
	influence.shape.radius = val


func place_scenes_randomly() -> void:
	# Get the size of the collision shape
	var collision_shape: CollisionShape3D = influence
	var shape: SphereShape3D = collision_shape.shape
	var area_size: Vector3 = Vector3(shape.radius * 2, shape.radius * 2, shape.radius * 2)

	# Generate a random position within the area
	var random_position: Vector3 = Vector3(
		randf_range(-area_size.x / 2, area_size.x / 2),
		-0.6,
		randf_range(-area_size.z / 2, area_size.z / 2)
	)

	# Instantiate the scene
	var instance = preload("res://grass.tscn").instantiate()
	instances.add_child(instance)

	# Set the position of the instance
	instance.position = random_position


func check_instances_within_sphere() -> void:
	var center: Vector3 = position  # Center of the sphere is the position of the Area3D
	var collision_shape: CollisionShape3D = $CollisionShape3D
	var shape: SphereShape3D = collision_shape.shape

	if shape is SphereShape3D:
		var radius: float = shape.radius
		for instance in instances.get_children():
			var distance: float = center.distance_to(instance.position)
			if distance > radius:
				instance.queue_free()


func _body_entered(body: Node3D) -> void:
	if body.is_in_group("heat_accepter"):
		body.furnace = heat_giver


func _body_exited(body: Node3D) -> void:
	if body.is_in_group("heat_accepter"):
		body.furnace = null
