class ProjectsController < ApplicationController
  # GET /projects.js
  def index
    @projects = Project.grid_data

    respond_to do |format|
      format.html
      format.js { render :json => @projects }
    end
  end

  # POST /projects.js
  def create
    @project = Project.new(ActiveSupport::JSON.decode(params[:rows]))

    respond_to do |format|
      if @project.save
        format.js { render :json => { :success => true, :message => "Created new project #{@project.id}", :data => @project}}
      else
        format.js { render :json => { :message => 'Failed to create project'}}
      end
    end
  end

  # PUT /projects/1.js
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      format.js do
        if @project.update_attributes(ActiveSupport::JSON.decode(params[:rows]))
          render :json => { :success => true, :message => "Updated project #{@project.id}", :data => @project }
        else
          render :json => { :message => "Failed to update project" }
        end
      end
    end
  end

  # DELETE /projects/1.js
  def destroy
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.destroy
        format.js { render :json => {:success => true, :message => "Destroyed project #{@project.id}"}}  
      else
        format.js { render :json => {:message => 'Failed to destroy project'}}
      end
    end
  end
end
