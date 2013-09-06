//
//  GameResultsViewController.m
//  Matchismo
//
//  Created by Andrei-Lucian Șerb on 9/6/13.
//  Copyright (c) 2013 Andrei-Lucian Șerb. All rights reserved.
//

#import "GameResultsViewController.h"
#import "GameResults.h"

@interface GameResultsViewController ()

@property (weak, nonatomic) IBOutlet UITextView *display;

@end

@implementation GameResultsViewController

- (void)setup
{
  // initialization that can't wait for viewDidLoad
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)updateUI
{
    NSString *displayText = @"";

    for (GameResults *gameResults in [GameResults allGamesResults]) {
        displayText = [displayText stringByAppendingFormat:@"Score %d (%@, %0f)\n", gameResults.score, gameResults.start, gameResults.duration];
    }
    
    self.display.text = displayText;
}

@end
