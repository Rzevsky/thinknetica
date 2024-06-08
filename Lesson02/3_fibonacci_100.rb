# Заполнить массив числами фибоначчи до 100

def fibonacci_up_to(lim)
  return nil if lim.zero?
  return [0] if lim == 1
  return [0, 1] if lim == 2

  fib = [0, 1]
  loop do
    fib[-1] + fib[-2] > lim ? break : fib << fib[-1] + fib[-2]
  end
  fib
end

puts fibonacci_up_to(100).inspect
