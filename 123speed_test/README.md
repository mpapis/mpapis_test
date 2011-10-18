= Speed test =

Testing multiple invocation overhead

== Direct call ==

    $ time /bin/echo ./ruby
    ./ruby
    
    real0m0.003s
    user0m0.000s
    sys0m0.003s


== Call via multiple invocations ==

    $ time ./ruby 
    ./ruby
    
    real0m0.014s
    user0m0.007s
    sys0m0.006s

== Summary ==

It is very small overhead to just run it - assuming no other logic involved
