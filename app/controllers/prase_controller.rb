class PraseController < ApplicationController
  require 'nokogiri'
  require 'open-uri'
  def index
    @text_value=params[:search]
    urls="http://www.thinkvidya.com/provider/search?city=Hyderabad&keyword=#{@text_value}&area=&freshSearch=true&distance=2"
    docs=Nokogiri::HTML(open(urls))
    @a={}

    i=0
    @page=docs.css(".paddingTop20 .step").to_a
    begin
      @page_last_no=@page.last.text
    rescue
      @page_last_no=1
    end

    (1..@page_last_no.to_i).each do |page_no|

      url="http://www.thinkvidya.com/provider/search?city=Hyderabad&keyword=#{@text_value}&localityId=&page=#{page_no}&distance=2"
      doc=Nokogiri::HTML(open(url))

      doc.css(".ch-c").each do |item|
        @a[i]={}
        j=0
        begin
          @a[i][j]="#{item.at_css('.marginBtm2')}"
          j=j+1
        rescue

          @a[i][j]='No id'
          j=j+1
        end
        begin
          @a[i][j]="#{item.at_css('.border')}"
          j=j+1
        rescue

          @a[i][j]='No image'
          j=j+1
        end
        begin

          @a[i][j]="#{item.at_css('.loud').text}"
          j=j+1
        rescue
          @a[i][j]='No Name'

          j=j+1
        end
        begin
          @a[i][j]="#{item.at_css('.marginBtm2 b').text}"

          j=j+1
        rescue
          @a[i][j]='No Location'
          j=j+1
        end
        begin
          @a[i][j]="#{item.at_css('.searchSkillsLinks').text}"
          #@a[i].store(j,item.at_css(".searchSkillsLinks").text
          j=j+1
        rescue
          #@a[i][j]='No Skills'
          @a[i][j]='No Skills'
          j=j+1
        end
        begin
          @a[i][j]="#{item.at_css('.marginTop2 span').text}"
          j=j+1
        rescue

          @a[i][j]='No Description'
          j=j+1
        end
        begin
          @a[i][j]="#{item.at_css('.g6 p:nth-child(2)').text}"
          j=j+1
        rescue

          @a[i][j]='No experience'
          j=j+1
        end
        begin
          @a[i][j]="#{item.at_css('span:nth-child(3) img , span:nth-child(4) img')}"
          j=j+1
        rescue

          @a[i][j]='No rating'
          j=j+1
        end
        begin
          @a[i][j]="#{item.at_css('.marginBtm2 a')}"
          j=j+1
        rescue

          @a[i][j]='No url'
          j=j+1
        end
        i=i+1
      end

    end

  end

  def display

    url_buddy="https://www.opensesame.com/online-training-courses/information-technology/web-development/php"
    @open_sesame=Hash.new
    i=0
    buddy=Nokogiri::HTML(open(url_buddy))
    buddy.css('.search-snippet-info').each do |data|
      @open_sesame[i]={}
      j=0
      begin
        @open_sesame[i][j]=data.at_css('.product-price').text
        j=j+1
      rescue
        @open_sesame[i][j]="no price"
        j=j+1
      end
      begin
        @open_sesame[i][j]=data.at_css('.course-title a').text
        j=j+1
      rescue
        @open_sesame[i][j]="no title"
        j=j+1
      end
      begin
        @open_sesame[i][j]=data.at_css('.icon-os-clock').text
        j=j+1
      rescue
        @open_sesame[i][j]="no Time"
        j=j+1
      end
      begin
        @open_sesame[i][j]=data.at_css('.odd .os-solr-rating , .os-solr-course-author').text
        j=j+1
      rescue
        @open_sesame[i][j]="no author"
        j=j+1
      end
      begin
        @open_sesame[i][j]=data.at_css('.os-solr-rating').text
        j=j+1
      rescue
        @open_sesame[i][j]="no rating"
        j=j+1
      end
      begin
        #@open_sesame[i][j]=data.at_css('.bundle-description p').text
        @open_sesame[i][j]=data.at_css('.os-solr-description').to_s
        #@open_sesame[i][j]=data.xpath('//*[(@id = "block-system-main")]//p')
        j=j+1
      rescue
        @open_sesame[i][j]="no description"
        j=j+1
      end
      begin
        @open_sesame[i][j]=data.at_css('img').to_s
        j=j+1
      rescue
        @open_sesame[i][j]="no tag"
        j=j+1
      end
      i=i+1
    end

  end
  def moodle
    @moodle=Hash.new
    i=0
    (0..833).each do |page_no|
      url_moodle="https://moodle.org/mod/data/view.php?d=54&mode=single&page=#{page_no}"
      #logger.info"-----#{url_moodle}--------------"
      #url_buddy="https://www.opensesame.com/online-training-courses/information-technology/web-development/php"

      moodle=Nokogiri::HTML(open(url_moodle))
      #@s=moodle.at_css("title").text
      #moodle.css(".generalbox").each do |item|
      @moodle[i]={}
      j=0
      begin
        @moodle[i][j]=moodle.at_css('.generalbox div:nth-child(1)').text
        j=j+1
      rescue

        @moodle[i][j]='no title'
        j=j+1
      end
      begin
        @moodle[i][j]=moodle.at_css('.generalbox div:nth-child(3)').text
        j=j+1
      rescue

        @moodle[i][j]='no type'
        j=j+1
      end
      begin

        @moodle[i][j]=moodle.at_css('.generalbox a:nth-child(2)').text
        j=j+1
      rescue
        @moodle[i][j]='No contact'

        j=j+1
      end
      begin
        @moodle[i][j]=moodle.at_css('.generalbox div:nth-child(4)').text

        j=j+1
      rescue
        @moodle[i][j]='No Location'
        j=j+1
      end
      begin
        @moodle[i][j]=moodle.at_css('.generalbox div:nth-child(7)').text
        #@a[i].store(j,item.at_css(".searchSkillsLinks").text
        j=j+1
      rescue
        #@a[i][j]='No Skills'
        @moodle[i][j]='No Description'
        j=j+1
      end

      i=i+1
    end

    #end
