module PaginationHelper

  def pagination(obj, current_page, rows_per_page, total_rows, pages_to_show = 5)
    
    total_pages = (total_rows / rows_per_page.to_f).ceil
    pages_to_show = total_pages < pages_to_show ? total_pages : pages_to_show

    content_tag(:div, class: "paginator") do
      link_to("", polymorphic_url(obj, :page => 1, :rows => rows_per_page), {:class => "link link-default fa fa-fast-backward"}) <<
      #TODO: Add class to disabled link
      link_to("", polymorphic_url(obj, :page => current_page - 1, :rows => rows_per_page), {:class => "link link-default fa fa-step-backward"}) <<
      page_links(obj, current_page, rows_per_page, total_pages, pages_to_show) <<
      #TODO: Add class to disabled link
      link_to("", polymorphic_url(obj, :page => current_page + 1, :rows => rows_per_page), {:class => "link link-default fa fa-step-forward"}) <<
      link_to("", polymorphic_url(obj, :page => total_pages, :rows => rows_per_page), {:class => "link link-default fa fa-fast-forward"})
    end

  end

  def page_links(obj, current_page, rows_per_page, total_pages, pages_to_show)
    pages = ""
    page_number = 0
    
    page_list = page_list(current_page, pages_to_show, total_pages)
    page_list.each do |page_number|
      link_class = (page_number == current_page) ? "link-success" : "link-default"
      pages << link_to(page_number, polymorphic_url(obj, :page => page_number, :rows => rows_per_page), {:class => "link #{link_class}"})
    end
    sanitize(pages)
  end

  def page_list(current_page, pages_to_show, total_pages)
    first_page_number = first_page_number(current_page, pages_to_show, total_pages)
    last_page_number = first_page_number + pages_to_show - 1
    (first_page_number..last_page_number).to_a
  end

  def first_page_number(current_page, pages_to_show, total_pages)

    half_pages = (pages_to_show / 2).round
    first_page_number = current_page - half_pages

    if (first_page_number < 1) #If first page is less than 1
      first_page_number = 1
    elsif (current_page + half_pages > total_pages) #If range exceeds the last page
      first_page_number = total_pages - pages_to_show + 1 #+1 to include the last page
    end
      first_page_number
  end

  def first_page?(current_page)
    current_page <= 1
  end

  def last_page?(current_page, total_pages)
    current_page >= total_pages
  end

end
