class AppController < ApplicationController
  def all
  end

  def contacts
    render :json => Contact.find(params[:id]).contact_numbers
  end

  def contactsjson
    @contacts = Contact.order('lastName, firstName')
    render :json => @contacts.to_json(include: :contact_numbers)
  end
end
