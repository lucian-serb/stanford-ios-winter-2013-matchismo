//
//  SettingsViewController.m
//  Matchismo
//
//  Created by Andrei-Lucian Șerb on 10/2/13.
//  Copyright (c) 2013 Andrei-Lucian Șerb. All rights reserved.
//

#import "SettingsViewController.h"
#import "GameResults.h"
#import "Settings.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *gameTypeSetting;
@property (strong, nonatomic) Settings *settings;

@end

@implementation SettingsViewController

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
    self.gameTypeSetting.selectedSegmentIndex = [Settings allSettings].gameType;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (Settings *)settings
{
    if (!_settings) {
        _settings = [[Settings alloc] init];
    }
    
    return _settings;
}

- (IBAction)resetCardGameResults
{
    [GameResults resetResultsForKey:ALL_CARD_RESULTS_KEY];
}

- (IBAction)resetSetGameResults
{
    [GameResults resetResultsForKey:ALL_SET_RESULTS_KEY];
}

- (IBAction)changeGameTypeSetting:(UISegmentedControl *)sender
{
    self.settings.gameType = sender.selectedSegmentIndex;
}

@end
