class PublicController < ApplicationController
  before_action :authenticate_account!, except: [:index]

  def index
  end

  def me
    @account = current_account
    @greeting = greeting
  end

  private
    def greeting
      case Time.zone.now.hour
      when 4..11 then 'Good morning.'
      when 12..17 then 'Good afternoon.'
      when 18..23 then 'Good evening.'
      else
        'I hope your day has gone well.'
    end
end
end
