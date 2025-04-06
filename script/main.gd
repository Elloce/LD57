extends Node3D

@onready var player: Player = $Player
@onready var items: Node3D = $Items


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.dropped_item.connect(_dropped_item)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()


func _dropped_item(item: Item) -> void:
	var it: Item = item
	items.add_child(it)
	#it.sleeping=false
	it.global_position = player.hands.global_position
	it.freeze = false
