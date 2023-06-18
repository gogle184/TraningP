class ContactsController < ApplicationController
  before_action :set_new_contact, only: %i(confirm create back)

  def new
    @contact = Contact.new
  end

  def confirm
    render 'new' if @contact.invalid?
  end

  def create
    if @contact.save
      ContactMailer.send_mail(@contact).deliver
      flash[:notice] = 'お問い合わせ内容を送信しました'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def back
    render :new
  end

  private

  def set_new_contact
    @contact = Contact.new(contact_params)
  end

  def contact_params
    params.require(:contact).permit(:email, :name, :content)
  end
end
