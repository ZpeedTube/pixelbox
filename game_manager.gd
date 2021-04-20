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

export var color_enum = [
	Color(0.0, 0.0, 0.0, 0.0),
	Color(0.5, 0.8, 0.1, 1.0),
	Color(0.2, 0.2, 0.9, 1.0),
	Color(0.21, 0.04, 0.04, 1.0),
	Color(0.38, 0.45, 0.39, 1.0)
]

var mouse_pressed = false


func _ready():
	pixel_manager.world_width = world_width
	pixel_manager.world_height = world_height
	print(pixel_manager.pixels)

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

func _draw():
	var pixels = pixel_manager.pixels
	for p in pixels.size():
		var pixel = pixels[p]
		if pixel:
			var rect2 = Rect2(Vector2(pixel.pos.x*zoom, pixel.pos.y*zoom), Vector2(zoom, zoom))
			draw_rect(rect2, color_enum[pixel.color], true, 1, false)

func spawn_pixel(type: int = 1, offset: Vector2 = Vector2()):
	if (pixel_manager):
		pixel_manager.resize(world_height * world_width)
		var mouse_pos = get_global_mouse_position()
#			print("add ", mouse_pos.x / zoom)
		pixel_manager.new_pixel(mouse_pos+offset, type)


func update_pixels():
	var pixels = pixel_manager.pixels
	var new_pixels = []
	new_pixels.resize(pixels.size())
	for p in range(pixels.size()-1, 0, -1):
		var pixel = pixels[p]
		if pixel:
			var other_pixel = pixel_manager.get_pixel_type(pixel.type).update(p, pixel, pixels, world_width, world_height)
			if other_pixel:
				pixel_manager.get_pixel_type(other_pixel.type).react(p, other_pixel, pixels, world_width, world_height)
	update() # redraw with _draw
	
func calc_pos(x: int, y: int):
	if x >= world_width:
		x = world_width -1
	if y >= world_height:
		y = world_height -1
	return world_width * y + x
