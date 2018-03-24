function prime(x::Integer)
    if x<2
        return false
    end
    for n in 1:floor(Integer,sqrt(x))
        if gcd(n,x)>1
            return false
        end
    end
    return true
end

# nth prime is bound above by n*(log(n)+log(log(n)))
prime_upperbound(n::Integer) = ceil(Integer,n*(log(n)+log(log(n))))

# nth prime is bound below by n*(log(n)+log(log(n))-1)
prime_lowerbound(n::Integer) = floor(Integer,n*(log(n)+log(log(n))-1))

function seive(n::Integer)
    seive=trues(n)
    seive[1]=false
    for i in 2:n
        if seive[i]
            for j in 2:div(n,i)
                seive[i*j]=false
            end
        end
    end
    return find(seive)
end

# requires seive
function primefactors(n::Integer)
    n>1 || return
    primes=seive(round(Integer,sqrt(n)))
    len=ceil(Integer,log(2,n))
    container=zeros(Integer,len)
    container[1]=n
    for i in 1:len
        if container[i]==0
            break
        end
        bnd=round(Integer,sqrt(container[i]))
        for j in primes
            j > bnd && break
            if rem(container[i],j)==0
                container[i+1]=div(container[i],j)
                container[i]=j
                break
            end
        end
    end
    return container[1:sum(x->iszero(x)?0:1,container)]
end

# requires seive, primefactors
using StatsBase: countmap
primefactorization(n::Integer) = countmap(primefactors(n))

# requires seive, primefactors, primefactorization
function numofdivisors(n::Integer)
    abs(n)>1 || return 1
    factormap=primefactorization(n)
    acc=1
    for k in keys(factormap)
        acc*=factormap[k]+1
    end
    return acc
end

function inv(x::Integer,n::Integer)
    if gcd(x,n)>1
        return NaN
    end
    for i in 1:n-1
        if mod(x*i,n)==1
            return i
        end
    end
end

function two_to_the_n_minus_1_primes(n::Integer)
    acc=Array{Int64}(n)
    i=0
    x=1
    while i<n
        x+=1
        if prime(2^x-1)
            i+=1
            acc[i]=2^x-1
        end
    end
    return acc
end
