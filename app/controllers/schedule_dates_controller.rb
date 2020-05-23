class ScheduleDatesController < ApplicationController

  def index
    @schedule_dates = ScheduleDate.all.order(date: :asc)
    render json: @schedule_dates
  end


  def bulk
    bulk_json = schedule_date_params.to_h
    saved_schedules = []
    failed_schedules = []
    (bulk_json['start_date'].to_date..bulk_json['end_date'].to_date).each do |date|
      day = bulk_json['days'].select { |d|  d['day'].to_i == date.wday  }.first
      if day
        day['times'].each do |t|
          schedule_date = ScheduleDate.new
          schedule_date.date = Time.at(date.to_time.to_i).change({ hour: t['hour'].to_i, min: t['minute'].to_i, sec: 0 })
          schedule_date.capacity = t['capacity'].to_i
          if schedule_date.save
            saved_schedules << schedule_date
          else
            failed_schedules << schedule_date
          end
        end
      end
    end
    render json: { saved_schedules: saved_schedules, failed_schedules: failed_schedules }
  end

  def destroy
    render json: { mssg: current_schedule.destroy }
  end

  def destroy_all
    render json: { mssg: ScheduleDate.all.destroy_all }
  end

  private
    def current_schedule
      @schedule_date = ScheduleDate.find(params[:id])
    end

    def schedule_date_params
      params.permit!
    end
end
