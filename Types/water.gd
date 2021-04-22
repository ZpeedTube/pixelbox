extends Node

static func update(id: int, x: int, y: int, pixel, pixels, ww, wh):
	var count = pixels.size()
	var below = calc_pos(x, y + 1, ww, wh)
	var below_left = calc_pos(x - 1, y + 1, ww, wh)
	var below_right = calc_pos(x + 1, y + 1, ww, wh)
	var left = calc_pos(x - 1, y, ww, wh)
	var right = calc_pos(x + 1, y, ww, wh)
#	if below < count && pixels[below] != null && pixels[below].type != 2:
#		if right < count && pixels[right] == null:
#			if below_right < count && pixels[below_right] == null:
#				pixels[id] = null
#				pixels[below_right] = pixel
#				return
#		if left < count && pixels[left] == null:
#			if below_left < count && pixels[below_left] == null:
#				pixels[id] = null
#				pixels[below_left] = pixel
#				return
	if below < count && pixels[below] == null:
		pixels[id] = null
		pixels[below] = pixel
		return null
	
	var r = randi() % 5
	match r:
		0, 4:
			if right < count && pixels[right] == null:
				pixels[id] = null
				pixels[right] = pixel
		1, 2:
			if left < count && pixels[left] == null:
				pixels[id] = null
				pixels[left] = pixel
	return null

static func react(id: int, x: int, y: int, pixel, pixels, ww, wh):
	var count = pixels.size()
	var above = -1
	var left = -1
	var right = -1
	while y > 0:
		above = calc_pos(x, y, ww, wh)
		left = calc_pos(x - 1, y, ww, wh)
		right = calc_pos(x + 1, y, ww, wh)
		if left < count && above > 0 && pixels[left] == null:
			pixels[left] = pixel
			pixels[id] = null
			return
		elif right < count && above > 0 && pixels[right] == null:
			pixels[right] = pixel
			pixels[id] = null
			return
		elif above < count && above > 0 && pixels[above] == null:
			pixels[above] = pixel
			pixels[id] = null
			return
		y -= 1

static func swap_pixels(pixel, other_pixel, pixels, this_id, other_id):
	var other = pixels[other_id]
	pixels[this_id] = other_pixel
	pixels[other_id] = pixel
	return other

static func calc_pos(x: int, y: int, world_width, world_height):	
	return world_width * y + x
