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
                // not handled
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
    }
}

- (IBAction)deal
{
    self.game = nil;
    [self updateUI];
}

@end
