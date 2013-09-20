//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Andrei-Lucian Șerb on 9/12/13.
//  Copyright (c) 2013 Andrei-Lucian Șerb. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "SetGame.h"

@interface SetGameViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) SetGame *game;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (nonatomic) NSInteger flipCount;
@property (weak, nonatomic) IBOutlet UISlider *historySlider;
@property (strong, nonatomic) NSMutableArray *resultArray;

@end

@implementation SetGameViewController

- (void)setup
{
    // add initialization stuff here
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self setup];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (SetGame *)game
{
    if (!_game) {
        _game = [[SetGame alloc] initWithCardCount:[self.cardButtons count]
                                        usingDeck:[[SetCardDeck alloc] init]];
    }
    
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (NSMutableArray *)resultArray
{
    if (!_resultArray) {
        _resultArray = [[NSMutableArray alloc] init];
    }
    
    return _resultArray;
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        SetCard *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:card.contents];
        NSRange range = [card.contents rangeOfString:card.contents];
        UIColor *color;
        
        switch (card.color) {
            case GREEN:
                color = [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0];
                break;
            case PURPLE:
                color = [UIColor colorWithRed:0.5 green:0.0 blue:0.5 alpha:1.0];
                break;
            case RED:
                color = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
                break;
            default:
                color = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
                break;
        }
        
        NSDictionary *shadingAttributes;
        
        switch (card.shading) {
            case SOLID:
                shadingAttributes = @{NSStrokeWidthAttributeName: @10.0};
                break;
            case OPEN:
                shadingAttributes = @{NSStrokeWidthAttributeName: @0.0};
                break;
            case STRIPED:
                shadingAttributes = @{NSStrokeColorAttributeName: color,
                                      NSStrokeWidthAttributeName: @(-10.0)};
                color = [color colorWithAlphaComponent:0.2];
            default:
                // not handled
                break;
        }
        
        NSDictionary *attributes = @{NSForegroundColorAttributeName: color};
        [attr addAttributes:attributes range:range];
        [attr addAttributes:shadingAttributes range:range];
        [cardButton setAttributedTitle:attr forState:UIControlStateNormal];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
        
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
            
            self.historySlider.enabled = YES;
            Card *card = [self.game.flippedCards lastObject];
            
            if (card.isFaceUp) {
                [self.resultArray addObject:text];
                self.historySlider.maximumValue = [self.resultArray count] - 1;
            }
            
            self.historySlider.value = self.historySlider.maximumValue;
            self.resultLabel.text = text;
        } else {
            NSString *text = @"Start by flipping a card.";
            self.resultLabel.text = text;
            [self.resultArray addObject:text];
        }
        
        self.resultLabel.alpha = 1.0;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
}

- (void)setFlipCount:(NSInteger)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)deal
{
    self.game = nil;
    self.flipCount = 0;
    self.resultArray = nil;
    self.historySlider.maximumValue = 1.0;
    self.historySlider.value = self.historySlider.maximumValue;
    self.historySlider.enabled = NO;
    [self updateUI];
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

- (IBAction)moveThroughHistory:(UISlider *)sender
{
    if (round(sender.value) < [self.resultArray count] - 1) {
        self.resultLabel.alpha = 0.5;
    } else {
        self.resultLabel.alpha = 1.0;
    }
    
    self.resultLabel.text = self.resultArray[(int)round(sender.value)];
}

@end
