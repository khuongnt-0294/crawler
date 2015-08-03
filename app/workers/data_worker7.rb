require "open-uri"
require "mechanize"

class DataWorker7
  include Sidekiq::Worker
  sidekiq_options retry: 5
  def perform
    @default_uri = "http://doda.jp"
    @agent = Mechanize.new
    @root_page = @agent.get(@default_uri)
    @view_page = @root_page.link_with(text: "求人検索").click if @root_page.link_with(text: "求人検索").present?
    @form = @view_page.forms[0]
    @list_page = @agent.get("http://doda.jp/DodaFront/View/JobSearchList.action?so=50&tp=1&pic=1&ds=0&page=350")
    @test = 0

    begin
      @news = @list_page.search("div.company_box")
      (0..@news.count-1).each do |i|
        
        
               
        @link = @news[i].search("div.btn_box.clr p.left_btn a").map {|link| link["href"]}

        @agent.get(@link.first).search(".tab_btn.clr li a img").each_with_index do |link_detail, num|
          if link_detail.attributes["alt"].value == "募集要項"
            @detail_page = @agent.get(@agent.get(@link.first).search(".tab_btn.clr li a").map {|link| link["href"]}[num])
            break
          end  
        end 

        @form_uri = @detail_page.uri.to_s.strip
        
        if !Job.uniq.pluck(:url).include?(@form_uri)
          @job = Job.new
          @form_inexperience = ""
          @detail_page.search(".ico_box01 img").each do |exp|
            if exp.attributes["alt"].value == "未経験歓迎"
              @form_inexperience = "未経験歓迎"
              break
            end  
          end

          @form1 = @detail_page.search("div.main_ttl_box p").children[0].text.strip + (@detail_page.search("div.main_ttl_box p img") - @detail_page.search("div.main_ttl_box p.ico_box01 img")).map {|state| state["alt"]}.join("  ") if @detail_page.search("div.main_ttl_box p").children[0].present?

          @form11 = @detail_page.search("div.main_ttl_box h1").children[0].text.strip if @detail_page.search("div.main_ttl_box h1").children[0].present?
          @form3 = @detail_page.search("dl.clr dd a").children[-2].text.strip + ", " + @detail_page.search("dl.clr dd a").children[-1].text.strip if (@detail_page.search("dl.clr dd a").children[-2].present? && @detail_page.search("dl.clr dd a").children[-1].present?)
          
          @form4 = @detail_page.search("dl.clr dd a").children[0].text.strip + ", " + @detail_page.search("dl.clr dd a").children[1].text.strip + ", " + @detail_page.search("dl.clr dd a").children[2].text.strip if (@detail_page.search("dl.clr dd a").children[0].present? && @detail_page.search("dl.clr dd a").children[1].present? && @detail_page.search("dl.clr dd a").children[2].present?)

          @form1_23456 = @detail_page.search("div.leftBlock dl.clr dd")[1].text.strip if(@detail_page.search("div.leftBlock dl.clr dd")[1].present?)
          @form01 = @detail_page.search("div.leftBlock dl.clr dd")[1].text.strip if(@detail_page.search("div.leftBlock dl.clr dd")[1].present?)

          @form1_23456.slice!("〒")
          @form16 = /^(\d+-\d+).*$/.match(@form1_23456).to_a[1].to_s
          @form1_23456.slice!(@form16) if @form16.present?
          @formTG = /^(\W+?[／|】|：]).*$/.match(@form1_23456).to_a[1] if /^(\W+?[／|】|：]).*$/.match(@form1_23456).present?
          @form1_23456.slice!(@formTG.to_s) if @formTG.present?
          @form12 = /^(\W+?[都|道|府|県]).*$/.match(@form1_23456).to_a[1].to_s
          @form1_23456.slice!(@form12) if @form12.present?
          @form1_23456.slice!(@form12)
          @form13 = /^(\W+?[市|区|町|村]).*$/.match(@form1_23456).to_a[1].to_s
          @form1_23456.slice!(@form13) if @form13.present?
          
          @form14 = /(\W+[０-９0-9一-十]?+丁?目?[０-９0-9一-十]+番地?[０-９0-9一-十]+号?|\W+\S?[０-９0-9一-十]+[－-]番?地?[０-９0-9一-十]+[－-]?[０-９0-9一-十]+|\S+[０-９0-9一-十]+丁目[０-９0-9一-十]+[－-]?[０-９0-9一-十]+番?地?|\W+[０-９0-9一-十]+[－-][０-９0-9一-十]+|\S+[０-９0-9一-十]?+)?(.*)/.match(@form1_23456).to_a[1].to_s

          @form1_23456.slice!(@form14)

          @form15 = @form1_23456.split("／")[0].to_s
          @form15 = @form15.split("〒")[0].to_s
          @form15 = @form15.split("【")[0].to_s
          @form15 = @form15.gsub("※", "").to_s
          @form15 = @form15.split("＜")[0].to_s
          @rows = @detail_page.search("div.recruit_box02 table tr")
          @rows.each do |row|
            @category = row.search("th")
            @result = row.search("td p.txt_area")
            case @category.text.strip
            when "仕事内容"
              @form5 = fix_string(@result.to_html.squish) if @result.present?
            when "対象となる方"
              @form6 = fix_string(@result.to_html.squish) if @result.present?
            when "勤務地"
              @form2 = fix_string(@result.to_html.squish) if @result.present?
            when "勤務時間"
              @form7 = fix_string(@result.to_html.squish) if @result.present?
            when "給与"
              @form8 = fix_string(@result.to_html.squish) if @result.present?
            when "待遇・福利厚生"
              @form10 = fix_string(@result.to_html.squish) if @result.present?
            when "休日・休暇"
              @form9 = fix_string(@result.to_html.squish) if @result.present?                
            end  
          end

          if !Company.uniq.pluck(:name).include?(@form11)
            @company = Company.new
            @company.postal_code = @form16.strip          
            @company.name = @form11
            @company.address1 = @form12.strip
            @company.address2 = @form13.strip
            @company.address3 = @form14.strip
            @company.address4 = @form15.strip.squish
            @company.save  
          else  
            @company = Company.find_by name: @form11
          end
         
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

          @job.save
        end        
      end
     
      @list_page = @list_page.link_with(text: "次へ").click if @list_page.link_with(text: "次へ").present?
      @test += 1 if @list_page.link_with(text: "次へ").nil?
    end while ((@list_page.link_with(text: "次へ").present? || @test == 1) && (@list_page.uri.to_s.strip != "http://doda.jp/DodaFront/View/JobSearchList.action?so=50&tp=1&pic=1&ds=0&page=400"))
  end

  private

  def fix_string(str)
    str = str.gsub(/<p.*?>/, "")    
    str = str.gsub("<br>", "\n")
    str = str.gsub("</br>", "\n")
    str = str.gsub("<br/>", "\n")      
    str = str.gsub("<p>", "\n")
    str = str.gsub("</p>", "\n")
    return str
  end    
end  