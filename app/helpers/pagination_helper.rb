module PaginationHelper

  def pagination(obj, currentPage, rowsPerPage, totalPages, pagesShow = 3)
    html =
      "<ul class=\"pagination\">\n" <<
      "  <li class=\"arrow\">" << link_to("", polymorphic_url(obj, :page => 1, :rows => rowsPerPage), {:class => "fa fa-fast-backward"}) << "</li>\n"

    if currentPage > 1
      html << "  <li class=\"arrow\">"<< link_to("", polymorphic_url(obj, :page => currentPage - 1, :rows => rowsPerPage), {:class => "fa fa-step-backward"}) << "</li>\n"
    end

    (pagesShow * 2 + 1).times do |pageNum|
      if ((pageNum - pagesShow + currentPage) > 0) && ((pageNum - pagesShow + currentPage) <= totalPages)
        html << "  <li"
        if (pageNum - pagesShow + currentPage) == currentPage
          html << " class=\"current\" "
        end
        html << ">" << link_to((pageNum - pagesShow + currentPage), polymorphic_url(obj, :page => (pageNum - pagesShow + currentPage), :rows => rowsPerPage)) << "</li>\n"
      end
    end

    if currentPage < totalPages
      html << "  <li class=\"arrow\">" << link_to("", polymorphic_url(obj, :page => currentPage + 1, :rows => rowsPerPage), {:class => "fa fa-step-forward"}) << "</li>\n"
    end
    html << "  <li class=\"arrow\">" << link_to("", polymorphic_url(obj, :page => totalPages, :rows => rowsPerPage), {:class => "fa fa-fast-forward"}) << "</li>\n" <<
    "</ul>"
    html.html_safe
  end

end
