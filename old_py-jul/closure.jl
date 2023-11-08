x = 0  # global
function toplevel(y)
    function closure(v)
        println("v = ", v, " is a parameter")
        w = 3
        println("w = ", w, " is a local variable")
        println("x = ", x, " is a global variable")
        println("y = ", y, " is a closed variable (a parameter of the outer function)")
        println("z = ", z, " is a closed variable (a local of the outer function)")
    end

    println("x = ", x, " is a global variable")
    println("y = ", y, " is a parameter")
    z = 2
    println("z = ", z, " is a local variable")

    return closure
end

c = toplevel(10)
println()
c(11)
println()
function testclosure()
    c = toplevel(12)
    println()
    c(12)
end

testclosure()