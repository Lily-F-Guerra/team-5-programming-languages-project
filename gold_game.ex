defmodule GoldGame do
  def play(gold) do
    num1 = Enum.random(1..10)
    num2 = Enum.random(1..10)

    {op_symbol, operation} =
      Enum.random([
        {"+", fn a, b -> a + b end},
        {"-", fn a, b -> a - b end},
        {"*", fn a, b -> a * b end},
        {"/", fn a, b -> div(a, b) end}, #div makes answer integer (using floor division)
      ])

    IO.puts("\n🧠 Answer this to earn gold!")
    answer = IO.gets("What is #{num1} #{op_symbol} #{num2}? ") |> String.trim()

    case Integer.parse(answer) do
      {int_answer, _} ->
        correct = operation.(num1, num2)

        if int_answer == correct do
          reward = Enum.random(10..30)
          IO.puts("✅ Correct! You earned #{reward} gold!")
          gold + reward
        else
          IO.puts("❌ Wrong! The correct answer was #{correct}. No gold for you.")
          gold
        end

      :error ->
        IO.puts("⚠️ Please enter a number.")
        gold
    end
  end
end
