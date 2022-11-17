# Observe game phase
/lol-gameflow/v1/gameflow-phase
```plain
// One of
Lobby
ChampSelect
GameStart
InProgress
WaitingForStats
PreEndOfGame
EndOfGame
```

# Auto Accept Game
Lcu event: /lol-matchmaking/v1/ready-check

## Accept
POST /lol-matchmaking/v1/ready-check/accept

## Decline
POST /lol-matchmaking/v1/ready-check/decline