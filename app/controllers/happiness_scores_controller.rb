def create
  @diary_entry = DiaryEntry.find(params[:diary_entry_id])
  score_params = params.require(:happiness_score).permit(:item1, :item2, ..., :item10)

  # 重みをここで定義（変更可能）
  weights = [1.0] * 10
  total_score = 0.0
  total_weight = 0.0

  score_params.each_with_index do |(key, val), index|
    total_score += val.to_f * weights[index]
    total_weight += weights[index]
  end

  percentage_score = ((total_score / (10.0 * total_weight)) * 100).round

  @happiness_score = @diary_entry.build_happiness_score(score_params.merge(score: percentage_score))

  if @happiness_score.save
    redirect_to edit_diary_entry_path(@diary_entry), notice: '幸福度を保存しました！'
  else
    render :new
  end

  def stats
    range = case params[:period]
            when 'week'
              1.week.ago.to_date..Date.today
            when 'month'
              1.month.ago.to_date..Date.today
            when '3months'
              3.months.ago.to_date..Date.today
            when '6months'
              6.months.ago.to_date..Date.today
            else
              1.month.ago.to_date..Date.today
            end
  
    @scores = HappinessScore.where(date: range)
  
    @average = @scores.average(:score)&.round(2)
    @max = @scores.maximum(:score)
    @min = @scores.minimum(:score)
    
    @chart_data = @scores.group(:date).map do |date, group|
      avg_score = group.average(:score).to_f.round(2)
      memo = group.first.memo.presence || "（メモなし）"
    
      { date: date, score: avg_score, memo: memo }
    end
    end
  end
  
end
