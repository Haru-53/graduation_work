class HappinessScoresController < ApplicationController
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

    @scores = HappinessScore.where(created_at: range)
    @average = @scores.average(:score)&.round(2)
    @max = @scores.maximum(:score)
    @min = @scores.minimum(:score)

    @chart_data = @scores.group_by { |s| s.created_at.to_date }.map do |date, records|
      avg_score = records.map(&:score).sum / records.size.to_f
      memo = records.first.memo.presence || "（メモなし）"
      { date: date, score: avg_score.round(2), memo: memo }
    end
  end
end