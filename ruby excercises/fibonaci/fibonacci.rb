def fib(number)
  result = [0, 1]

  (number - 2).times { |_numb| result << result[-2] + result[-1] }

  result
end

def fibs_rec(number)
  return [0, 1] if number == 1

  array = fibs_rec(number - 1)

  array << array[-2] + array[-1]
end



p fibs_rec(20)
