module ReviewsHelper
    def display_header(review)
        if params[:noodle_id]
            content_tag(:h1, "Add a Review for #{review.noodle.flavor} -  #{review.noodle.brand.name}")
        else
          content_tag(:h1, "Create a review")
        end
      end
end
