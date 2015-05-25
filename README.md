<img width="200" src="https://rawgit.com/jhauberg/Tabletops/master/logo.svg" alt="Tabletops">

Tabletops is a framework for simulating and playtesting card and boardgames.

It is not a game engine.

In its current state, the framework can be used to model a representation of most games that uses a variety of cards, dice, tokens, decks, piles, and so on.

This representation can then be used to create scenarios and perform simulations; i.e. moving tokens, rolling dice, flipping cards, shuffling decks and other common tabletop actions.

Additionally, rules can be created to control and advance the simulation through conditional responses, triggers and resolutions.

**Future features might include**:

  * Interface for visually modeling game representations
  * AI layer for automating playtests
  * ~~Rule enforcement~~ (**Added!**)

## Implementation

The [tabletop](https://github.com/jhauberg/Tabletops/tree/master/tabletop) is implemented as a component/entity model. Every object (either tangible or abstract) on the tabletop, is represented as an [entity](https://github.com/jhauberg/Tabletops/blob/master/tabletop/entity/TTEntity.h).

[Components](https://github.com/jhauberg/Tabletops/blob/master/tabletop/component/TTEntityComponent.h) add behavior to entities, and each entity can have any number of components assigned to it.

This is how you could make a 6-sided die:

```objective-c
TTEntity *d6 = [TTEntity entity];

TTDieRepresentation *representation =
  [TTDieRepresentation representationWithSides:
   // note that a 'side' can be most kinds of objects
   @[ @1, @2, @3, @4, @5, @6 ]];

[d6 addComponent: representation];
```

As expected, the die can be rolled randomly, or turned to show a specific side.

```objective-c
[representation roll];
```

```shell
<TTEntity: 0x100108530>
 ↳ <TTDieRepresentation: 0x100108ed0> Shows '5' from [1, 2, 3, 4, 5, 6]
```

Here's how you could make a card with a few properties:

```objective-c
TTCardEntity *trickCard = [TTCardEntity cardWithFrontside: @"card-trick-front-heelflip.png"
                                              andBackside: @"card-trick-back.png"];

TTTagComponent *tag =
  [TTTagComponent componentWithTag: @"Trick"];

TTPropertyComponent *difficultyProperty =
  [TTPropertyComponent propertyWithName: @"Difficulty"
                               andValue: @3];

TTPropertyComponent *nameProperty =
  [TTPropertyComponent propertyWithName: @"Name"
   // again note that the value can be most kinds of objects
                               andValue: @"Heelflip"];

[trick addComponents:
 @[ tag,
    nameProperty,
    difficultyProperty ]];
```

The card can be flipped, tapped and be part of a larger deck of cards.

```objective-c
[trickCard.representation flipToFrontside];
```

```shell
<TTCardEntity: 0x10011d620>
 ↳ <TTCardRepresentation: 0x10011d670> Shows 'card-trick-front-3-heelflip.png'
 ↳ <TTTagComponent: 0x100116850> "Trick"
 ↳ <TTPropertyComponent: 0x10011d7c0> Name = Heelflip
 ↳ <TTPropertyComponent: 0x10011d7a0> Difficulty = 3
```

A pile of tokens:

```objective-c
TTEntity *pile =
  [TTEntity entityWithName: @"Tokens"];

  [pile addComponent:
    [TTPileGroupingComponent groupWithEntities:
      @[ [TTTokenEntity tokenWithFrontside: @"▪"],
         [TTTokenEntity tokenWithFrontside: @"▪"],
         [TTTokenEntity tokenWithFrontside: @"▪"] ]]];
```

```shell
<TTEntity "Tokens": 0x10030cfd0>
 ↳ <TTPileGroupingComponent: 0x100318bf0>
     ↳ <TTTokenEntity: 0x1003188c0> TTTokenRepresentation (Shows '▪'),
     ↳ <TTTokenEntity: 0x1003189b0> TTTokenRepresentation (Shows '▪'),
     ↳ <TTTokenEntity: 0x100318a20> TTTokenRepresentation (Shows '▪')
```

## Rule enforcement

The tabletop can be manipulated and controlled by creating [rules](https://github.com/jhauberg/Tabletops/blob/master/tabletop/rule/TTRule.h). Rules are resolved recursively, such that a rule can create new rules, or break/alter existing ones.

Here's an example where, on a turn, the current player draws a card from a deck, and if the deck is emptied, it is reshuffled from a discard pile.

```objective-c
TTRuleDrivenGameState *state = [[TTRuleDrivenGameState alloc] init];

TTOrderGroupingComponent *order = [TTOrderGroupingComponent groupWithEntities:
  @[ [TTPlayerEntity entityWithName: @"Player 1"],
     [TTPlayerEntity entityWithName: @"Player 2"],
     [TTPlayerEntity entityWithName: @"Player 3"] ]];

[state.table addComponent: order];

TTRule* onStartOfTurn =
  [TTRule ruleWithName: @"On Start of Turn"
        thatResolvesTo: ^BOOL(TTRuleDrivenGameState *state) {
          [state.rules push: drawATrick
                      after: onStartOfTurn];

          return YES;
        }];

TTRule* drawATrick =
  [TTRule ruleWithName: @"Draw A Trick"
        thatResolvesTo: ^BOOL(TTRuleDrivenGameState *state) {
          TTPlayerEntity *currentPlayer = (TTPlayerEntity *)order.current;
          TTDeckEntity *tricks = [state findEntityNamed: @"Tricks"];

          if ([tricks.group isEmpty]) {
              return NO;
          }

          [currentPlayer.hand addEntity:
           [tricks.group drawFromTop]];

          [state.rules push: reshuffleIfNecessary
                      after: drawATrick];

          return YES;
        }];

TTRule *reshuffleIfNecessary =
  [TTRule ruleWithName: @"Reshuffle"
        thatResolvesTo: ^BOOL(TTRuleDrivenGameState *state) {
          TTDeckEntity *tricks = [state findEntityNamed: @"Tricks"];

          if ([tricks.group isEmpty]) {
            TTDeckEntity *tricksDiscard = [state findEntityNamed: @"Discarded tricks"];

            [tricks.group moveAllEntitiesFromGroup: tricksDiscard.group];
            [tricks.group shuffle];

            return YES;
          }

          return NO;
        }];

[state.rules push: onStartOfTurn];

[state resolveIfNecessary];
```

# License

The MIT License (MIT)

Copyright (c) 2015 Jacob Hauberg Hansen

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
