class UserDecorator
  attr_accessor :user

  def initialize(user)
    @user = user
  end

  delegate :screen_name,
           :name,
           :location,
           :followers_count,
           :statuses_count,
           to: :user

  def remembered?
    @remembered ||= Author.exists?(screen_name: screen_name)
  end

  def description
    h.link_twitter_text(@user.description)
  end

  def profile_image_url
    @user.profile_image_url_https
  end

  def author_path
    "/authors/#{ screen_name }"
  end

  def twitter_url
    "https://twitter.com/#{ screen_name }"
  end

  def at_screen_name
    "@#{ screen_name }"
  end

  def status_source
    @user.try(:status).try(:source).try(:html_safe)
  end

  def remember_button
    h.link_to "Remember #{ at_screen_name }", author_path,
      class: "btn #{ 'btn-success' if remembered? } ", remote: true,
      disabled: remembered? ? 'disabled' : false,
      onclick: "$(this).addClass('btn-success').attr('disabled', 'disabled')"
  end

  private

  def h
    ApplicationController.helpers
  end
end
