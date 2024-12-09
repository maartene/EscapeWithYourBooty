# EscapeWithYourBooty
Link: https://www.codewars.com/kata/escape-with-your-booty

Description

You are the Navigator on a pirate ship which has just collected a big haul from a raid on an island, but now you need to get home! Your captain has given you an intended course for your passage from the island - but the Royal Navy is on patrol! you need to tell your captain whether you will be able to make it home without being caught.

Task

You are given an array of arrays depicting the path back to your home from the island. Your ship will always start on the left most edge, and your ship will travel one space to the right each turn. The course is true if you can reach the right hand edge. To make things difficult, Royal Navy Ships are patrolling the passage. They start on the bottom and top most edges of the the passage - ones on the top move one space down each turn, and ones on the bottom move one space up each turn. when these ships reach the edge of the map, then on the next turn they reverse their direction and move one space (i.e. the every ship always moves one space each turn).

Evaluate the array at the start of each turn once every ship has moved. If any of the adjacent spaces around your ship contain a Royal Navy patrol (including diagonals), then return false as this passage is unsafe! Also, if your ship starts adjacent to a Navy ship then return false.

you are given an MxN array (it could be square) which contains:

X - The location of your ship

N - The location of a Navy ship

0 - An empty ocean space

Example

Here's an array at turn 0 when you will recieve it.

0,N,0,N,0
0,0,0,0,0
X,0,N,0,0
at the end of turn 1 it looks like:

0,0,0,0,0
0,N,N,N,0
0,X,0,0,0
At this point return false as your ship has been caught!


## In our own words
- Objective: are we on a safe route?
- We get a configuration of sea, our ship and navy ships
- We tell: is that a safe route
- What is a route? 
The journey of our ship from one side to the other. Moving W -> E?
- Navy ships that start at the bottom move to the top
- Navy shops that start at the top move to the bottom
- Once a navy ship reaches the other end, it turns around
- The route is NOT SAFE if AT ANY POINT during your route you meet a navy ship
- Knowing if a route is NOT SAFE is the most valuable

## Example safe routes
- A sea without navy

## Example unsafe routes

## Term of Art
- Route: A row in the sea from left to right
- Patrol: A column in the sea

