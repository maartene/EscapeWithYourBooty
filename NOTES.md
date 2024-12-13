# Pomodoro Technique - 📝 Notes from the journey 🍅 by 🍅

## 🏷️ Labels

- ✅ done
- 🚧 WIP
- ❌ ERROR
- ⚠️ TODO

## 🍅 Pomodoro 1

- ✅ A sea of size 1x1 with only our ship (no navy) -> Safe [X]
    X -> Safe
- ✅ An unsafe route with a navy shipp -> Unsafe [X,N]
    XN -> Unsafe
- ✅ A sea of size 2x2 with only our ship (no navy) -> Safe [[X,0],[0,0]]
    X0
    00 -> Safe
  
## 🍅 Pomodoro 2
- ✅ A safe route with a navy ship with single turn
    Turn 1
    X
    0
    N
    (there's no turn 2)

## 🍅 Pomodoro 3

- ✅ An unsafe route with a navy ship
    Turn 1
    X0
    0N
    (there is no turn two)
    
- ✅ Another unsafe route with a navy ship Turn 1 
    0N
    X0
    (there is no turn two)

- Ship surroundings are the spaces around a ship

- ✅ Determine the shipsurroundings based on the ship position
- ✅ Deal with out of bound indexes
- ✅ Add the full list of possible ship surroundings
- ✅ Find the ship position instead of hardcoding

    
## 🍅 Pomodoro 3
- ✅ Extract method for determining surroundings
- ✅ Creat typealias for (Int, Int)
- ⚠️ Refactor test with newly discovered names for things
- ⚠️ Object Calisthenics --> Extracting  building blocks
    - Sea as an object
    - Coordinate as an object
- ⚠️ For now we assumed that all see rows have the same length


- ⚠️ Another unsafe route with a navy ship Turn 1 
    NN
    XN
    (there is no turn two)

- ⚠️ 
    Turn 1
    X0N
    000
    000
    
- ⚠️
    Turn 1
    X0
    00
    00
    N0
    
    Turn 2
    0X
    00
    N0
    00
- ⚠️ Write failing test that shows the coordintes being swapped
    
## Acceptance test (this is what we're aiming for)
// Example test of a safe route (that has navy in it)
// Turn 0
X00N
0000
0000
0000
// Turn 1
0X00
000N
0000
0000
// Turn 2
00X0
0000
000N
0000
// Turn 3
000X
0000
0000
000N
// Should return true (since it's safe)
