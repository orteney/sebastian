# Lcu event example
```json
[
  8,
  "event_name",
  {
    "data":"event_data",
    "eventType":"Update",
    "uri":"event_uri"
  }
]
```

# Observe game phase
Lcu event: `OnJsonApiEvent_lol-gameflow_v1_gameflow-phase`
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

# Observe pick session
Lcu event: `OnJsonApiEvent_lol-champ-select_v1_session`

# Auto Accept Game Feature
Lcu event: `OnJsonApiEvent_lol-matchmaking_v1_ready-check`
```json
{
  "declinerIds": [],
  "dodgeWarning": "None",
  "playerResponse": "None", // Declined
  "state": "InProgress", // PartyNotReady
  "suppressUx": false,
  "timer": 9.0
}
```

## Accept
`POST /lol-matchmaking/v1/ready-check/accept`

## Decline
`POST /lol-matchmaking/v1/ready-check/decline`