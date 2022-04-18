module ApplicationHelper
  def log(str)
      Rails.logger.error("#{__FILE__}:#{__LINE__}:#{str}")
  end
end
