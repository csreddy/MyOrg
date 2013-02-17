class EmployeesController < ApplicationController
  helper_method :sort_column, :sort_direction
  autocomplete :employee, :name
  
  # GET /employees
  # GET /employees.json
  def index
   @search = Employee.metasearch(params[:search])
   @employees = @search.order(sort_column + " " + sort_direction).paginate(:page => params[:page])
   
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @employees }
    end
  end


  # GET /employees/1
  # GET /employees/1.json
  def show
     @search = Employee.metasearch(params[:search]) 
    @employee = Employee.find(params[:id]) 
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @employee }
      format.xml
    end
  end

  # GET /employees/new
  # GET /employees/new.json
  def new
    @search = Employee.metasearch(params[:search])
    @employee = Employee.new
    @employee.build_address
    @employee.phones.build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @employee }
    end
  end

  # GET /employees/1/edit
  def edit
    @search = Employee.metasearch(params[:search])
    @employee = Employee.find(params[:id])
     if !@employee.address.nil? then
        @employee.address
      else
        @employee.build_address
    end    
    
     @employee.phones.build
  end

  # POST /employees
  # POST /employees.json
  def create
    @search = Employee.metasearch(params[:search])
    @employee = Employee.new(params[:employee])

    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
        format.json { render json: @employee, status: :created, location: @employee }
      else
         @employee.build_address
         @employee.phones.build
        format.html { render action: "new" }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /employees/1
  # PUT /employees/1.json
  def update
    @employee = Employee.find(params[:id])

    respond_to do |format|
      if @employee.update_attributes(params[:employee])
        format.html { redirect_to @employee, notice: @employee.name.to_s + ' was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy

    respond_to do |format|
      format.html { redirect_to employees_url, notice: @employee.name.to_s + 'was successfully removed.' }
      format.json { head :no_content }
    end
  end
  
  
  def chart
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Year' ) 
    data_table.new_column('number', 'Sales') 
    data_table.new_column('number', 'Expenses') 

    # Add Rows and Values 
    data_table.add_rows([ 
      ['2004', 1000, 400], 
      ['2005', 1170, 460], 
      ['2006', 660, 1120], 
      ['2007', 1030, 540] 
    ])
    
    option = { width: 400, height: 240, title: 'Company Performance' }
    @chart = GoogleVisualr::Interactive::AreaChart.new(data_table, option)
  end
  
  def org_chart
    data_table = GoogleVisualr::DataTable.new
      data_table.new_column('string', 'Name'   )
      data_table.new_column('string', 'Manager')
      data_table.new_column('string', 'ToolTip')
      @managers = Employee.find(:all)
      @managers.each do |m|
        data_table.add_rows( [[{:v => m.name, :f => m.name+'<div style="color:red; font-style:italic">'+get_roles_title(m)+'</div>'}, get_manager_info(m), m.name]])        
      end
 
      opts   = { :allowHtml => true }
      @chart = GoogleVisualr::Interactive::OrgChart.new(data_table, opts)
  end
  
  private
  
    def sort_column
      Employee.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end
  
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
    
    def get_managers
       @managers = Employee.find(:all, :group => "manager_id")
    end
    
    def get_manager_info(employee)
     # @employee = Employee.find(params[:id])
       employee.manager.nil? ? "" : employee.manager.name
     
    end
  
    def get_roles_title(employee)
     employee.roles.empty? ? "no role" : employee.roles.map {|r| r.title.to_s.inspect}.join(",").gsub("\"", "")
  end
  
end
