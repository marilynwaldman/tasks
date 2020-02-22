defmodule TasksWeb.PowResetPassword.MailerView do
  use TasksWeb, :mailer_view

  def subject(:reset_password, _assigns), do: "Reset password link"
end
