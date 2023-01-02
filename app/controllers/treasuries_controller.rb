class TreasuriesController < ApplicationController
  def index
    view_object = Treasuries::All.new.call
    render locals: view_object.locals
  end
end
