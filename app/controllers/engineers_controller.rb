class EngineersController < ApplicationController
  # GET /engineers.js
  def index
    @engineers = Engineer.grid_data
    respond_to do |format|
      format.html
      format.js { render :json => @engineers }
    end
  end

  # POST /engineers.js
  def create
    @engineer = Engineer.new(ActiveSupport::JSON.decode(params[:rows]))

    respond_to do |format|
      format.js do
        if @engineer.save
          render :json => { :success => true, :message => "Created new Engineer #{@engineer.id}", :data => @engineer}
        else
          render :json => { :message => "Failed to create engineer"}
        end
      end
    end
  end

  # PUT /engineers/1.js
  def update
    @engineer = Engineer.find(params[:id])

    respond_to do |format|
      format.js do
        if @engineer.update_attributes(ActiveSupport::JSON.decode(params[:rows]))
          render :json => { :success => true, :message => "Updated Engineer #{@engineer.id}", :data => @engineer}
        else
          render :json => {:message => "Failed to update Engineer"}
        end
      end
    end
  end

  # DELETE /engineers/1.js
  def destroy
    @engineer = Engineer.find(params[:id])
    
    respond_to do |format|
      if @engineer.destroy
        format.js { render :json => {:success => true, :message => "Destroyed Engineer #{@engineer.id}"}}
      else
        format.js { render :json => {:message => "Failed to destroy user"}}   
      end     
    end
  end
end
