extends Control

signal index_changed

@onready var image_container = $image_container
var music_datas: Array[MusicData] = []:
    set(value):
        music_datas = value
        setup()

# レベル選択画面に映るとき使います
var disabled: bool = false:
    set(value):
        disabled = value
        hold_direction = 0
        update_visuals()

var original_position: Vector2

# セレクター用
var length: int = 320
var spacing: int = 150
var scaling: float = 1.5
var duration: float = 0.3
var current_index: int = 0

# キーリピート用
var hold_direction: int = 0 # -1(左), 0, 1(右)
var hold_timer: float = 0.0
var hold_delay: float = 0.2
var hold_interval: float = 0.1

func setup():
    for i in music_datas.size():
        var img_square = TextureRect.new()
        var image = Image.load_from_file(music_datas[i].texture_path)
        img_square.texture = ImageTexture.create_from_image(image)
        img_square.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
        img_square.stretch_mode = TextureRect.STRETCH_SCALE
        img_square.size = Vector2(length, length)
        img_square.pivot_offset = Vector2(length/2, length/2)
        img_square.position = Vector2(i * (spacing+length), 0)
        img_square.scale = Vector2(1, 1)
        image_container.add_child(img_square)

    update_visuals()

func _ready():
    original_position = position

func _process(delta):
    if hold_direction != 0:
        hold_timer += delta

    if hold_timer >= hold_delay:
        var repeat_time: float = hold_timer - hold_delay
        var repeat_count: int = int(repeat_time / hold_interval)

        if repeat_count > 0:
            hold_timer = hold_delay + fmod(repeat_time, hold_interval)
            if hold_direction == 1:
                change_index((current_index + 1) % music_datas.size())
            elif hold_direction == -1:
                change_index((current_index - 1 + music_datas.size()) % music_datas.size())

func _unhandled_input(event):
    if disabled:
        return

    if event.is_action_pressed("lane_3"):
        change_index((current_index + 1) % music_datas.size())
        hold_direction = 1
        hold_timer = 0

    elif event.is_action_pressed("lane_2"):
        change_index((current_index - 1 + music_datas.size()) % music_datas.size())
        hold_direction = -1
        hold_timer = 0

    elif event.is_action_released("lane_3") or event.is_action_released("lane_2"):
        hold_direction = 0

func change_index(new_index: int):
    if disabled or new_index == current_index:
        return

    current_index = new_index
    index_changed.emit()

    update_visuals()

func update_visuals():
    if music_datas.size() > 0:
        var selected_rect = image_container.get_child(current_index)
        var center_x: float = image_container.size.x / 2
        var offset: float = selected_rect.position.x - center_x + selected_rect.size.x / 2

        for i in image_container.get_child_count():
            var target = image_container.get_child(i)
            var is_selected = (i == current_index)

            # disabled かつ選択中なら非表示
            target.z_index = 1 if (disabled and is_selected) else 0
            #target.visible = not (disabled and is_selected)

            var scale = Vector2(scaling, scaling) if is_selected else Vector2(1, 1)
            var pos = target.position - Vector2(offset, 0)

            var tween = create_tween()
            tween.parallel().tween_property(target, "position", pos, duration).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
            tween.parallel().tween_property(target, "scale", scale, duration).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)

    var tween = create_tween()
    var target_pos = original_position + Vector2(-270, 0) if disabled else original_position
    tween.parallel().tween_property(self, "position", target_pos, 0.4)\
        .set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
