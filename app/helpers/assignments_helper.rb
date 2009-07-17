module AssignmentsHelper
  def project_link(project_name, project_id)
    if project_name != "UA"
      link_to "#{project_name}", project_path(project_id)
    else
      "UA"
    end
  end
end