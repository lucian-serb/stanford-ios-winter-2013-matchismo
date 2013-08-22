//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Andrei-Lucian Șerb on 8/21/13.
//  Copyright (c) 2013 Andrei-Lucian Șerb. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) NSInteger flipCount;
@property (nonatomic) PlayingCardDeck *deck;

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

- (PlayingCardDeck *)deck
{
    if (!_deck) {
        _deck = [[PlayingCardDeck alloc] init];
    }
    
    return _deck;
}

- (void)setFlipCount:(NSInteger)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    if (!sender.isSelected)
    {
        PlayingCard *card = (PlayingCard *)[self.deck drawRandomCard];

        if (card) {
            [sender setTitle:card.contents forState:UIControlStateSelected];
            self.flipCount++;
        } else {
            [sender setTitle:@"★" forState:UIControlStateSelected];
        }
    }
    
    sender.selected = !sender.isSelected;
}

@end
