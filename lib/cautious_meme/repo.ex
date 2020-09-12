defmodule CautiousMeme.Repo do
  use Ecto.Repo,
    otp_app: :cautious_meme,
    adapter: Ecto.Adapters.MyXQL
end
