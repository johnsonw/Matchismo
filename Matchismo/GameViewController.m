//
//  GameViewController.m
//  Matchismo
//
//  Created by Will Johnson on 2/24/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "GameViewController.h"
#import "Card.h"
#import "CardMatchingGame.h"

// The GameViewController should implement the UICollectionViewDataSource so that it can be
// the data source for the view.
@interface GameViewController () <UICollectionViewDataSource>
@end

@implementation GameViewController

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    // Return the result of the abstract property. This property must be defined in subclasses.
    if (self.game.cardCount == 0) {
        return self.startingCardCount;
    } else {
        return self.game.cardCount;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.collectionViewIdentifier forIndexPath:indexPath];
    Card *card = [self.game cardAtIndex:indexPath.item];
    [self updateCell:cell usingCard:card];
    return cell;
}

/**
 * Updates the UI when the view is finished loading. This is necessary to initialize the game when the view
 * finishes or else the card images will not display.
 */
- (void)viewDidLoad
{
    [self updateUI];
}

- (void)updateUI
{
    NSMutableArray *viewsToRemove = [[NSMutableArray alloc] init];
    
    // Loop through all of the cards and if a card is disabled then it needs to be added to the list of cards that will be removed.
    NSLog(@"card count: %d", [self.game cardCount]);
    for (int i = 0; i < [self.game cardCount]; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewCell *cell = [self.cardCollectionView cellForItemAtIndexPath:indexPath];
        Card *card = [self.game cardAtIndex:i];

        [self analyzeCardOnUpdate:card viewsToRemove:viewsToRemove indexPath:indexPath cell:cell];
    }
    
    if ([viewsToRemove count] > 0) {
        NSLog(@"Removing views: %@", viewsToRemove);
        [self.cardCollectionView deleteItemsAtIndexPaths:viewsToRemove];
        [self.cardCollectionView reloadData];
    }
    
    // Update the score label
    self.scoreLabel.text = [NSString stringWithFormat: @"Score: %d", self.game.score];
    
    [self updateStatusLabel];
}

- (void) analyzeCardOnUpdate:(Card *)card viewsToRemove:(NSMutableArray *)viewsToRemove indexPath:(NSIndexPath *)indexPath cell:(UICollectionViewCell *)cell
{
    // Abstract
}

/**
 * Retrieves the CardMatchingGame instance. It is lazy instantiated.
 */
- (CardMatchingGame *) game
{
    NSLog(@"Starting card count: %d", self.startingCardCount);
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.startingCardCount usingDeck:[self createDeck] withMatchCount:self.matchCount andMinimumMatch:self.minimumMatch];
    
    return _game;
}

- (int) matchCount
{
    // Abstract
    return -1;
}

- (int) minimumMatch
{
    // Abstract
    return -1;
}

- (Deck *)createDeck { return nil; } // abstract;

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card
{
    // abstract
}

// Sets the button states of a button based on the card model state.
-(void) setButtonStates:(UIButton *)cardButton :(Card *)card
{
    // Set the button states based on the state of the model
    cardButton.selected = card.isFaceUp;
    cardButton.enabled = !card.isUnplayable;
    cardButton.alpha = card.isUnplayable ? 0.15 : 1.0;
}

-(void) setCardButtonDisplayProperties: (UIButton *)cardButton :(Card *) card
{
    UIEdgeInsets inset = UIEdgeInsetsMake(5, 5, 5, 5);
    // Get a reference to the card image
    UIImage *cardBackImage = [UIImage imageNamed:@"card.png"];
    // Round the corners
    cardButton.imageEdgeInsets = inset;
    
    // If the card is not turned over display the image for the back of the card
    if (!card.isFaceUp) {
        [cardButton setImage:cardBackImage forState:UIControlStateNormal];
    } else {
        // If the card is turned over remove the image
        [cardButton setImage:nil forState:UIControlStateNormal];
    }
}

/**
 * Mutator that sets the flip count.
 */
-(void) setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UITapGestureRecognizer *)sender {
    CGPoint tapLocation = [sender locationInView:self.cardCollectionView];
    NSIndexPath *indexPath = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];
    
    if (indexPath) {
        [self.game flipCardAtIndex:indexPath.item];
        self.flipCount++;
        [self updateUI];
    }
}

- (void) updateStatusLabel
{
    // Abstract
}

/**
 * Action that is called when the player clicks the deal button. This will reset the game.
 */
- (IBAction)dealGame:(UIButton *)sender {
    // Remove all items up to the start count in the collection view
    NSMutableArray *viewsToRemove = [[NSMutableArray alloc] init];
    for (NSInteger i = self.game.cards.count - 1; i >= self.startingCardCount; i--) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [self.game removeCardFromDeck:i];
        [viewsToRemove addObject:indexPath];
    }
    [self.cardCollectionView deleteItemsAtIndexPaths:viewsToRemove];
    
    
    self.game = nil;
    self.deck = nil;

    self.flipCount = 0;
    [self updateUI];
}

@end
