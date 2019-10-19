class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :not_enrolled_yet, only: [:show]
  def show
  end

  private

  def not_enrolled_yet
    if !current_user.enrolled_in?(current_lesson.section.course)
      redirect_to course_path(current_lesson.section.course), alert: 'You must enroll before accessing the lessons.'
    end
  end

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
end
