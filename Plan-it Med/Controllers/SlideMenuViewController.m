//
//  SlideMenuViewController.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 6/12/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "SlideMenuViewController.h"
#import "Reachability.h"

@interface SlideMenuViewController () <SASlideMenuDelegate, SASlideMenuDataSource>

@end

@implementation SlideMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
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

#pragma mark -
#pragma mark SASlideMenuDataSource

//-(void) prepareForSwitchToContentViewController:(UINavigationController *)content{
//    UIViewController* controller = [content.viewControllers objectAtIndex:0];
//    if ([controller isKindOfClass:[ColoredViewController class]]) {
//        ColoredViewController* coloredViewController = (ColoredViewController*) controller;
//        [coloredViewController setBackgroundHue:selectedHue brightness:selectedBrightness];
//    }
//}

// It configure the menu button. The beahviour of the button should not be modified
-(void) configureMenuButton:(UIButton *)menuButton{
    menuButton.frame = CGRectMake(0, 0, 40, 29);
    [menuButton setImage:[UIImage imageNamed:@"menuicon.png"] forState:UIControlStateNormal];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menuhighlighted.png"] forState:UIControlStateHighlighted];
    [menuButton setAdjustsImageWhenHighlighted:NO];
    [menuButton setAdjustsImageWhenDisabled:NO];
}

// This is the segue you want visibile when the controller is loaded the first time
-(NSIndexPath*) selectedIndexPath{
    return [NSIndexPath indexPathForRow:1 inSection:0];
}

// It maps each indexPath to the segueId to be used. The segue is performed only the first time the controller needs to loaded, subsequent switch to the content controller will use the already loaded controller

-(NSString*) segueIdForIndexPath:(NSIndexPath *)indexPath{
    NSString* result;
    switch (indexPath.row) {
        case 0:
            result = @"todayMenu";
            break;
        case 1:
            result = @"scheduleMenu";
            break;
        case 2:
            result = @"medicationsMenu";
            break;
        case 3:
            result = @"notificationsMenu";
            break;
        case 4:
            result = @"libraryMenu";
            break;
        case 5:
            result = @"pearlsMenu";
            break;
        case 6:
            result = @"teamMenu";
            break;
        case 7:
            result = @"rewardsMenu";
            break;
        case 8:
            result = @"findAPharmacyMenu";
            break;
        default:
            result = @"settingsMenu";
            break;
    }
    return result;
}

-(Boolean) slideOutThenIn{
    return NO;
}
//Disable caching for the controller at the indexPath row of each section if return YES
-(Boolean) disableContentViewControllerCachingForIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

#pragma mark -
#pragma mark UITableViewDataSource
//UITableViewDataSource
-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{    
    if (cell.backgroundView) {
        NSLog(@"not nil");
    } else {
        //NSLog(@"nil");
//        NSString *imageBundle = [[NSBundle mainBundle] pathForResource:@"row" ofType:@"png"];
//        NSLog(@"imageBundle: %@",imageBundle);
        UIImage *normalImage = [UIImage imageNamed:@"row.png"];
        UIImage *selectedImage = [UIImage imageNamed:@"rowselected.png"];
        UIImageView *normalImageView = [[UIImageView alloc] initWithImage:normalImage];
        UIImageView *selectedImageView = [[UIImageView alloc] initWithImage:selectedImage];
        [cell setBackgroundView:normalImageView];
        [cell setSelectedBackgroundView:selectedImageView];
    }
}

@end
