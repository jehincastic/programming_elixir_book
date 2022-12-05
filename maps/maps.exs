map = %{name: "David", likes: "Programming", where: "Dallas"}

IO.inspect Map.keys(map)
IO.inspect Map.values(map)
IO.puts map[:name]
IO.puts map.name
IO.puts map[:names] # equals nil
# IO.puts map.names -> throws err

map1 = Map.drop map, [:where, :likes, :from]
IO.inspect map1
map2 = Map.put map, :from, "USA"
IO.inspect map2
IO.inspect Map.has_key?(map, :from)
IO.inspect Map.has_key?(map, :where)
{_value, _updated_map} = Map.pop map2, :also_like
{value, updated_map} = Map.pop map2, :from
IO.inspect(value)
IO.inspect(updated_map)
IO.inspect Map.equal? map, updated_map

IO.puts("************************")
IO.puts("************************")
IO.puts("************************")
IO.puts("************************")

person = %{name: "David", height: 1.88}
# Is there an entry with the key :name?
%{name: a_name} = person
IO.puts a_name

# Are there entries for the keys :name and :height?
%{name: _, height: _} = person

# Does the entry with key :name have the value "David"?
%{name: "David"} = person

# %{ name: _, weight: _ } = person -> This failse because there is no weight property

people = [
  %{name: "Grumpy", height: 1.24},
  %{name: "Dave", height: 1.88},
  %{name: "Dopey", height: 1.32},
  %{name: "Shaquille", height: 2.16},
  %{name: "Sneezy", height: 1.28},
]

filtered_person = for person = %{ height: height } <- people, height > 1.5, do: person

IO.inspect filtered_person

defmodule HotelRoom do
  def book(%{name: name, height: height}) when height > 1.9 do
    IO.puts("Needs extra-long bed for #{name}")
  end

  def book(%{name: name, height: height}) when height < 1.3 do
    IO.puts("Needs lower shower controls for #{name}")
  end

  def book(person) do
    IO.puts("Need regular bed for #{person.name}")
  end
end

people |> Enum.each(&HotelRoom.book/1)
# people |> Enum.each(&HotelRoom.book(&1))

# Pattern Matching Can’t Bind Keys
%{ 2 => state } = %{ 1 => :ok, 2 => :error }
IO.puts "state => :#{state}"

# %{ key => :ok } = %{ 1 => :ok, 2 => :error }
# illegal use of variable item in map key

data = %{ name: "Dave", state: "TX", likes: "Elixir" }

values = for key <- [:name, :likes] do
  %{ ^key => value } = data
  value
end

IO.inspect values

old_map = %{ name: "Desmond", age: 22, dob: nil }
new_map = %{ old_map | age: 23, dob: "10-04-1999" } # this works only for updating keys in a map
IO.inspect old_map
IO.inspect new_map

defmodule Subscriber do
  defstruct name: "", paid: false, over_18: true

  def main do
    s1 = %Subscriber{}
    IO.inspect s1
    s2 = %Subscriber{name: "Desmond"}
    IO.inspect s2
    s3 = %Subscriber{name: "Desmond", paid: true}
    IO.inspect s3
    # s4 = %Subscriber{name: "Desmond", paid: true, age: 120} throws error as age is not a field of struct
    IO.puts s3.name
    %{name: a_name} = s3
    IO.puts a_name
    %Subscriber{name: a_name} = s3
    IO.puts a_name
    s4 = %Subscriber{s3 | name: "Miles"}
    IO.inspect s4
  end
end

Subscriber.main


defmodule Attendee do
  defstruct name: "", paid: false, over_18: true

  def may_attend_after_party(attendee = %Attendee{}) do
    attendee.paid && attendee.over_18
  end

  def print_vip_badge(%Attendee{name: name}) when name != "" do
    IO.puts "Very cheap badge for #{name}"
  end

  def print_vip_badge(%Attendee{}) do
    raise "missing name for badge"
  end

  def main(name, over_18 \\ true, paid \\ false) do
    a1 = %Attendee{name: name, over_18: over_18, paid: paid}
    if Attendee.may_attend_after_party(a1) do
      Attendee.print_vip_badge(a1)
    else
      IO.puts "Not allowed to attend after party"
    end
  end
end

Attendee.main("Desmond", true, true)
Attendee.main("Desmond", false, true)
Attendee.main("Desmond", true, false)

defmodule Customer do
  defstruct name: "", company: ""
end

defmodule BugReport do
  defstruct owner: %Customer{}, details: "", severity: 1

  def main do
    report = %BugReport{owner: %Customer{name: "Dave", company: "Pragmatic"}, details: "broken"}
    IO.inspect report
    new_report = %BugReport{ report | owner: %Customer{ report.owner | company: "PragProg" } }
    IO.puts "Owner name => #{new_report.owner.name}"
    IO.puts "Company Name => #{new_report.owner.company}"
    new_report = put_in(report.owner.company, "PragProg")
    IO.inspect new_report
    IO.puts "Owner name => #{new_report.owner.name}"
    IO.puts "Company Name => #{new_report.owner.company}"
    new_report = update_in(report.owner.name, &("Mr. " <> &1))
    IO.puts "Owner name => #{new_report.owner.name}"
  end
end

BugReport.main

report = %{ owner: %{ name: "Dave", company: "Pragmatic" }, severity: 1}
IO.inspect put_in(report[:owner][:company], "PargProg")
# IO.inspect put_in(report[:owners][:company], "PargProg") -> throws an error
IO.inspect update_in(report[:owner][:name], &("Mr. " <> &1))
