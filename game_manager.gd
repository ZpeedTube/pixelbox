extends Sprite


onready var pixel_manager = $PixelManager
onready var label = $Label

#export (Texture) var texture

export var world_width: int = 400
export var world_height: int = 300
export var zoom: int = 10;
export var simulation_speed: int = 10
export var simulation_frame: int = 0

export var spawn_type: int = 1

var mouse_pressed = false

export var show_invisble = false

export var use_random_direction = false


func _ready():
	pixel_manager.world_width = world_width
	pixel_manager.world_height = world_height
#	print(pixel_manager.pixels)

func _input(event):
	if event.is_action("click"):
		mouse_pressed = !mouse_pressed
	if event.is_action_pressed("scroll_up"):
		spawn_type -= 1
		if spawn_type < 0:
			spawn_type = pixel_manager.pixel_types.size() - 1
	elif event.is_action_pressed("scroll_down"):
		spawn_type += 1
		if spawn_type >= pixel_manager.pixel_types.size():
			spawn_type = 0
#	if event.is_action_pressed("save"):
#		texture.get_data().save_png("res://pic_1.png")


func _process(delta):
	pixel_manager.size = zoom
	simulation_frame += 1
	if mouse_pressed:
		print("spawn")
		spawn_pixel(spawn_type)
#		var brush_size = 3
#		for xx in brush_size:
#			for yy in brush_size:
#				spawn_pixel(Vector2(xx * zoom,yy * zoom))
	if simulation_frame % simulation_speed == 0:
		update_pixels()
#		print(pixel_manager.pixels.size())
	label.text = "material: " + pixel_manager.pixel_name[spawn_type]
	
	var pixel = pixel_manager.get_pixel(get_global_mouse_position())
	if pixel:
		label.text += "\npixel: " + str(pixel)
#		label.text += "\ntype: " + str(pixel_manager.pixels[mouse_pixel_pos].id)

func _draw():
	if simulation_frame % simulation_speed == 0:
		var pixels = pixel_manager.pixels
#		for p in pixels.size():
		if pixels.size() == world_width * world_height:
			for y in range(0, world_height, 1):
				for x in range(0, world_width-1, 1):
					var p = world_width * y + x
					var pixel = pixels[p]
					if pixel:
						var rect2 = Rect2(Vector2(x*zoom, y*zoom), Vector2(zoom, zoom))
						var color =  pixel_manager.color_palette[pixel.color]
						draw_rect(rect2, color, true, 1, false)

func spawn_pixel(type: int = 1, offset: Vector2 = Vector2()):
	if (pixel_manager):
		pixel_manager.resize(world_height * world_width)
		var mouse_pos = get_global_mouse_position()
		pixel_manager.new_pixel(mouse_pos+offset, type)


func update_pixels():
	var pixels = pixel_manager.pixels
	if pixels.size() == world_width * world_height:
		var x_min = 0
		var x_max = world_width
		var direction = 1
		if use_random_direction:
			direction = randi() % 2
			if direction == 0:
				direction = -1
				x_min = world_width - 1
				x_max = 0
#		print(str(direction))
		for y in range(world_height - 1, -1, -1):
			for x in range(x_min, x_max, direction):
				var p = world_width * y + x
				var pixel = pixels[p]
				if pixel:
					var other_pixel = pixel_manager.get_pixel_type(pixel.type).update(p, x, y, pixel, pixels, world_width, world_height)
					if other_pixel:
						pixel_manager.get_pixel_type(other_pixel.type).react(p, x, y, other_pixel, pixels, world_width, world_height)
	update() # redraw with _draw
	
func calc_pos(x: int, y: int):
	if x >= world_width:
		x = world_width -1
	elif x < 0:
		x = 0
	if y >= world_height:
		y = world_height -1
	elif y < 0:
		y = 0
	return world_width * y + x
