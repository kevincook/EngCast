class AssignmentsController < ApplicationController
  def index
    @assignments = Assignment.crosstab
    @sw_engineers = Engineer.sw_engineers
    @qa_engineers = Engineer.qa_engineers
    @weeks = Week.find(:all, :order=>:startdate)

    respond_to do |format|
      format.html #index.html.erb
      format.xml { render :xml => @assignments }
    end
  end

  def show
    @assignment = Assignment.find(params[:id])

    respond_to do |wants|
      wants.html #show.html.eb
      wants.xml { render :xml => @assignment}
    end
  end
  
  def new
    @assignment = Assignment.new
    @projects = Project.all
    @engineers = Engineer.find(:all, :order=>:lastname)
    @weeks = Week.find(:all, :order=>:startdate)

    respond_to do |wants|
      wants.html #new.html.erb
      wants.xml { render :xml => @assignment}
    end
  end
  
  def edit
    @assignment = Assignment.find(params[:id])
    @projects = Project.all
    @engineers = Engineer.find(:all, :order=>:lastname)
    @weeks = Week.find(:all, :order=>:startdate)
  end  
  
  def create
    @assignment = Assignment.new(params[:assignment])
    
    respond_to do |wants|
      if @assignment.save
        flash[:notice] = 'Assignment was successfully created'
        wants.html { redirect_to @assignment }
        wants.xml { render :xml => @assignment, :status => :created, :location  => @assignment}
      else
        format.html { render :action => 'new'}
        format.xml { render :xml => @assignment.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    @assignment = Assignment.find(params[:id])
    
    respond_to do |wants|
      if @assignment.update_attributes(params[:assignment])
        flash[:notice] = 'Assignment was successfully updated'
        wants.html { redirect_to @assignment }
        wants.xml { head :ok }
      else
        wants.html { render :action => 'edit'}
        wants.xml { render :xml => @assignment.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @assignment = Assignment.find(params[:id])
    @assignment.destroy
    
    respond_to do |wants|
      wants.html { assignments_url }
      wants.xml { head :ok }
    end
  end
end