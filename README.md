<img width="200" src="https://rawgit.com/jhauberg/Tabletops/master/logo.svg" alt="Tabletops">

Tabletops is a framework for simulating and playtesting card and boardgames. It is not a game engine.

In its current state, the framework can be used to model a representation of most games that uses a variety of cards, dice, tokens, decks, piles, and so on.

This representation can then be used to create scenarios and perform simulations; i.e. moving tokens, rolling dice, flipping cards, shuffling decks and other common tabletop actions.

**Future features might include**:

  * Interface for visually modeling game representations
  * AI layer for automating playtests
  * Rule enforcement

# Implementation

The [tabletop](https://github.com/jhauberg/Tabletops/tree/master/tabletop) is implemented as a component-entity model.

This is how you would make a 6-sided die:

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
         [TTTokenEntity tokenWithFrontside: @"▪"],
         [TTTokenEntity tokenWithFrontside: @"▪"],
         [TTTokenEntity tokenWithFrontside: @"▪"] ]]];
```

```shell
<TTEntity "Tokens": 0x10030cfd0>
 ↳ <TTPileGroupingComponent: 0x100318bf0>
     ↳ <TTTokenEntity: 0x1003188c0> TTTokenRepresentation (Shows '▪'),
     ↳ <TTTokenEntity: 0x1003188e0> TTTokenRepresentation (Shows '▪'),
     ↳ <TTTokenEntity: 0x100318940> TTTokenRepresentation (Shows '▪'),
     ↳ <TTTokenEntity: 0x1003189b0> TTTokenRepresentation (Shows '▪'),
     ↳ <TTTokenEntity: 0x100318a20> TTTokenRepresentation (Shows '▪')
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
