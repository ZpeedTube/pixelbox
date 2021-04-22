extends Node

onready var pixel_types = [
	null,
	load("res://Types/sand.gd"),
	load("res://Types/water.gd"),
	load("res://Types/dirt.gd"),
	load("res://Types/wood.gd")
]

export var pixel_name = [
	"empty",
	"sand",
	"water",
	"dirt",
	"wood"
]

export var color_palette = [
	Color(0.0, 0.0, 0.0, 0.0),
	Color(0.5, 0.8, 0.1, 1.0),
	Color(0.2, 0.2, 0.9, 1.0),
	Color(0.21, 0.04, 0.04, 1.0),
	Color(0.38, 0.45, 0.39, 1.0)
]

export var default_type:int = 0
export var pixels = []
export var size: int = 10
export var world_width: int = 10
export var world_height: int = 10
export var offset: Vector2 = Vector2(0, 0)

func _ready():
	pixels.resize(world_height * world_width)
	print(pixels.size())
	print(pixel_types)

func resize(new_size: int):
	if (pixels.size() != new_size):
		pixels.resize(new_size)


func new_pixel(global_pos: Vector2, type: int):
	var pos = global_pos_to_pos(global_pos)
	if pos.x >= world_width:
		pos.x = world_width -1
	if pos.y >= world_height:
		pos.y = world_height -1
	if type == 0:
		var pos1d = world_width * int(pos.y) + int(pos.x)
		pixels[ pos1d ] = null
		return null
		
	var pixel = {
		"type": type,
		"color": type,
		"velocity": -1,
		"life": null
	}

	var pos1d = world_width * int(pos.y) + int(pos.x)
	pixels[ pos1d ] = pixel
	print(pixels[ pos1d ])
	return pixel

func get_pixel(global_pos: Vector2):
	var pos = global_pos_to_pos(global_pos)
	var pos1d = world_width * int(pos.y) + int(pos.x)
	if pos1d >= 0 && pos1d < pixels.size():
		return pixels[pos1d]
	else:
		return null

func get_pixel_type(type: int):
	return pixel_types[type]


func global_pos_to_pos(pos: Vector2):
	return Vector2(round((pos.x / size) + offset.x), round((pos.y / size) + offset.y))

