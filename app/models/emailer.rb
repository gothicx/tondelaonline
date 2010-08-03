class Emailer < ActionMailer::Base
  def contact_email(email_params, sent_at = Time.now)
    @recipients = "gothicx@gmail.com"
    @from = email_params[:nome] + " <" + email_params[:email] + ">"
    @subject = "Tondela Online..."
    @sent_on = sent_at
    @body["email_mensagem"] = email_params[:mensagem]
    @body["email_nome"] = email_params[:nome]
    @body["email_email"] = email_params[:email]
  end
end
