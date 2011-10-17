
def fun( f1, f2 )
  f1.call :f1a
  f2.call :f2a
end

fun(
  lambda{ |a|
    puts "first-#{a}"
  },
  lambda{ |a|
    puts "second-#{a}"
  }
)