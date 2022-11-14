function create_grid(N=9)
    zeros(Int32, N, N)
end

function next_number_in_seq(n, N)
    if n < N
        return n+1
    else
        return 1
    end
end

# main code

struct Grid
    Z::Int64
    N::Int64
    G::Array{Int32}
    M::Array{Set}
end



N = 25

function gen_valid_grid(N)
    G = create_grid(N)
    sqrtN = Int(sqrt(N))

    next_num(n) = next_number_in_seq(n, N)

    num = 0
    for i in 1:N
        for j in 1:N
            num = next_num(num)
            G[i,j] = num
        end
        for r in 1:sqrtN
            num = next_num(num)
        end
        if 0 == i % sqrtN
            num = next_num(num)
        end
    end

    return G
end

is_num(n) = n > 0

"Check if set of numbers is not repeated"
function valid_num_set(L)
    filtered_L = filter(is_num, L)
    size(filtered_L) == size(unique(filtered_L))
end

getN(G) = size(G)[1]
getZ(G) = Int(sqrt(getN(G)))

"In a regular sudoku returns the nth square going in row-major order (1:9)"
function get_nth_square(n, G)
    N = getN(G)
    Z = getZ(G)

    if n > N || n < 1
        throw("ERROR!")
    end

    square_i = Int(ceil(n/Z))
    square_j = (n-1) % Z + 1

    i_a = 1+(square_i-1)*Z
    i_b = i_a + (Z-1)

    j_a = 1+(square_j-1)*Z
    j_b = j_a + (Z-1)

    G[i_a:i_b, j_a:j_b]
end

function get_corresponding_square(r, c, G)
    Z = getZ(G)
    sq(l) = Int(ceil(l/Z))
    a(l) = (sq(l) - 1) * Z + 1
    b(l) = a(l) + Z - 1

    G[a(r):b(r), a(c):b(c)]
end



"""Asserts that the numbers on the grid are valid (no repetitions)."""
function is_grid_valid_solution(G)
    N = size(G)[1]
    sqrtN = Int(sqrt(N))

    for row in 1:N
        if ! valid_num_set(G[row,:])
            return false
        end
    end
    for col in 1:N
        if ! valid_num_set(G[:,col])
            return false
        end
    end

    for n in 1:N
        if ! valid_num_set(get_nth_square(n, G))
            return false
        end
    end
    return true
end

G = gen_valid_grid(N)


M = fill(Set(1:N), N, N)


function create_grid_Z(Z::Int64)
    N = Z^2
    G = fill(0, N, N)
    M = fill(Set(1:N), N, N)

    Grid(Z, N, G, M)
end


function update_M(grid)
    for r in 1:grid.N
        for c in 1:grid.N
            grid.G
        end
    end
end


print(is_grid_valid_solution(G))
