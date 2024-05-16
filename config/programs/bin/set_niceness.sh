#!/bin/bash

# Array of game-related executables
GAME_EXECUTABLES=("BH3.exe" "ZFGameBrowser.exe")

for EXECUTABLE in "${GAME_EXECUTABLES[@]}"; do
	# Find the PIDs of the game-related executables
	PIDS=$(ps aux | grep "$EXECUTABLE" | grep -v grep | awk '{print $2}')

	# Change the niceness level for each found PID
	for PID in $PIDS; do
		sudo renice -n -15 -p $PID
		echo "Niceness level for $EXECUTABLE (PID $PID) set to -15"
	done
done
