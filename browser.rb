require 'watir'

timer = 0
Watir.default_timeout = 60000
browser = Watir::Browser.new

browser.goto 'rosatom.hh.ru'

def click_buttons(browser, buttons)
  buttons.each do |button_text|
    browser.button(text: button_text).click
  end
end

while !(['4.001'].include? timer) do
  click_buttons(browser, %w[Работать Начать])

  %w[1 2 3 4 5].each do |int|
    browser.li(class: ['panel__item', "panel__item--#{int}"]).click
  end

  click_buttons(browser, %w[Вперёд Начать])

  sleep 2.850

  %w[61 62 63 59 58 64 53 60 52 55 86 51 85 50].each do |id|
    browser.element(tag_name: 'path', class: [id, 'circle']).fire_event :click
  end

  click_buttons(browser, %w[Вперёд Начать])

  images = browser.divs(class: 'reaktor__list__item__image')
  images.each(&:click)

  browser.button(text: 'Отправить').click

  timer = browser.p(class: 'final__rating').strong.text

  if !(['4.001'].include? timer)
    sleep 1
    browser.link(class: 'final__after__again').click
  end
end

browser.text_field(name: 'name').set('test')
browser.text_field(name: 'email').set('test@mail.com')
browser.input(type: 'submit').click