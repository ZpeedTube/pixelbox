extends Node

static func update(id: int, pixel, pixels, ww, wh):
	var count = pixels.size()
	var below = calc_pos(pixel.pos.x, pixel.pos.y + 1, ww, wh)
	var below_left = calc_pos(pixel.pos.x - 1, pixel.pos.y + 1, ww, wh)
	var below_right = calc_pos(pixel.pos.x + 1, pixel.pos.y + 1, ww, wh)
	if below < count && (pixels[below] == null || pixels[below].type == 2):
		var other = pixels[below]
		pixels[id] = null
		pixel.pos.y += 1
		pixels[below] = pixel
		return other
	elif below_left < count && (pixels[below_left] == null || pixels[below_left].type == 2):
		var other = pixels[below_left]
		pixels[id] = null
		if pixel.pos.x > 0:
			pixel.pos.x -= 1
		pixel.pos.y += 1
		pixels[below_left] = pixel
		return other
	elif below_right < count && (pixels[below_right] == null || pixels[below_right].type == 2):
		var other = pixels[below_right]
		pixels[id] = null
		if pixel.pos.x < ww - 1:
			pixel.pos.x += 1
		pixel.pos.y = pixel.pos.y + 1
		pixels[below_right] = pixel
		return other
#	return pixels


static func calc_pos(x: int, y: int, world_width, world_height):	
	return world_width * y + x
