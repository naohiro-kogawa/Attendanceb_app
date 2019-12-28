module AttendancesHelper

  def attendance_state(attendance)
    # 受け取ったAttendanceオブジェクトが当日と一致するか評価します。
    if Date.current == attendance.worked_on
      return '出勤' if attendance.started_at.nil?
      return '退勤' if attendance.started_at.present? && attendance.finished_at.nil?
    end
    # どれにも当てはまらなかった場合はfalseを返します。
    return false
  end

  # 出勤時間と退勤時間を受け取り、在社時間を計算して返します。
  def working_times(start, finish)
    format("%.2f", (((finish - start) / 60) / 60.0))
  end
  
   # 1. 出勤時間と退勤時間どちらも空欄である場合、次の繰り返し処理が続行される。
   # 2. （1の条件式 がfalseだった場合）出勤時間か、
   # または退勤時間が空欄の場合attendances_invalid?メソッドは繰り返し処理を終了し、falseを返す。
   # 3. （2の条件式がfalseだった場合）出勤時間が退勤時間より大きい場合（出勤時間が退社時間より後の時間）
   # attendances_invalid?メソッドは繰り返し処理を終了し、falseを返す
   
  # def attendances_invalid?
  #   attendances = true
  #   attendances_params.each do |id, item|
  #     if item[:started_at].blank? && item[:finished_at].blank?
  #       next
  #     elsif item[:started_at].blank? || item[:finished_at].blank?
  #       attendances = false
  #       break
  #     elsif item[:started_at] > item[:finished_at]
  #       attendances = false
  #       break
  #     end
  #   end
  #   return attendances
  # end
end