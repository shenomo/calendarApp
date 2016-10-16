class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @meetings = current_user.meetings
  end
  
  def all_users_meetings
    @meetings = Meeting.all
  end

  def show
  end

  def new
    @meeting = Meeting.new
  end

  def edit
  end


  def show_calendar
    
    @meetings = current_user.meetings
    @finalMeetings = Array.new

    @meetings.each do |s|
      @finalMeetings.push(s)  
    
      if s.rule == "weekly"
        interval = s.interval
        count = 7
        while interval != 0
          newDate = s.dup
          newDate.start_time += count.days
          count+=7
          @finalMeetings.push(newDate)
          interval -= 1
        end
      end
      if s.rule == "daily"
        interval = s.interval
        count = 1
        while interval != 0
          newDate = s.dup
          newDate.start_time += count.days
          count+=1
          @finalMeetings.push(newDate)
          interval -= 1
        end
      end
      if s.rule == "monthly"
        interval = s.interval
        count=30
        while interval != 0
          newDate = s.dup
          newDate.start_time += count.days
          count+=30
          @finalMeetings.push(newDate)
          interval -= 1
        end
      end
      if s.rule == "annually"
        interval = s.interval
        count=365
        while interval != 0
          newDate = s.dup
          newDate.start_time += count.days
          count+=365
          @finalMeetings.push(newDate)
          interval -= 1
        end
      end
    end

  end

  def create
    @meeting = current_user.meetings.create(meeting_params)

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to @meeting, notice: 'Meeting was successfully created.' }      
      else
        format.html { render :new }        
      end
    end
  end

  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to @meeting, notice: 'Meeting was successfully updated.' }      
      else
        format.html { render :edit }
      end
    end
  end

 def destroy
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to meetings_url, notice: 'Meeting was successfully destroyed.' }
    end
  end

  private

  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  def meeting_params
    params.require(:meeting).permit(:name, :start_time, :rule, :interval)
  end  
end
