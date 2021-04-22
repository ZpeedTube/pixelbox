extends Node

static func update(id: int, x: int, y: int, pixel, pixels, ww, wh):
	var count = pixels.size()
	var below = calc_pos(x, y + 1, ww, wh)
	var left = calc_pos(x - 1, y, ww, wh)
	var below_left = calc_pos(x - 1, y + 1, ww, wh)
	var right = calc_pos(x + 1, y, ww, wh)
	var below_right = calc_pos(x + 1, y + 1, ww, wh)
	# Check down
	if below < count && (pixels[below] == null || pixels[below].type == 2):
#		y += 1
		return swap_pixels(pixel, pixels[below], pixels, id, below)
	# Check left
	if left < count && (pixels[left] == null || pixels[left].type == 2):
		if below_left < count && (pixels[below_left] == null || pixels[below_left].type == 2):
			var left2 = calc_pos(x - 1, y + 1, ww, wh)
			var below_left2 = calc_pos(x - 1, y + 2, ww, wh)
			if left2 < count && (pixels[left2] == null || pixels[left2].type == 2):
				if below_left2 < count && (pixels[below_left2] == null || pixels[below_left2].type == 2):
					return swap_pixels(pixel, pixels[below_left2], pixels, id, below_left2)
#			else:
#				return swap_pixels(pixel, pixels[left2], pixels, id, below_left)
	# Check right
	if right < count && (pixels[right] == null || pixels[right].type == 2):
		if below_right < count && (pixels[below_right] == null || pixels[below_right].type == 2):
			var right2 = calc_pos(x + 1, y + 1, ww, wh)
			var below_right2 = calc_pos(x + 1, y + 2, ww, wh)
			if right2 < count && (pixels[right2] == null || pixels[right2].type == 2):
				if below_right2 < count && (pixels[below_right2] == null || pixels[below_right2].type == 2):
					return swap_pixels(pixel, pixels[below_right2], pixels, id, below_right2)
#			else:
#				return swap_pixels(pixel, pixels[right2], pixels, id, below_right)


static func swap_pixels(pixel, other_pixel, pixels, this_id, other_id):
	var other = pixels[other_id]
	pixels[this_id] = other_pixel
	pixels[other_id] = pixel
	return other

static func calc_pos(x: int, y: int, world_width, world_height):	
	return world_width * y + x
