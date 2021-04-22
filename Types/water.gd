extends Node

static func update(id: int, pixel, pixels, ww, wh):
	var count = pixels.size()
	var below = calc_pos(pixel.pos.x, pixel.pos.y + 1, ww, wh)
	var below_left = calc_pos(pixel.pos.x - 1, pixel.pos.y + 1, ww, wh)
	var below_right = calc_pos(pixel.pos.x + 1, pixel.pos.y + 1, ww, wh)
	var left = calc_pos(pixel.pos.x - 1, pixel.pos.y, ww, wh)
	var right = calc_pos(pixel.pos.x + 1, pixel.pos.y, ww, wh)
	if below < count && pixels[below] == null:
		pixels[id] = null
		pixel.pos.y += 1
		pixels[below] = pixel
	elif left < count && pixels[left] == null:
		pixels[id] = null
		if pixel.pos.x > 0:
			pixel.pos.x -= 1
		pixels[left] = pixel
	elif right < count && pixels[right] == null:
		pixels[id] = null
		if pixel.pos.x < ww - 1:
			pixel.pos.x += 1
		pixels[right] = pixel
	return null

static func react(id: int, pixel, pixels, ww, wh):
	var count = pixels.size()
	var above = -1
	var left = -1
	var right = -1
	var y = pixel.pos.y
	while y > 0:
		above = calc_pos(pixel.pos.x, y, ww, wh)
		left = calc_pos(pixel.pos.x - 1, y, ww, wh)
		right = calc_pos(pixel.pos.x + 1, y, ww, wh)
		if left < count && above > 0 && pixels[left] == null:
			pixel.pos.y = y
			if pixel.pos.x > 0:
				pixel.pos.x -= 1
			pixels[left] = pixel
			pixels[id] = null
			return
		elif right < count && above > 0 && pixels[right] == null:
			pixel.pos.y = y
			if pixel.pos.x < ww:
				pixel.pos.x += 1
			pixels[right] = pixel
			pixels[id] = null
			return
		elif above < count && above > 0 && pixels[above] == null:
			pixel.pos.y = y
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
