function f(x,y)
    x+y
end

f(1,2)

g(x,y) = x + y

g(1,3)

map(round, [1.2,3.5,1.7])




round.([1.2,3.5,1.7])



# function example(referenced only by position; referenced only by name)
# function example(Arg, OptionalArg, VarArgs...; KwdArg, KwdArgs...)
function example(arg1, arg2, optional1="a", optional2="b", varargs...; kwdarg1="α", kwdarg2="β", kwdargs...)
    arg1, arg2, optional1, optional2, varargs, kwdarg1, kwdarg2, kwdargs
end

example(a="1",1,2,optional1="qwerty",3,b="2",4,5,6,7,c="3",optional2="asdfgh")

# (1, 2, 3, 4, (5, 6, 7), "α", "β", Any[5]                  )
#                                    (:a, "1")
#                                    (:optional1, "qwerty")
#                                    (:b, "2")
#                                    (:c, "3")
#                                    (:optional2, "asdfgh")






b="b"
v1(a=b, b=1) = a, b; v1()
v2(b=1, a=b) = a, b; v2()
k1(;a=b, b=1) = a, b; k1()
k2(;b=1, a=b) = a, b; k2()
k3(;a=b, c=1) = a, c; k3()
vk1(a=b; b=1) = a, b; vk1()
vk1(b=1; a=b) = a, b; vk1()
# var eval(L_to_R) --> var in scope --> kwd in scope --> kwd eval(L_to_R)


function oneliner(x,y); z=3; z+x+y; end
oneliner(0,0)

begin # code block
    a=3
    b=2
    c=1
    a+b+c
end

(a=3; b=2; c=1; a+b+c) # code block


function test1(x,y) # scope of if blocks are "leaky"
    if x>y
        rel="gt"
    elseif x<y
        rel="lt"
    else
        rel="eq"
    end
    "$x $rel $y"
end
test1(1,3)

function test2(x,y) # if blocks return the last eval result
    rel=(if x>y
            "gt"
         elseif x<y
            "lt"
         else
            "eq"
         end)
    "$x $rel $y"
end
test2(1,3)

function test3(x,y) # the tenary conditional operator " ? : " can be composed
    rel=(x>y ? "gt" : x<y ? "lt" : "eq") # associates from right to left
    "$x $rel $y"
end
test3(1,3)


### short circuit evaluation

true && true && "yes"
true && false && "yes"
true && "yes" && "yes"
# cond1 && cond2 && exp

false || false || "no"
false || true || "no"
false || "no" || "no"
# cond1 || cond2 || exp

### only boolean values may appear at conditionals

# nested for loops con be merged into a single one
for i in 1:2, j in 3:4
    println((i, j))
end
# the result of ↑ is equivalent to the result of ↓
for i in 1:2
    for j in 3:4
        println((i, j))
    end
end
# however, in the merged format, break statements exit the entire merged loop
