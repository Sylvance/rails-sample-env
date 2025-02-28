module PaginationHelper
  def paginate(collection, per_page = 2)
    current_page = (params[:page] || 1).to_i
    total_items = collection.count
    total_pages = (total_items.to_f / per_page).ceil

    offset = (current_page - 1) * per_page
    paginated_collection = collection.offset(offset).limit(per_page)

    {
      items: paginated_collection,
      current_page: current_page,
      total_pages: total_pages,
      total_items: total_items
    }
  end

  def pagination_links(pagination_data)
    total_pages = pagination_data[:total_pages]
    current_page = pagination_data[:current_page]

    content_tag :nav, class: "pagy nav", aria: { label: "Page" } do
      previous_link = link_to_previous_page(current_page)
      
      page_links = (1..total_pages).map do |page|
        if page == current_page
          link_to page.to_s, "#", role: "link", 
                  aria: { disabled: "true", current: "page" }, 
                  class: "current"
        else
          link_to page.to_s, url_for(params.permit!.merge(page: page)), 
                  role: "link"
        end
      end.join.html_safe
      
      next_link = link_to_next_page(current_page, total_pages)
      
      (previous_link + page_links + next_link).html_safe
    end
  end

  def link_to_previous_page(current_page)
    if current_page <= 1
      link_to "<", "#", role: "link", aria: { disabled: "true", label: "Previous" }
    else
      link_to "<", url_for(params.permit!.merge(page: current_page - 1)), 
              role: "link", aria: { label: "Previous" }
    end
  end

  def link_to_next_page(current_page, total_pages)
    if current_page >= total_pages
      link_to ">", "#", role: "link", aria: { disabled: "true", label: "Next" }
    else
      link_to ">", url_for(params.permit!.merge(page: current_page + 1)), 
              role: "link", aria: { label: "Next" }
    end
  end
end
