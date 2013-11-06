class StaticController < ApplicationController

  def index
  end

  def update
    sm = StaticHelper::SMParser.new
    sm.noko_parse
    sm.create_class_nodes
    sm.build_classes
    @yaml = sm.classes.to_yaml

    classes = sm.classes

    classes.each do |class_name,section_array|
      
    end

    respond_to do |format|
      format.html #{ redirect_to static_url, notice: 'Classes generated'}
    end
  end
end
