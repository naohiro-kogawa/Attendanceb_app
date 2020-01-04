class Attendance < ApplicationRecord
  belongs_to :user

  validates :worked_on, presence: true
  validates :note, length: { maximum: 50 }

  # 出勤時間が存在しない場合、退勤時間は無効
  validate :finished_at_is_invalid_without_a_started_at
  
  # 退勤時間が存在しない場合、出勤時間は無効
  validate :started_at_is_invalid_without_a_finished_at
  
  # 出勤・退勤時間どちらも存在する時、出勤時間より早い退勤時間は無効
  validate :started_at_than_finished_at_fast_if_invalid
  
  # 出勤時間と退勤時間がどちらも存在しない場合、
  # # 出勤時間と退勤時間がどちらかが存在しない場合は無効
  # validate :started_at_finished_at_conditions
    

  def finished_at_is_invalid_without_a_started_at
    errors.add(:started_at, "が必要です") if started_at.blank? && finished_at.present?
  end
  
  def started_at_is_invalid_without_a_finished_at
    errors.add(:finished_at, "が必要です") if finished_at.blank? && started_at.present?
  end
  

  def started_at_than_finished_at_fast_if_invalid
    if started_at.present? && finished_at.present?
      errors.add(:started_at, "より早い退勤時間は無効です") if started_at > finished_at
    end
  end
  
  # def started_at_finished_at_conditions
  #   errors.add(:started_at,:finished_at, "一部の編集が無効になった項目があります")
  #   if item[:started_at].blank? && item[:finished_at].blank?
  #   else item[:started_at].blank? || item[:finished_at].blank?
  #   end
  # end  
end