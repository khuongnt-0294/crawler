module WorkersHelper
  def initial_page
    @default_uri = "http://doda.jp"
    @agent = Mechanize.new
    @root_page = @agent.get(@default_uri)
    @view_page = @root_page.link_with(text: "求人検索").click if @root_page.link_with(text: "求人検索").present?
    @form = @view_page.forms[0]
    @list_page = @agent.submit(@form, @form.buttons.last)
  end

  def initial_form
    @form1 = ""
    @form2 = ""
    @form3 = ""
    @form4 = ""
    @form5 = ""
    @form6 = ""
    @form7 = ""
    @form8 = ""
    @form9 = ""
    @form10 = ""
    @form11 = ""
    @form12 = ""
    @form13 = ""
    @form14 = ""
    @form15 = ""
    @form16 = ""
    @form17 = ""
    @form18 = ""
    @form19 = ""
    @form20 = ""
    @form21 = ""
    @form22 = ""
    @form23 = ""
    @form_inexperience = ""
    @array_form22 = []
  end

  def create_company
    @company = Company.new
    @company.postal_code = @form16.strip          
    @company.name = @form11
    @company.address1 = @form12.strip
    @company.address2 = @form13.strip
    @company.address3 = @form14.strip
    @company.address4 = @form15.strip.squish
    @company.home_page = @form23
    @company.establishment = @form19
    @company.employees_number = @form20
    @company.sales = @form21
    @company.tel = @form22
    @company.tel_detail = @form221
  end

  def create_job
    @job = Job.new
    @job.company = @company
    @job.title = @form1
    @job.workplace = @form2.strip
    @job.business_category = @form3
    @job.job_category = @form4
    @job.content = @form5.strip
    @job.requirement = @form6.strip
    @job.work_time = @form7.strip
    @job.salary = @form8.strip
    @job.holiday = @form9.strip
    @job.treatment = @form10.strip
    @job.url = @form_uri
    if @form_inexperience == "未経験歓迎"
      @job.inexperience = 1
    else
      @job.inexperience = 0   
    end  
  end

  def fix_string str
    str = str.gsub(/<p.*?>/, "")    
    str = str.gsub("<br>", "\n")
    str = str.gsub("</br>", "\n")
    str = str.gsub("<br/>", "\n")      
    str = str.gsub("<p>", "\n")
    str = str.gsub("</p>", "\n")
    return str
  end

  def edit_string str
    str = str.split("／")[0].to_s
    str = str.split("〒")[0].to_s
    str = str.split("【")[0].to_s
    str = str.gsub("※", "").to_s
    str = str.split("＜")[0].to_s
    return str  
  end

  def format_tel str
    str = str.gsub("－", "")
    str = str.gsub("-", "")
    str = str.gsub("(", "")
    str = str.gsub(")", "")
    return str
  end

end  