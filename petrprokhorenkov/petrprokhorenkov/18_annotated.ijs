NB. Reading full stdin as an array of bytes. Verb 'Foreign' (!:) is used to access foreign functions,
NB. 1 to the left of if means the set of foreign functions dealig with I/O, 1 to the right means
NB. the function with number 1, which is 'read file'. 3 means stdin which makes little sense IMO :)
NB. And yes, there are no symbolic names for these functions, you just have to either remember the numbers
NB. or look them up in the manual.
raw_input =. (1 !: 1) 3

NB. Break input into lines and parse numbers. Here we first use the abverb 'Intervals' (;.) which
NB. breaks an array into subarrays. _2 to the right of it means negative two. This means
NB. 'split the array using its last element as a separator and do not include the separator into the subarrays'.
NB. In our case the last symbol is a newline, so we break the array into the lines.
NB. Then the verb 'Do' (".) comes into play. Believe it or not, but it is basically an 'eval' function which
NB. is a common way of parsing input in J. Ex. '1,2,3' will evaluate as an array of [1,2,3]. You can spell the same
NB. array just as '1 2 3'. Comma in J is the verb 'Append', so here we are joining three arrays, each of length one
NB. to get an array of three elements.
NB. (".) is an argument to the (;.) adverb which means it gets applied to every of the subarrays.
NB. As a result we get an n by 3 matrix of coordinates. Neat.
coords =. ". ;. _2 raw_input

NB. Create a 3d matrix representing free cells. We use the operator 'Shape' ($) twice.
NB. 3 $ 99 means shaping the array [99] to have length 3. J does that by repeating the elements of the array,
NB. so we get [99, 99, 99]. The second ($) shapes [1] into a 99 by 99 by 99 matrix.
NB. The result is such a matrix filled with ones.
free_cells =. ( 3 $ 99 ) $ 1

NB. Put zeros at the occupied cells coords. We use 'Amend' (}) adverb which takes the list of indices and
NB. replaced items of the right argument with this coords with its lets argument (zero).
free_cells =. 0 coords} free_cells

NB. Generate offsets to all the neighbors of a cell.
NB. This is just a 6 by 3 matrix: [[1, 0, 0], [0, 1, 0], [0, 0, 1], [-1, 0, 0], [0, -1, 0], [0, 0, -1]]
NB. This way we get this matrix using much fewer characters than by typing it explicitly.
NB. You can see that this is a 3 by 3 identity matrix concatenated with the same matrix with a flipped sign.
NB. 1. Use the 'Integers' (i.) verb to get list of integers less than 3: [0, 1, 2]
NB. 2. Use the 'Raze In' (e.) verb which in this case basically makes a comparison matrix of the list with
NB.     itself, meaning the identity matrix 3 by 3.
NB. 3. Use a fork. When you write three verbs in a row like 'f g h' you get a fork, which acts like a composition
NB.     of them: (f g h)(arg) = g(f(arg), h(arg)). In our case the fork consists of verbs 'Same' ([) which just
NB.     returns its argument, 'Append' (,) which appends two arrays, and 'Negate' (-) which flips the signs of the
NB.     elements of its argument. In effect this means concat the argument with its negation, just what we need.
offsets =. ([ , -) e. i. 3

NB. Apply offsets to our array using the 'Rotate' (|.) verb. For each of the offsets we get a copy of the free_cells
NB. Which was cyclically rotated to the given direction. Note how we do not care that this is a rotation and not a shift
NB. because our cells do not touch the both borders on any of our matrix dimensions at the same time.
NB. There is a 'Shift' verb (|.!.f) but you can see how longer it is and this is a code golf submission after all.
offset_cells =. offsets |. free_cells

NB. Compute the number of the free neighbors by summing all the offset matrices.
NB. We use 'Insert' (/) adverb with 'Plus' (+) verb. Insert turns a binary operation into an operation that acts on an array.
free_neighbors =. +/ offset_cells

NB. Select the cells at the given coordinates from the accumulated matrix
NB. We use the verb 'From' ({) to get an array of elements at the given indices.
NB. The only problem here is that we have to put indices of each individual elements into a 'box' first.
NB. No problem, we have 'Box (<) verb just for that. But it would put all the n by 3 matrix into a single box, which is not
NB. what we want here. We need to use 'Rank' (") adverb to convince it to become a rank-1 verb, meaning it switches from the
NB. default 'whatever the argument is, but it into a box' to the 'assume the input is a 1-dimensional array and box each of
NB. the array items individually'. In our case, each row of the coords matrix gets its own box.
free_neighbor_counts =. (< "1 coords) { free_neighbors

NB. Just sum the numbers in the array, just as above.
result =. +/ free_neighbor_counts

NB. Write result to the stdout. The same verb 'Foreign' (!:) is at play. We use the same I/O set of functions, but the function
NB. number two which is 'write file' with the argument 2 which means stdout. Note that J takes care of conversion of number
NB. to a string for us.
result (1 !: 2) 2
