# proximity_nodes
connecting all dots using line vertex buffers, colored based on proximity!

## What it looks like

![alt text](https://github.com/GameMakerDiscord/proximity_nodes/blob/master/header.png)

## How it works
The project uses a frozen line-list vertex buffer, connecting every single point. Every vertex - or point - on a single line has information about the x,y origin and angle of travel of both itself and its partner (required to form a line).

To avoid point^2 connections every point is connected to all the others only once. The below image demonstrates this for a case using `n = 4` points, making for `((n-1)/2) * n = 6` connections.

![alt text](https://github.com/GameMakerDiscord/proximity_nodes/blob/master/explanation.png)