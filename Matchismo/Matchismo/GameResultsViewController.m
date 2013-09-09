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
    NSArray *allGameResults;
    
    switch (self.sortType) {
        case BY_SCORE:
            allGameResults = [GameResults allGamesResultsSortedByScore];
            break;
        case BY_DURATION:
            allGameResults = [GameResults allGamesResultsSortedByDuration];
            break;
        default:
            allGameResults = [GameResults allGamesResultsSortedByDate];
            break;
    }

    for (GameResults *gameResults in allGameResults) {
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
    self.sortType = BY_DATE;
}s

- (IBAction)sortByDuration
{
    self.sortType = BY_DURATION;
}

- (IBAction)sortByScore
{
    self.sortType = BY_SCORE;
}

@end
