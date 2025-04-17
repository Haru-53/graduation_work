class DiaryEntriesController < ApplicationController
  before_action :set_diary_entry, only: [:show, :edit, :update, :destroy]

  def index
    @keyword = params[:keyword]
    @diary_entries = DiaryEntry.search(@keyword).order(date: :desc)
  end

  def show
  end

  def new
    @diary_entry = DiaryEntry.new(date: Date.today)
  end

  def create
    @diary_entry = DiaryEntry.new(diary_entry_params)

    if @diary_entry.save
      redirect_to @diary_entry, notice: '日記が作成されました！'
    else
      render :new
    end
  end

  def edit
  end

  def calendar
    @diary_entries = DiaryEntry.all
  end

  def update
    if @diary_entry.update(diary_entry_params)
      redirect_to @diary_entry, notice: '日記が更新されました！'
    else
      render :edit
    end
  end

  def destroy
    @diary_entry.destroy
    redirect_to diary_entries_path, notice: '日記が削除されました'
  end

  private

  def set_diary_entry
    @diary_entry = DiaryEntry.find(params[:id])
  end

  def diary_entry_params
    params.require(:diary_entry).permit(:date, :positive_point1, :positive_point2, :positive_point3, :reflection_point, :memo)
  end

  def summary
    @period = params[:period] || '1_month'
    @start_date = case @period
                  when '1_week' then 1.week.ago.to_date
                  when '3_months' then 3.months.ago.to_date
                  when '6_months' then 6.months.ago.to_date
                  when '1_year' then 1.year.ago.to_date
                  else 1.month.ago.to_date
                  end

    @entries = DiaryEntry.where('date >= ?', @start_date).order(date: :desc)

    @summaries = @entries.map do |entry|
      content = [
        entry.positive_point1,
        entry.positive_point2,
        entry.positive_point3,
        entry.reflection_point,
        entry.memo
      ].compact.join('。')

      {
        date: entry.date,
        summary: content.truncate(200)
      }
    end
  end
end
