class StaticController < ApplicationController

  def index
  end

  def update
    sm = StaticHelper::SMParser.new
    sm.noko_parse
    sm.create_class_nodes
    sm.build_classes
    @yaml = sm.classes.to_yaml

    respond_to do |format|
      format.html #{ redirect_to static_url, notice: 'Classes generated'}
    end
  end
end
