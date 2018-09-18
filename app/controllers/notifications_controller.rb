# frozen_string_literal: true

# Notifications
class NotificationsController < ApplicationResourceController
  def destroy
    @noti = Notification.find(params[:id])
    link = @noti.link
    @noti.destroy
    redirect_to link
  end

  def show
    @noti = Notification.find(params[:id])
    link = @noti.link
    @noti.destroy
    redirect_to link
  end
end
