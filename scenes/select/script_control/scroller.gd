extends Control

@onready var name_label = $name
@onready var delay_timer = $timer

var name_label2: Label = null  # 動的に複製したラベルを格納
var tween: Tween  # Tween の管理用
var scrolling: bool = false  # フラグ

var wait_time: float = 2.0  # スクロール開始前の待機時間（秒）
var scroll_speed: float = 0.01  # 1ピクセルあたりのスクロール時間
var scroll_gap: float = 80.0  # ← ラベル同士の間隔っj

@export var music_name: String = "":
    set(value):
        music_name = value
        if name_label2 != null:
            update_text()

func _ready():
    duplicate_label()
    update_text()

func duplicate_label():
    if name_label2:  # 既にあれば削除して作り直す
        name_label2.queue_free()
    name_label2 = name_label.duplicate() as Label
    name_label2.name = "name2"
    self.add_child(name_label2)

func update_text():
    name_label.text = music_name
    name_label2.text = music_name
    reset_position()

func delay_scroll():
    delay_timer.wait_time = wait_time
    delay_timer.one_shot = true
    delay_timer.start()

func start_scroll():
    if tween and tween.is_running() and scrolling:
        return  # 二重再生を防ぐ

    scrolling = true

    var start_pos: float = 0  # 初期位置（そのまま）
    var end_pos: float = -name_label.size.x - scroll_gap
    var end_pos_2: float = 0
    var scroll_distance: float = abs(end_pos - start_pos)
    var scroll_time: float = scroll_distance * scroll_speed

    tween = create_tween()  # tweenを新しく作成
    tween.tween_property(name_label, "position:x", end_pos, scroll_time).set_trans(Tween.TRANS_LINEAR)
    tween.parallel().tween_property(name_label2, "position:x", end_pos_2, scroll_time).set_trans(Tween.TRANS_LINEAR)
    tween.tween_callback(reset_position)

func stop_scroll():
    scrolling = false
    delay_timer.stop()
    if tween:
        tween.stop()
        tween.kill()

func _on_timer_timeout():
    if !scrolling:
        start_scroll()

func reset_position():
    stop_scroll()

    name_label.size.x = get_label_width(name_label)
    name_label.position.x = (self.size.x-name_label.size.x)/2
    name_label2.size.x = name_label.size.x
    name_label2.position.x = name_label.position.x + name_label.size.x + scroll_gap

    # サイズをチェックしてスクロール開始
    if name_label.size.x > self.size.x and !scrolling:
        name_label2.visible = true
        name_label.position.x = 0
        name_label2.size.x = name_label.size.x
        name_label2.position.x = name_label.position.x + name_label.size.x + scroll_gap
        delay_scroll()
    else:
        name_label2.visible = false

func get_label_width(label: Label) -> float:
    var font = label.get_theme_font("font")
    var font_size = label.get_theme_font_size("font_size")
    var string_size = font.get_string_size(label.text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size)
    return string_size.x
