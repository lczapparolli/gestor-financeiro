module PaginationHelper

  def pagination(obj, currentPage, rowsPerPage, totalPages, pagesShow = 3)
    #TODO: Improve readability
    html = link_to("", polymorphic_url(obj, :page => 1, :rows => rowsPerPage), {:class => "link link-default fa fa-fast-backward"}) << "\n"

    if currentPage > 1
      html << link_to("", polymorphic_url(obj, :page => currentPage - 1, :rows => rowsPerPage), {:class => "link link-default fa fa-step-backward"}) << "\n"
    end

    (pagesShow * 2 + 1).times do |pageNum|
      if ((pageNum - pagesShow + currentPage) > 0) && ((pageNum - pagesShow + currentPage) <= totalPages)
        if (pageNum - pagesShow + currentPage) == currentPage
          linkClass = "link-success"
        else
          linkClass = "link-default"
        end
        html << link_to((pageNum - pagesShow + currentPage), polymorphic_url(obj, :page => (pageNum - pagesShow + currentPage), :rows => rowsPerPage), {:class => "link #{linkClass}"}) << "\n"
      end
    end

    if currentPage < totalPages
      html << link_to("", polymorphic_url(obj, :page => currentPage + 1, :rows => rowsPerPage), {:class => "link link-default fa fa-step-forward"}) << "\n"
    end
    html << link_to("", polymorphic_url(obj, :page => totalPages, :rows => rowsPerPage), {:class => "link link-default fa fa-fast-forward"}) << "\n"
    html.html_safe
  end

end
