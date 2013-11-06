module StaticHelper
  class SMParser
    require 'nokogiri'
    require 'net/http'
    require 'yaml'

    attr_accessor :classes

    BANNER_URL = 'https://banner.mines.edu/prod/owa/bwckschd.p_get_crse_unsec'
    POST_PARAMS = {
      'term_in'       => '201410',
      'sel_subj'      => ['dummy', 'AFGN','BIOL','CSM','CBEN','CHGN','CHGC','CEEN','CSCI','COOP','EPIC','EBGN','EENG','ENGY','EGGN','LIFL','GEGX','GEGN','GEOL','GPGN','HNRS','LAIS','MLGN','MATH','MEGN','MTGN','MSGN','MNGN','LIMU','NUGN','PEGN','PAGN','PHGN','SYGN'],
      'sel_day'       => 'dummy',
      'sel_schd'      => ['dummy','%'],
      'sel_insm'      => 'dummy',
      'sel_camp'      => 'dummy',
      'sel_levl'      => ['dummy','%'],
      'sel_sess'      => 'dummy',
      'sel_instr'     => ['dummy','%'],
      'sel_ptrm'      => ['dummy','%'],
      'sel_attr'      => 'dummy',
      'sel_crse'      => '',
      'sel_title'     => '',
      'sel_from_cred' => '',
      'sel_to_cred'   => '',
      'begin_hh'      => '0',
      'begin_mi'      => '0',
      'begin_ap'      => 'a',
      'end_hh'        => '0',
      'end_mi'        => '0',
      'end_ap'        => 'a'
    }

    def initialize
      url = URI.parse(BANNER_URL)
      req = Net::HTTP::Post.new(url.path)
      req.set_form_data(POST_PARAMS)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      @response = http.request(req)
      @class_nodes = []
      @classes = {}

    end

    ## Convert html to Nokogiri Nodes
    def noko_parse
      html_doc = Nokogiri::HTML.parse(@response.body)
      table = html_doc.css('div.pagebodydiv>table.datadisplaytable').first
      @classes_list = html_doc.css('div.pagebodydiv>table.datadisplaytable>tr')
      @classes_list.pop # remove last nonnecessary node
    end

    def create_class_nodes
      @classes_list.each_slice(2) do |ele|
        @class_nodes << ele
      end
    end

    def build_classes

      @class_nodes.each do |name_of_class_node, information_node|
        section_stats = {}
        class_name, crn, department_code, course_number, section = parse_class_name(name_of_class_node)

        section_stats["CRN"] = crn
        section_stats["Department Code"] = department_code
        section_stats["Course Number"] = course_number
        section_stats["Section"] = section

        table_of_info = information_node.css('table.datadisplaytable')
        column_headers_array = table_of_info.css('th.ddheader')
        column_body_array = table_of_info.css('tr')
        column_body_array.shift  # remove headers

        if column_body_array.size == 1
          column_body_array = table_of_info.css('td.dddefault')
          column_headers_array.zip(column_body_array).each do |col|
            section_stats[col[0].text] = stabalize(col)
          end
        elsif column_body_array.size > 1
          column_body_array.size.times do |index|
            elements = column_body_array[index].css('td.dddefault')
            column_headers_array.zip(elements) do |col| 
              section_stats[col[0].text] = stabalize(col)
            end
          end
        end

        @classes[class_name] ||= []
        @classes[class_name] << section_stats
      end
    end

    def parse_class_name(node)
      unscrubbed_name = node.css('a').inner_text.gsub(/\r|\n/,'').strip
      # puts unscrubbed_name
      match_data = /(?<name>.*) - (?<crn>\d{5}) - (?<department_code>\w+)\s(?<course_number>\d+\w+) - (?<section_letter>\w+)/.match(unscrubbed_name)
      # puts match_data.inspect
      return match_data[:name], match_data[:crn], match_data[:department_code], match_data[:course_number], match_data[:section_letter]
    end

    def stabalize(column)
      if column[0].text == "Instructors" && column[1].text.include?(',')
        stats = column[1].text.squeeze(' ').split(', ').collect(&:strip)
      elsif column[0].text == "Instructors"
        stats = column[1].text.squeeze(' ').strip
      else
        stats = column[1].text.strip
      end
    end

  end
end
