class QuotesController < ApplicationController

  def index
    @quotes = Quote.all :order => "datetime DESC", :limit => 1000
  end
end
