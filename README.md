# Waypoint Crucible

Implementing
http://codingdojo.org/kata/TradingCardGame/

For
http://agnostechvalley.com/

## The Plan

Bring in some elements from earlier katas and experiments and try to flesh out a complete game

Elixir on the server side

Vue and SVG on the client side

Make it multiplayer

Add timing to the equation, anybody can attack anyone at any time, but 

1) drawing a card takes one mana and limited by a timed interval
2) max mana accumulates over a timed interval
3) mana replentishes over a timed interval
4) if a deck is empty, damage is done via a timer
5) if you have 5 cards drawing another card automatically replaces the lowest card you have

Make it space combat, kind of a "Faster Than Light" clone, but with fleet combat and weapons from stars for the cards.

## A Sketch

![a layout](./design/WaypointCrucible.jpeg)

The story is that there is an errant WayPoint Jumpgate that sucks in everyone, only one can leave.

If there is time create bots

If there is time after that create a team play scenario where dogs in space suits are under Admiral Hope
and robots are under General Scum.

The human players are the dogs and need to try to cooperate to defeat the ai bots which might have personalities or strategies or both. (A personality might be how frequently you change your strategy (or to what) based on how frustrated you are or by other semi-arbitrary things such as a lack of success or a sense of patterns, even smack talk?)

Possibly add shields, which would be in the form of a second button to draw from your deck, you can draw a mistle or a shield either way the number is the same but the card that results will be either offensive or defensive, the defensive shield would fade in strength after a certain timeout period, say a point per second.

## Possible Strategies
    
    1) Offensive
    2) Defensive
    3) Shift between offensive and defensive based on
        * The absolute state of play
        * Because of patterns in others play
        * To shift our own pattern of play by some strategy
    
## State
    crucible
      maxMana:10
      maxHealth:30
      startingDeck:20
      startingHand: 0 | 3
      maxCards:5
      manaGrowthRate: 1 per 3 seconds
      manaReplentishRate: 1 per 1 second
      drawRate: 1 per 1 second
      fireRate: 2 per 1 second
      bleedOutRate: 1 per 2 seconds
      shieldDecayRate: 1 per 1 second
    
    waypoint
      status: "preparing" | "playing" | "complete"
      timer: "0"
      commands: []
      events: []
      players: []
      inFlight: []
      trajectory: 4 seconds
    
    player
      maxMana:10
      maxHealth:30
      maxCards:5
      startingDeck:20
      mana:0
      health:30
      shields:0
      cards:[]
      deck:[]
      drawEnabled: true
      bleedingOut: false
      alive: true
    
    cards
      0 nerfball | paper bag
      1 old rounds | golf umbrella
      2 bb bolt | elephant hide
      3 mini bolt | turtle shell
      4 magnum pod | flack jacket
      5 angry man | rage deflector
      6 mega bolt | mega absorber
      7 neutrino driver | neutrino barrier
      8 phase torpedo | phase shield
      
## Commands
    draw mistle
    draw shield
    play card target
      
## Modules

Ok so looking at the design what are the modules?

