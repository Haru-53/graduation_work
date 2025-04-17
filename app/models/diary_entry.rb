class DiaryEntry < ApplicationRecord

  has_one :happiness_score, dependent: :destroy
  
  def self.search(keyword)
    if keyword.present?
      where(
        "positive_point1 ILIKE :q OR positive_point2 ILIKE :q OR positive_point3 ILIKE :q OR reflection_point ILIKE :q OR memo ILIKE :q",
        q: "%#{sanitize_sql_like(keyword)}%"
      )
    else
      all
    end
  end
end
