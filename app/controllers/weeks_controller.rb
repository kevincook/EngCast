class WeeksController < ApplicationController
  # GET /weeks.js
  def index
    @weeks = Week.grid_data

    respond_to do |format|
      format.html # index.html.erb
      format.js { render :json => @weeks }
    end
  end

  # POST /weeks.js
  def create
    @week = Week.new(params[:week])

    respond_to do |format|
      if @week.save
        flash[:notice] = 'Week was successfully created.'
        format.html { redirect_to(@week) }
        format.xml  { render :xml => @week, :status => :created, :location => @week }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @week.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /weeks/1.js
  def update
    @week = Week.find(params[:id])

    respond_to do |format|
      if @week.update_attributes(params[:week])
        flash[:notice] = 'Week was successfully updated.'
        format.html { redirect_to(@week) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @week.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /weeks/1.js
  def destroy
    @week = Week.find(params[:id])
    @week.destroy

    respond_to do |format|
      format.html { redirect_to(weeks_url) }
      format.xml  { head :ok }
    end
  end
end
