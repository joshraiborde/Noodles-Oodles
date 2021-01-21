module ApplicationHelper
  def current_rating(noodle)
    rating = noodle.reviews.collect(&:stars).inject(0){|sum,x| sum + x }/noodle.reviews.collect(&:stars).size rescue 0
    rating
  end

end
