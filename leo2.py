import numpy as np

def get_map():
    p = '/Users/darcyluo/code/darcyluojt/Christmas challenge/Reboot-01-Christmas-list/data.txt'
    with open(p, 'r') as f:
        map = f.readlines()
    return [l[:-1] for l in map]

def get_fast_map(map):
    return np.array([[c == "#" for c in l] for l in map])

def print_map(map):
    for l in map:
        print(l)

DIRECTIONS ={
    1: np.array([-1, 0]), # up
    2: np.array([0, 1]), # right
    4: np.array([1, 0]), # down
    8: np.array([0, -1]) # left
}

ROTATIONS = {
    1:2,
    2:4,
    4:8,
    8:1,
}
def rotat(direction):
    return ROTATIONS[direction]

def print_history(array):
    for row in array:
        binary_row = [np.binary_repr(x, width=8)[-4:] for x in row]
        print(" ".join(binary_row))

def is_position_in(position, m, n):
    return 0 <= position[0] < m and 0 <= position[1] < n

def navigate(map, start_position, check_loops = False):
    m,n = map.shape # dimensions of the map
    history = np.zeros((m,n), dtype=np.int8) # record where we've been and whar direction
    p = start_position
    direction = 1
    while True:
        if history[p[0], p[1]] & direction:
            # We've been here before in this direction
            # There is a loop
            return True

        # Record the current position and direction
        history[p[0], p[1]]|= direction

        next_position = p + DIRECTIONS[direction]
        if is_position_in(next_position, m, n):
            if map[next_position[0], next_position[1]]:
                direction = rotat(direction)
            else:
                p = next_position
        else:
            break

    if check_loops:
        return False

    return history

def find_start(string_map):
    start_position = None
    m,n = len(string_map), len(string_map[0])
    for i in range(m):
        for j in range(n):
            if string_map[i][j] == "^":
                start_position = (i,j)
                break
        if start_position:
            break
    assert start_position, "No starting position found"
    return start_position

def main():
    string_map = get_map()
    map = get_fast_map(string_map)

    print("Start position:")
    start_position = find_start(string_map)
    print(start_position)

    import time
    start_time = time.time()

    path = navigate(map, start_position)

    n_loops = 0
    m,n = map.shape
    for i in range(m):
        print(i)
        for j in range(n):
            if not path[i,j]:
                continue
            if (i,j) == start_position:
                continue

            map[i,j] = True
            loops = navigate(map, start_position, check_loops=True)
            if loops:
                n_loops += 1
            map[i,j] = False

    path_size = navigate(map, start_position)

    end_time = time.time()

    print("Time taken: ", end_time - start_time)
    print(path_size)

    print("Number of loops: ", n_loops)

if __name__ == '__main__':
    main()
