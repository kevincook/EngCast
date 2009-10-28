class ManagersController < ApplicationController
  def index
    @managers = Manager.grid_data

    respond_to do |format|
      format.html # index.html.erb
      format.js { render :json => @managers }
    end
  end

  def create
    @manager = Manager.new(params[:manager])

    respond_to do |format|
      if @manager.save
        flash[:notice] = 'Manager was successfully created.'
        format.html { redirect_to(@manager) }
        format.xml  { render :xml => @manager, :status => :created, :location => @manager }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @manager.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @manager = Manager.find(params[:id])

    respond_to do |format|
      if @manager.update_attributes(params[:manager])
        flash[:notice] = 'Manager was successfully updated.'
        format.html { redirect_to(@manager) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @manager.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @manager = Manager.find(params[:id])
    @manager.destroy

    respond_to do |format|
      format.html { redirect_to(managers_url) }
      format.xml  { head :ok }
    end
  end
end
