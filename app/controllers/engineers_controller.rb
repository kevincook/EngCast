class EngineersController < ApplicationController
  # GET /engineers
  # GET /engineers.xml
  def index
    @engineers = Engineer.grid_data

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @engineers }
      format.js { render :json => @engineers }
    end
  end

  # GET /engineers/1
  # GET /engineers/1.xml
  def show
    @engineer = Engineer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @engineer }
    end
  end

  # GET /engineers/new
  # GET /engineers/new.xml
  def new
    @engineer = Engineer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @engineer }
      format.js { render :json => @engineer }
    end
  end

  # GET /engineers/1/edit
  def edit
    @engineer = Engineer.find(params[:id])
  end

  # POST /engineers
  # POST /engineers.xml
  def create
    respond_to do |format|
      format.js do
        @engineer = Engineer.new(ActiveSupport::JSON.decode(params[:rows]))
        if @engineer.save
          render :json => { :success => true, :message => "Created new Engineer #{@engineer.id}", :data => @engineer}
        else
          render :json => { :message => "Failed to create engineer"}
        end
      end
    end
  end

  # PUT /engineers/1
  # PUT /engineers/1.xml
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

  # DELETE /engineers/1
  # DELETE /engineers/1.xml
  def destroy
    @engineer = Engineer.find(params[:id])
    
    respond_to do |format|
      if @engineer.destroy
        format.html { redirect_to(engineers_url) }
        format.xml  { head :ok }
        format.js { render :json => {:success => true, :message => "Destroyed Engineer #{@engineer.id}"}}
      else
        format.html { redirect_to(engineers_url) }
        format.xml  { head :ok }
        format.js { render :json => {:message => "Failed to destroy user"}}   
      end     
    end
  end
end
