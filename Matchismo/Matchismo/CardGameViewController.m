//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Andrei-Lucian Șerb on 8/21/13.
//  Copyright (c) 2013 Andrei-Lucian Șerb. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) NSInteger flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (nonatomic) NSUInteger gameMode;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSelector;

@end

@implementation CardGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected | UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    }
    
    if ([self.game.flippedCards count] > 0) {
        NSString *text = @"";
        
        if (self.game.gameStatus == 0) {
            Card *card = [self.game.flippedCards lastObject];
            text = [NSString stringWithFormat:@"Flipped up %@.", card.contents];
        } else {
            if ([self.game.flippedCards count] > 2) {
                for (NSUInteger i = 0; i < [self.game.flippedCards count] - 1; i++) {
                    Card *card = self.game.flippedCards[i];
                    text = [text stringByAppendingString:card.contents];
                    text = [text stringByAppendingString:@", "];
                }
            } else {
                Card *card = [self.game.flippedCards firstObject];
                text = [text stringByAppendingString:card.contents];
                text = [text stringByAppendingString:@" "];
            }
            
            Card *card = [self.game.flippedCards lastObject];
            text = [text stringByAppendingString:@"and "];
            text = [text stringByAppendingString:card.contents];
            
            if (self.game.gameStatus == 1) {
                text = [NSString stringWithFormat:@"Matched %@ for %d points.", text, self.game.flipScore];
            } else if (self.game.gameStatus == -1) {
                text = [NSString stringWithFormat:@"%@ don't match! %d penalty!", text, self.game.flipScore];
            }
        }
        
        self.resultLabel.text = text;
    } else {
        self.resultLabel.text = @"Start by flipping a card.";
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                            noMatchingCards:self.gameMode
                                                  usingDeck:[[PlayingCardDeck alloc] init]];
    }
    
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)setFlipCount:(NSInteger)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    
    if (self.flipCount == 0) {
        self.gameModeSelector.enabled = NO;
    }
    
    self.flipCount++;
    [self updateUI];
}

- (IBAction)deal:(id)sender
{
    self.game = nil;
    self.flipCount = 0;
    self.gameModeSelector.enabled = YES;
    [self updateUI];
}

- (IBAction)changeGameMode:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0) {
        self.gameMode = 2;
    } else if (sender.selectedSegmentIndex == 1) {
        self.gameMode = 3;
    }
    
    [self.game changeNoMatchingCardsTo:self.gameMode];
}

@end
