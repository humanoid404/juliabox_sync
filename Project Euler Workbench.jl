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

using StatsBase: countmap
primefactorization(n::Integer) = countmap(primefactors(n))

function numofdivisors(n::Integer)
    abs(n)>1 || return 1
    factormap=primefactorization(n)
    acc=1
    for k in keys(factormap)
        acc*=factormap[k]+1
    end
    return acc
end


prime_upperbound(n::Integer) = ceil(Integer,n*(log(n)+log(log(n))))

function divisors(n::Integer)
    n==0 && return Array{Integer}(0)
    abs(n)==1 && return ones(Integer,1)
    factormap=primefactorization(n)
    len=length(factormap)
    primes=seive(prime_upperbound(len))[len]
    
    for
