extends Node

static func update(id: int, x: int, y: int, pixel, pixels, ww, wh):
	var count = pixels.size()
	var below = calc_pos(x, y + 1, ww, wh)
	var below_left = calc_pos(x - 1, y + 1, ww, wh)
	var below_right = calc_pos(x + 1, y + 1, ww, wh)
	var left = calc_pos(x - 1, y, ww, wh)
	var right = calc_pos(x + 1, y, ww, wh)
	if below < count && (pixels[below] == null || pixels[below].type == 2):
		return swap_pixels(pixel, pixels[below], pixels, id, below)
	if left < count && (pixels[left] == null || pixels[left].type == 2):
		if below_left < count && (pixels[below_left] == null || pixels[below_left].type == 2):
			return swap_pixels(pixel, pixels[below_left], pixels, id, below_left)
	if right < count && (pixels[right] == null || pixels[right].type == 2):
		if below_right < count && (pixels[below_right] == null || pixels[below_right].type == 2):
			return swap_pixels(pixel, pixels[below_right], pixels, id, below_right)
	return null

static func swap_pixels(pixel, other_pixel, pixels, this_id, other_id):
	var other = pixels[other_id]
	pixels[this_id] = other_pixel
	pixels[other_id] = pixel
	return other

static func calc_pos(x: int, y: int, world_width, world_height):	
	return world_width * y + x
