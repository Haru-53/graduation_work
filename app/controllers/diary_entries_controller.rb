class DiaryEntriesController < ApplicationController
  before_action :set_diary_entry, only: [:show, :edit, :update, :destroy]

  def index
    @diary_entries = DiaryEntry.all.order(date: :desc)
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
end
