pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
_c = {
  up = 1,
  down = 2,
  file_name = "now.txt"
}

button = {
  s = _c.up,
  x = 56,
  y = 56,
  press_time = 0,
  cooldown = 1.25
}

mouse = {
  x = 0,
  y = 0
}

debug = false

function _init()
  -- enable mouse
  poke(0x5f2d, 1)
  
  local b = button
  b.box = {
    x_1 = b.x-4,
    y_1 = b.y-4,
    x_2 = b.x+11,
    y_2 = b.y+10,
  }
end

function _update60()
  cls(13)

  ?"press button!",36,44,0 

  if button.s == _c.down then
    local now = time()
    if now - button.press_time
    > button.cooldown then
      button.s = _c.up
    end
  end

  local m = mouse
  local b = button.box

  -- get mouse x & y
  m.x = stat(32)-1
  m.y = stat(33)-1
  
  local in_box =
    m.x >= b.x_1-1 and
    m.y >= b.y_1 and
    m.x < b.x_2 and
    m.y <= b.y_2
  
  local pressed =
    stat(34) == 1 or
    stat(34) == 2
  
  local c = 1
  if in_box then
    c = 2
    if pressed and
    button.s == _c.up then
      c = 7
      button.s = _c.down
      button.press_time = time()
      utils.update_file()
    end
  end

  if debug then
    rect(
      b.x_1,
      b.y_1,
      b.x_2,
      b.y_2,
      c
    )
  end
  
  -- draw button
  spr(
    button.s,
    button.x,
    button.y
  )
  
  -- draw mouse
  spr(0, m.x, m.y)
end

utils = {}
function utils.update_file()
  minute = tostr(stat(94))
  second = tostr(stat(95))
  now = minute.."-"..second
  printh(
    now,
    _c.file_name,
    true
  )
end

__gfx__
00100000088888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01710000888888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01771000888888880888888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01777100788888888888888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01777710277778828888888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01771100222222227888888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00117100022222200777788000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
