extends Panel

@export var music_name: String = "":
    set(value):
        music_name = value
        $music_name.music_name = value

@export var composer: String = "":
    set(value):
        composer = value
        $composer.composer_name = value

@export var level_name: String = "":
    set(value):
        level_name = value
        $level_disp/level_name.text = value

@export var level_value: String = "":
    set(value):
        level_value = value
        $level_disp/level_value.text = value

@export var jacket_path: String = "":
    set(value):
        if value != "":
            jacket_path = value
            var image = Image.load_from_file(value)
            $jacket.texture = ImageTexture.create_from_image(image)
