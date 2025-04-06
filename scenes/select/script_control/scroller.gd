extends Control

@onready var name_label = $name
@onready var delay_timer = $timer

var tween: Tween  # Tween の管理用
var scrolling: bool = false  # フラグ
var wait_time = 2.0  # スクロール開始前の待機時間（秒）
var scroll_speed = 0.01  # 1ピクセルあたりのスクロール時間

@export var music_name: String = "":
    set(value):
        music_name = value
        update_text()

func _ready():
    await get_tree().process_frame  # サイズ計算のために1フレーム待つ
    update_text()

func update_text():
    name_label.text = music_name
    reset_position()

func delay_scroll():
    delay_timer.wait_time = wait_time
    delay_timer.one_shot = true
    delay_timer.start()

func start_scroll():
    if tween and tween.is_running() and scrolling:
        return  # 二重再生を防ぐ

    scrolling = true

    var start_pos = 0  # 初期位置（そのまま）
    var end_pos = -name_label.size.x
    var scroll_distance = abs(end_pos - start_pos)
    var scroll_time = scroll_distance * scroll_speed

    tween = create_tween()  # tweenを新しく作成
    tween.tween_property(name_label, "position:x", end_pos, scroll_time).set_trans(Tween.TRANS_LINEAR)
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

    var font: Font = name_label.get_theme_font("font")
    var font_size: int = name_label.get_theme_font_size("font_size")
    var string_size = font.get_string_size(name_label.text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size)
    name_label.size.x = string_size.x
    name_label.position.x = (self.size.x-name_label.size.x)/2

    # サイズをチェックしてスクロール開始
    if name_label.size.x > self.size.x and !scrolling:
        name_label.position.x = 0
        delay_scroll()
