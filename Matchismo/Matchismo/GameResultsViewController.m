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

typedef enum {BY_DATE, BY_DURATION, BY_SCORE, ENUM_NR_ITEMS} SORT_TYPE_T;

@property (weak, nonatomic) IBOutlet UITextView *display;
@property (nonatomic) SORT_TYPE_T sortType;

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

- (void)setSortType:(SORT_TYPE_T)sortType
{
    if (sortType < ENUM_NR_ITEMS) {
        _sortType = sortType;
    } else {
        _sortType = BY_DATE;
    }
}

- (IBAction)sortByDate
{
    
}

- (IBAction)sortByDuration
{
    
}

- (IBAction)sortByScore
{
    
}

@end
