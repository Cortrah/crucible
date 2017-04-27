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

The story is that there is an errant WayPoint Jumpgate that sucks in everyone, only one can leave.

If there is time create bots

If there is time after that create a team play scenario where dogs in space suits are under Admiral Hope
and robots are under General Scum.

The human players are the dogs and need to try to cooperate to defeat the ai bots which might have personalities or strategies or both. (A personality might be how frequently you change your strategy (or to what) based on how frustrated you are or by other semi-arbitrary things such as a lack of success or a sense of patterns, even smack talk?)

Possibly add the ability to play a card defensively to reduce damage by half

## Possible Strategies
    
    1) Offensive
    2) Defensive
    3) Shift between offensive and defensive based on
        * The absolute state of play
        * Because of patterns in others play
        * To shift our own pattern of play by some strategy
    
## Relevant References
    
[A book](https://pragprog.com/book/lhelph/functional-web-development-with-elixir-otp-and-phoenix)
    
[An article](http://theerlangelist.com/article/spawn_or_not)
    
[A repo and presentation](https://github.com/JEG2/hanabi_umbrella#long-term-storage)


## To start:

  * Install dependencies with `mix deps.get`
  * Create and migrate database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Visit [`localhost:4000`](http://localhost:4000) from your browser.

