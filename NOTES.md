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
- 🚧 A sea of size 2x2 with only our ship (no navy) -> Safe [[X,0],[0,0]]
  X0
  00 -> Safe

### Acceptance test
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
