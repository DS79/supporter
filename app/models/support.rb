class Support < ActiveRecord::Base
  validates :name, :email, 
               presence: {message: "must be provided"}

  def self.search(query)
    where("name LIKE ?", "%#{query}%")  
  end    
  require 'will_paginate'

end
