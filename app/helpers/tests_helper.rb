module TestsHelper

  def create_excel
    @book = RubyXL::Workbook.new
    @sheet1 = @book[0]
    @sheet2 = @book.add_worksheet("Company")
    @sheet1.sheet_name = "Job"

    @sheet1.add_cell(0, 0, "NO")
    @sheet1.add_cell(0, 1, "求人ID")
    @sheet1.add_cell(0, 2, "企業ID")
    @sheet1.add_cell(0, 3, "N社の企業ID")
    @sheet1.add_cell(0, 4, "企業名")
    @sheet1.add_cell(0, 5, "掲載媒体")
    @sheet1.add_cell(0, 6, "掲載URL")
    @sheet1.add_cell(0, 7, "案件タイトル")
    @sheet1.add_cell(0, 8, "応募資格")
    @sheet1.add_cell(0, 9, "未経験OK")
    @sheet1.add_cell(0, 10, "勤務地")
    @sheet1.add_cell(0, 11, "業種")
    @sheet1.add_cell(0, 12, "募集職種")
    @sheet1.add_cell(0, 13, "仕事内容")
    @sheet1.add_cell(0, 14, "勤務時間")
    @sheet1.add_cell(0, 15, "給与")
    @sheet1.add_cell(0, 16, "休日、休暇")
    @sheet1.add_cell(0, 17, "待遇")
    @sheet1.add_cell(0, 18, "取得日")
    @sheet1.add_cell(0, 19, "掲載期間")
    @sheet1.add_cell(0, 20, "掲載更新日")
    @sheet1.add_cell(0, 21, "部署名(その他)")
    @sheet1.add_cell(0, 22, "職種カテゴリー")
    @sheet1.add_cell(0, 23, "職種サブカテゴリー")
    @sheet1.add_cell(0, 24, "郵便番号")
    @sheet1.add_cell(0, 25, "都道府県")
    @sheet1.add_cell(0, 26, "市区町村番地")
    @sheet1.add_cell(0, 27, "ビル名")
    @sheet1.add_cell(0, 28, "電話番号")
    @sheet1.add_cell(0, 29, "採用担当部署")
    @sheet1.add_cell(0, 30, "採用担当者")
    @sheet1.add_cell(0, 31, "メールアドレス")
    @sheet1.add_cell(0, 32, "URL")
    @sheet1.add_cell(0, 33, "企業業種")
    @sheet1.add_cell(0, 34, "事業内容")
    @sheet1.add_cell(0, 35, "従業員数")
    @sheet1.add_cell(0, 36, "売上高")
    @sheet1.add_cell(0, 37, "設立年")
    @sheet1.add_cell(0, 38, "広告サイズ")
    @sheet1.change_row_fill(0, "5F9EA0")

    @sheet2.add_cell(0, 0, "企業ID")
    @sheet2.add_cell(0, 1, "取得日")
    @sheet2.add_cell(0, 2, "企業名")
    @sheet2.add_cell(0, 3, "職種カテゴリー")
    @sheet2.add_cell(0, 4, "職種サブカテゴリー")
    @sheet2.add_cell(0, 5, "郵便番号")
    @sheet2.add_cell(0, 6, "都道府県")
    @sheet2.add_cell(0, 7, "市区町村番地")
    @sheet2.add_cell(0, 8, "ビル名")
    @sheet2.add_cell(0, 9, "電話番号")
    @sheet2.add_cell(0, 10, "採用担当部署")
    @sheet2.add_cell(0, 11, "採用担当者")
    @sheet2.add_cell(0, 12, "メールアドレス")
    @sheet2.add_cell(0, 13, "URL")
    @sheet2.add_cell(0, 14, "従業員数")
    @sheet2.add_cell(0, 15, "売上高")
    @sheet2.add_cell(0, 16, "設立年")
    @sheet2.change_row_fill(0, "778899")

    @jobs = Job.all
    @companies = Company.all

    @companies.each_with_index do |company, i|
      @sheet2.add_cell(i+1, 0, company.id)
      @sheet2.add_cell(i+1, 1, company.updated_at.strftime("%Y/%m/%d"))
      @sheet2.add_cell(i+1, 2, company.name)
      @sheet2.add_cell(i+1, 5, company.postal_code)
      @sheet2.add_cell(i+1, 6, company.address1)
      @sheet2.add_cell(i+1, 7, company.address2 + company.address3)
      @sheet2.add_cell(i+1, 8, company.address4)
      @sheet2.add_cell(i+1, 9, company.tel)
      @sheet2.add_cell(i+1, 13, company.home_page)
      @sheet2.add_cell(i+1, 14, company.employees_number)
      @sheet2.add_cell(i+1, 15, company.sales)
      @sheet2.add_cell(i+1, 16, company.establishment)
    end

    @jobs.each_with_index do |job, i|
      @sheet1.add_cell(i+1, 0, i+1)
      @sheet1.add_cell(i+1, 1, job.id)
      @sheet1.add_cell(i+1, 2, job.company_id)
      @sheet1.add_cell(i+1, 18, job.updated_at.strftime("%Y/%m/%d"))
      
      @sheet1.add_cell(i+1, 5, "イーキャリア")
      @sheet1.add_cell(i+1, 4, job.company.name) if job.company.present?
      @sheet1.add_cell(i+1, 24, job.company.postal_code) if job.company.present?
      @sheet1.add_cell(i+1, 25, job.company.address1) if job.company.present?
      @sheet1.add_cell(i+1, 26, job.company.address2 + job.company.address3) if job.company.present?
      @sheet1.add_cell(i+1, 27, job.company.address4) if job.company.present?
     

      @sheet1.add_cell(i+1, 7, job.title)
      @sheet1.add_cell(i+1, 8, job.requirement)
      @sheet1.add_cell(i+1, 9, "◯") if job.inexperience == 1
      @sheet1.add_cell(i+1, 10, job.workplace)
      @sheet1.add_cell(i+1, 11, job.business_category)
      @sheet1.add_cell(i+1, 12, job.job_category)
      @sheet1.add_cell(i+1, 13, job.content)
      @sheet1.add_cell(i+1, 14, job.work_time)
      @sheet1.add_cell(i+1, 15, job.salary)
      @sheet1.add_cell(i+1, 16, job.holiday)
      @sheet1.add_cell(i+1, 17, job.treatment)
      @sheet1.add_cell(i+1, 6, job.url)
      @sheet1.add_cell(i+1, 28, job.company.tel)
      @sheet1.add_cell(i+1, 32, job.company.home_page)
      @sheet1.add_cell(i+1, 35, job.company.employees_number)
      @sheet1.add_cell(i+1, 36, job.company.sales)
      @sheet1.add_cell(i+1, 37, job.company.establishment)
    end

    @book.write("test12.xlsx")  

  end

  def clear_sidekiq
    Sidekiq::Queue.new.clear
    Sidekiq::RetrySet.new.clear
    Sidekiq::ScheduledSet.new.clear    
  end 
end
