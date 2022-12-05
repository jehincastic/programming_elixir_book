nested = %{
  buttercup: %{
    actor: %{
      first: "Robin",
      last: "Wright"
    },
    role: "princess"
  },
  westley: %{
    actor: %{
      first: "Cary",
      last: "Elwes"
    },
    role: "farm boy"
  }
}

IO.inspect(get_in(nested, [:buttercup]))
IO.inspect(get_in(nested, [:buttercup, :actor]))
IO.inspect(get_in(nested, [:buttercup, :actor, :first]))
IO.inspect(put_in(nested, [:westley, :actor, :last], "Elwes"))

# get_in and get_and_update_in supports if we pass a function as a key,
# that function is invoked to return the corresponding values.
authors = [
  %{name: "José", language: "Elixir"},
  %{name: "Matz", language: "Ruby"},
  %{name: "Larry", language: "Perl"}
]

languages_with_an_r = fn(:get, collection, next_fn) ->
  for row <- collection do
    if String.contains?(row.language, "r") do
      next_fn.(row)
    else
      next_fn.(%{name: "Not Matched"})
    end
  end
end

IO.inspect get_in(authors, [languages_with_an_r, :name])