Lobby ( lists logged in users and tabletops(with summary info like number of players and state of play, allows users to create tabletops with a crucible game, or to join them

Game (rules - not instance data, that is in tabletop)

```
              game: {
                    rules:{
                        "maxMana": 10,
                        "maxHealth": 30,
                        "startingDeck": [0,0,1,1,2,2,2,3,3,3,3,4,4,4,5,5,6,6,7,8],
                        "startingHandSize": 0,
                        "maxCards":5,
                        "flightTime": 4000,
                        "manaGrowthInterval":1000,
                        "manaReplentishInterval":1000,
                        "drawInterval":1000,
                        "fireInterval":500,
                        "bleedoutInterval":1000,
                        "shieldDecayInterval": 1000
                    },
                    waypoint:{
                        "status": "PLAYING",
                        "winner": "Nobody",
                        "commands":[],
                        "events":[],
                        "players":[
                            {
                                "id":0,
                                "name":"General Scum",
                                "team":"Bad Guys",
                                "avatarImg": "../static/general_scum.png",
                                "maxMana":0,
                                "mana":0,
                                "maxHealth":30,
                                "health":30,
                                "shields":[],
                                "cards":[],
                                "selectedCardIndex":null,
                                "deck":[0,0,1,1,2,2,2,3,3,3,3,4,4,4,5,5,6,6,7,8],
                                "drawEnabled":false,
                                "isbleedingOut":false,
                                "isActive":true
                            }
                        ],
                        "inFlight":[]
                    },
                    avatars:[
                        { id: '0', name: 'General Scum', img: '../static/general_scum.png' },
                        { id: '1', name: 'Protobot', img: '../static/robot1.png' },
                        { id: '2', name: 'Streambot', img: '../static/robot2.png' },
                        { id: '3', name: 'Grammarbot', img: '../static/robot3.png' },
                        { id: '4', name: 'Lambdabot', img: '../static/robot4.png' },
                        { id: '5', name: 'Admiral Hope', img: '../static/admiral_hope.png' },
                        { id: '6', name: 'Cavalier', img: '../static/dog1.png' },
                        { id: '7', name: 'Mini Schnauser', img: '../static/dog2.png' },
                        { id: '8', name: 'Boston Terrier', img: '../static/dog3.png' },
                        { id: '9', name: 'Border Collie', img: '../static/dog4.png' } ,
                    ]
                },
                title: 'Waypoint Crucible',
                timeRunning: 0,
                timeStarted: 0,
                gameIntervalId: 0,
                manaIntervalId: 0,

               game: {
                    rules:{
                        "maxMana": 10,
                        "maxHealth": 30,
                        "startingDeck": [0,0,1,1,2,2,2,3,3,3,3,4,4,4,5,5,6,6,7,8],
                        "startingHandSize": 0,
                        "maxCards":5,
                        "flightTime": 4000,
                        "manaGrowthInterval":1000,
                        "manaReplentishInterval":1000,
                        "drawInterval":1000,
                        "fireInterval":500,
                        "bleedoutInterval":1000,
                        "shieldDecayInterval": 1000
                    },
                    waypoint:{
                        "status": "PLAYING",
                        "winner": "Nobody",
                        "commands":[],
                        "events":[],
                        "players":[
                            {
                                "id":0,
                                "name":"General Scum",
                                "team":"Bad Guys",
                                "avatarImg": "../static/general_scum.png",
                                "maxMana":0,
                                "mana":0,
                                "maxHealth":30,
                                "health":30,
                                "shields":[],
                                "cards":[],
                                "selectedCardIndex":null,
                                "deck":[0,0,1,1,2,2,2,3,3,3,3,4,4,4,5,5,6,6,7,8],
                                "drawEnabled":false,
                                "isbleedingOut":false,
                                "isActive":true
                            }
                        ],
                        "inFlight":[]
                    },
                    avatars:[
                        { id: '0', name: 'General Scum', img: '../static/general_scum.png' },
                        { id: '1', name: 'Protobot', img: '../static/robot1.png' },
                        { id: '2', name: 'Streambot', img: '../static/robot2.png' },
                        { id: '3', name: 'Grammarbot', img: '../static/robot3.png' },
                        { id: '4', name: 'Lambdabot', img: '../static/robot4.png' },
                        { id: '5', name: 'Admiral Hope', img: '../static/admiral_hope.png' },
                        { id: '6', name: 'Cavalier', img: '../static/dog1.png' },
                        { id: '7', name: 'Mini Schnauser', img: '../static/dog2.png' },
                        { id: '8', name: 'Boston Terrier', img: '../static/dog3.png' },
                        { id: '9', name: 'Border Collie', img: '../static/dog4.png' } ,
                    ]
                },
                title: 'Waypoint Crucible',
                timeRunning: 0,
                timeStarted: 0,
                gameIntervalId: 0,
                manaIntervalId: 0,
```

Tabletop (the manager of a game in execution with its state)
```
drawMistle: function(playerId){
    let player = this.game.waypoint.players[playerId];
    if(player.mana >= 1 && player.deck.length > 0) {
        let drawn = player.deck[0];
        player.cards.push(drawn);
        player.deck.splice(0, 1);
        player.mana--;
    }
},
drawShield: function(playerId){
    //let player = this.game.waypoint.players[playerId];
    //let shield = new Shield(player.deck[0]);
    //player.cards.push(shield);
    //player.deck.splice(0,1);
},
selectCard: function(playerId, cardIndex){
    let player = this.game.waypoint.players[playerId];
    player.selectedCardIndex = cardIndex;
},
targetPlayer: function (sourceId, targetId) {
    if (this.areEnemies(sourceId, targetId)){
        let sourcePlayer = this.game.waypoint.players[sourceId];
        if(sourcePlayer.selectedCardIndex !== -1) {
            let card = sourcePlayer.cards[sourcePlayer.selectedCardIndex];
            if(sourcePlayer.mana >= card){
                let targetPlayer = this.game.waypoint.players[targetId];
                sourcePlayer.mana -= card;
                sourcePlayer.cards.splice(sourcePlayer.selectedCardIndex, 1);
                sourcePlayer.selectedCardIndex = -1;
                this.launchMistle(sourcePlayer, targetPlayer, card)
            }
        }
    }
},
launchMistle: function(sourcePlayer, targetPlayer, card) {
    if(sourcePlayer.isActive){
        // eventually the timer might be different for different cards or mistles
        let sourcePlayerVm = this.$refs.helm.getPlayerVm(sourcePlayer.id);
        let targetPlayerVm = this.$refs.helm.getPlayerVm(targetPlayer.id);
        let sRect = sourcePlayerVm.$el.getBoundingClientRect();
        let tRect = targetPlayerVm.$el.getBoundingClientRect();
        this.game.waypoint.inFlight.push({
            id: new Date(),
            sourceX: sRect.left + sRect.width/2,
            sourceY: sRect.top  + sRect.height/2,
            targetX: tRect.left + tRect.width/2,
            targetY: tRect.top + tRect.height/2,
            card: card,
            flightTime: this.game.rules.flightTime
        });
        setTimeout(this.mistleImpact, this.game.rules.flightTime, sourcePlayer, targetPlayer, card);
    }
},
mistleImpact: function(sourcePlayer, targetPlayer, mistle){
    if(this.game.waypoint.status === "PLAYING") {
        targetPlayer.health = Math.max(0, targetPlayer.health - mistle);
        if (targetPlayer.health <= 0) {
            targetPlayer.isActive = false;
            //this.game.waypoint.winner = sourcePlayer.team;
            //this.endGame();
        }
    }
},
areEnemies: function(player1Id, player2Id){
    let p1 = this.game.waypoint.players[player1Id];
    let p2 = this.game.waypoint.players[player2Id];
    return (p1.team !== p2.team);
},
shuffle: function(array) {
    let remaining = array.length;
    let randomIndex;
    let last;

    while (remaining) {
        randomIndex = Math.floor(Math.random() * remaining--);
        last = array[remaining];
        array[remaining] = array[randomIndex];
        array[randomIndex] = last;
    }
    return array;
},
startGame: function() {
    var scope = this;
    this.game.waypoint.players.forEach(function(player){
        player.deck = scope.shuffle(player.deck);
    });
    this.timeStarted = Date.now();
    this.timeRunning = 0;
    clearInterval(this.gameIntervalId);
    clearInterval(this.manaIntervalId);
    this.gameIntervalId = setInterval(this.gameTick, 100);
    this.manaIntervalId = setInterval(this.manaTick, 1000);
},
gameTick: function() {
    this.timeRunning = Date.now() - this.timeStarted;
},
manaTick: function() {
    this.game.waypoint.players.forEach(function(player){
        if(player.maxMana < 10){
            player.maxMana++;
        }
        if(player.mana < player.maxMana){
            player.mana++;
        }
        if(player.deck.length <= 0 && player.cards.length === 0 && player.isActive){
            player.health--;
        }
    })
},
endGame: function() {
    this.game.waypoint.status = "OVER";
}
```

Helm (a player with a view of the other players)

Player

PlayerConsole

MistleInFlight  ["id", "sourceX", "sourceY", "targetX", "targetY", "card", "flightTime"]

Deck (just a sequence of numeric values that can become either shield or mistle cards at the choice of the player)

Hand (actual cards with a type after being drawn from the deck of values)

Cards (both shield and mistle cards, we'll start just with mistles)

Mistle (an instance of a card with a value for attack)

Shield (an instance of a card with a value for defense)


## Relevant References
    
[A book](https://pragprog.com/book/lhelph/functional-web-development-with-elixir-otp-and-phoenix)
[It's Source](https://pragprog.com/titles/lhelph/source_code)

    
[An article](http://theerlangelist.com/article/spawn_or_not)
[It's Repo](https://github.com/sasa1977/erlangelist/tree/dc7cd1d2c77e52fa0a3a90f269c0f4ca8cca908b/examples/blackjack)

    
[A Presentation](https://www.youtube.com/watch?v=xzY1C_O3gDk&index=6&list=PLE7tQUdRKcyaMEekS1T32hUw19UxzqBEo)
[It's Repo](https://github.com/JEG2/hanabi_umbrella#long-term-storage)


[A decent Medium Article](https://medium.com/@benhansen/lets-build-a-slack-clone-with-elixir-phoenix-and-react-part-1-project-setup-3252ae780a1)
[It's Repo](https://github.com/bnhansn/sling)

## To start:

  * Install dependencies with `mix deps.get`
  * Create and migrate the database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Visit [`localhost:4000`](http://localhost:4000) from your browser.

