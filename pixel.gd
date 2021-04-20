extends Node


onready var pixel_types = []

export var default_type:int = 0
export var pixels = []
export var size: int = 10
export var world_width: int = 10
export var world_height: int = 10
export var offset: Vector2 = Vector2(0, 0)

func _ready():
#	var p = new_pixel(1, 1, 1)
#	print(p)
#	for x in world_width:
#		for y in world_height:
#			pixels[world_width * y + x] = null
	pixels.resize(world_height * world_width)
	print(pixels.size())
	
	
#	pass

func resize(new_size: int):
	if (pixels.size() != new_size):
		pixels.resize(new_size)


func new_pixel(global_pos: Vector2, type: int):
	var pos = global_pos_to_pos(global_pos)
	if pos.x >= world_width:
		pos.x = world_width -1
	if pos.y >= world_height:
		pos.y = world_height -1
	var pixel = {
		"pos": {"x": int(pos.x), "y": int(pos.y)},
		"rect2": Rect2(Vector2(pos.x * size, pos.y * size), Vector2(size, size)),
		"type": type,
		"color": type
	}
	print(pixel.rect2)
#	pixels.append(pixel)

	var pos1d = world_width * int(pos.y) + int(pos.x)
	pixels[ pos1d ] = pixel
	print(pixels[ pos1d ])
	return pixel

func get_pixel(global_pos: Vector2):
	for p in pixels.size():
		var pixel = pixels[p]
		if pixel.pos == global_pos:
			return pixel
	return null

func global_pos_to_pos(pos: Vector2):
	return Vector2(round((pos.x / size) + offset.x), round((pos.y / size) + offset.y))
