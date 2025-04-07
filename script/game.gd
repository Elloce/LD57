extends Node

signal item_created(item: Dictionary, position: Vector3)

const game: Dictionary = {
	items =
	{
		0: {burn_time = 20, max_heat = 32,max_radius = 24, color = "#353540"},
		1: {burn_time = 40, max_heat = 64,max_radius = 24*2, color = "#e39347"},
		2: {burn_time = 60, max_heat = 128,max_radius = 24*3, color = "#ca5954"}
	},
	recipe = {0: {}}
}
