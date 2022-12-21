My submission for short code for day 18. It uses 163 bytes.

Running:
    cat <input_file> | python3 day18.py

Documentation:
    l=[eval(f'[{s}]')for s in sys.stdin]
This reads strings (s) from the input file into a list of voxels (3D pixels) of lava(l).

    print(sum(list(map(sum,zip(v,d)))not in l
    for v in l
    for d in[[0,0,1],[0,0,-1],[0,1,0],[0,-1,0],[1,0,0],[-1,0,0]]))
This part 'for v in l for d in[[0,0,1],[0,0,-1],[0,1,0],[0,-1,0],[1,0,0],[-1,0,0]]' loops through the voxels (v) of the lava (l) and through the 6 directions (d).
This part 'list(map(sum,zip(v,d)))' calculates the position of a neighbour given voxel (v) and direction(d).
This part '... not in l' then checks if that neighbour is in the lava (l). If this is not true it means we found a surface with lava on one side and air on the other.
This part 'print(sum(...))' sums those booleans and prints the count of surfaces we found.
