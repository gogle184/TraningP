class ContactsController < ApplicationController
  before_action :set_new_contact, only: [:confirm, :create, :done]

  def new
    @contact = Contact.new
  end

  def confirm
    if @contact.invalid?
      render 'new'
    end
  end

  def create
    if @contact.save
      ContactMailer.send_mail(@contact).deliver
      flash[:notice] = "お問い合わせ内容を送信しました"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def done
  end

  private
  
  def set_new_contact
    @contact = Contact.new(contact_params)
  end

  def contact_params
    params.require(:contact).permit(:email, :name, :content)
  end
end
