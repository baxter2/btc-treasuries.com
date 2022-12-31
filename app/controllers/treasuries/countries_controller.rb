class Treasuries::CountriesController < ApplicationController
  def index
    view_object = Treasuries::Entities.new("Country").call
    render locals: view_object.locals
  end
end