=begin
respond_to do |format|
      format.html
      format.csv { send_data @moodle.to_csv }
      format.xls  { send_data @moodle.to_csv(:col_sep=> "\t") }
    end
=end
  end
  def university
    url="http://xolotl.org/blog/xolotl/who-using-sakai-moodle"
    university=Nokogiri::HTML(open(url))
    @tra=Hash.new
    i=0
    university.css("#node-869 .content li a").each do |k|
      @tra[i]={}
      j=0
      begin
        @tra[i][j]=k.text
        j=j+1
      rescue

        @tra[i][j]='No name'
        j=j+1
      end
      begin
        a=k.to_s
        @b=a.split('href="')
        @last=@b[1].split('">')

        @tra[i][j]=@last[0]
        j=j+1
      rescue
        @tra[i][j]='No href'
        j=j+1
      end
      i=i+1
    end
  end
  def training
=begin
url="http://www.trainingindustry.com/supplier-search.aspx?s=e-learning%20companies"
    university=Nokogiri::HTML(open(url))
    @tra=Hash.new
    i=0
    university.css(".org a").each do |k|
      @tra[i]={}
      j=0
      begin
        @tra[i][j]=k.text
        j=j+1
      rescue

        @tra[i][j]='No name'
        j=j+1
      end
      begin
        a=k.to_s
        @b=a.split('href="')
        @last=@b[1].split('">')
        @com="http://www.trainingindustry.com"+@last[0]
        @tra[i][j]=@com
        j=j+1
      rescue
        @tra[i][j]='No href'
        j=j+1
      end
      test=Nokogiri::HTML(open(@com))
      begin
        @tra[i][j]=test.css(".location-list li").text
        j=j+1
      rescue
        @tra[i][j]='No locatiom'
        j=j+1
      end
      begin
        an=test.css(".sp-link-web").to_s
      @s=an.split('href="')
      @last1=@s[1].split('">')
        @tra[i][j]=@last1[0]
        j=j+1
      rescue
        @tra[i][j]='No comp url'
        j=j+1
      end
      begin
        @tra[i][j]=test.css(".sp-person").text
        j=j+1
      rescue
        @tra[i][j]='No person'
        j=j+1
      end
      begin
        @tra[i][j]=test.css(".sp-tel").text
        j=j+1
      rescue
        @tra[i][j]='No tell'
        j=j+1
      end

      i=i+1
    end
=end
    #.supplier-info h3

 #====================
    @tra=Hash.new
    i=0
            #Product.where(:id=>[360..408])//india

Product.where(:id=>[461..502]).each do |pr|
#Product.where("id= ?",360).each do |pr|
  @tra[i]={}
  j=0
  test=Nokogiri::HTML(open("#{pr.name}"))
  begin
    @tra[i][j]=test.css(".supplier-info h3").text.strip
    j=j+1
  rescue
    @tra[i][j]='Company name'
    j=j+1
  end
  begin
    @tra[i][j]= pr.name
    j=j+1
  rescue
    @tra[i][j]='No url'
    j=j+1
  end
  begin
    @tra[i][j]=test.css(".location-list li").text
    j=j+1
  rescue
    @tra[i][j]='No locatiom'
    j=j+1
  end
  begin
    an=test.css(".sp-link-web").to_s
    @s=an.split('href="')
    last1=@s[1].split('">')
    last2=last1[0].split('"')
    @tra[i][j]=last2[0]
    j=j+1
  rescue
    @tra[i][j]='No comp url'
    j=j+1
  end
  begin
    @tra[i][j]=test.css(".sp-person").text.strip
    j=j+1
  rescue
    @tra[i][j]='No person'
    j=j+1
  end
  begin
    @tra[i][j]=test.css(".sp-tel").text.strip
    j=j+1
  rescue
    @tra[i][j]='No tell'
    j=j+1
  end

  i=i+1

end
    #================

  end
  def import
    Product.import(params[:file])
    #redirect_to root_url, :notice=> "Products imported."
  end
end
#.sp-person , .sp-tel
#.location-list li
#name => .loud
#location =>.marginBtm2 b
#skills =>.searchSkillsLinks
#description .marginTop2 span
#image .border img

#open=>.course-title a
#time=>.icon-os-clock
#author=>.odd .os-solr-rating , .os-solr-course-author
#rating=>.os-solr-rating
#description=>#block-system-main p

#moodle
#mainbox=>.generalbox
#title=>.generalbox div:nth-child(1) ------#yui_3_7_3_2_1357827187656_198 div:nth-child(1)
#type=>div:nth-child(3) ---#yui_3_7_3_2_1357826935916_199 div:nth-child(3)
#location=>#yui_3_7_3_2_1357826935916_198 div:nth-child(4)
#contact =>#yui_3_7_3_2_1357826935916_199 a -----------a:nth-child(2)---.generalbox a:nth-child(2)

#describtion=>#yui_3_7_3_2_1357826935916_199 p:nth-child(1)
#decribtion2=>#yui_3_7_3_2_1357826935916_199 ul

#yui_3_7_3_2_1357827187656_198 div:nth-child(7)

#.generalbox div:nth-child(7)