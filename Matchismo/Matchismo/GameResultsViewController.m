//
//  GameResultsViewController.m
//  Matchismo
//
//  Created by Andrei-Lucian Șerb on 9/24/13.
//  Copyright (c) 2013 Andrei-Lucian Șerb. All rights reserved.
//

#import "GameResultsViewController.h"
#import "GameResults.h"

@interface GameResultsViewController ()

typedef enum {BY_DATE, BY_DURATION, BY_SCORE, ENUM_NR_ITEMS} SORT_TYPE_T;

@property (weak, nonatomic) IBOutlet UITextView *display;
@property (nonatomic) SORT_TYPE_T sortType;
@property (weak, nonatomic) IBOutlet UISegmentedControl *resultsSelector;

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
            if (self.resultsSelector.selectedSegmentIndex == 0) {
                allGameResults = [GameResults allGamesResultsSortedByScoreForKey:ALL_CARD_RESULTS_KEY];
            } else {
                allGameResults = [GameResults allGamesResultsSortedByScoreForKey :ALL_SET_RESULTS_KEY];
            }
            break;
        case BY_DURATION:
            if (self.resultsSelector.selectedSegmentIndex == 0) {
                allGameResults = [GameResults allGamesResultsSortedByDurationForKey:ALL_CARD_RESULTS_KEY];
            } else {
                allGameResults = [GameResults allGamesResultsSortedByDurationForKey:ALL_SET_RESULTS_KEY];
            }
            break;
        default:
            if (self.resultsSelector.selectedSegmentIndex == 0) {
                allGameResults = [GameResults allGamesResultsSortedByDateForKey:ALL_CARD_RESULTS_KEY];
            } else {
                allGameResults = [GameResults allGamesResultsSortedByDateForKey:ALL_SET_RESULTS_KEY];
            }
            break;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    
    for (GameResults *gameResults in allGameResults) {
        displayText = [displayText stringByAppendingFormat:@"Score: %d (%@, %.0fs)\n", gameResults.score, [dateFormatter stringFromDate:gameResults.start], gameResults.duration];
    }
    
    if ([displayText length] == 0) {
        self.display.text = @"No results yet... Start playing a game.";
    } else {
        self.display.text = displayText;
    }
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
    [self updateUI];
}

- (IBAction)sortByDuration
{
    self.sortType = BY_DURATION;
    [self updateUI];
}

- (IBAction)sortByScore
{
    self.sortType = BY_SCORE;
    [self updateUI];
}

- (IBAction)selectResults
{
    [self updateUI];
}

@end
