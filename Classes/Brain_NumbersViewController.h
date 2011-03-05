//
//  Brain_NumbersViewController.h
//  Brain Numbers
//
//  Created by Patrick Santana on 11/09/10.
//  Copyright 2010 Moogu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PlayViewController.h"
#import "AboutViewController.h"
#import "SetupViewController.h"
#import "RecordViewController.h"

#import "AdMobDelegateProtocol.h"


@interface Brain_NumbersViewController : UIViewController  <AdMobDelegate>{ 
	
	/** instance for the ad mob */
	AdMobView *adMobAd;
	
	
	/* 
	 * Instance of all controllers that will be used 
	 */
	PlayViewController *playViewController;
	AboutViewController *aboutViewController;
	RecordViewController *recordViewController;
	SetupViewController *setupViewController;

}

@property(nonatomic,retain) PlayViewController *playViewController;
@property(nonatomic,retain) AboutViewController *aboutViewController;
@property(nonatomic,retain) RecordViewController *recordViewController;
@property(nonatomic,retain) SetupViewController *setupViewController;

/*
 * Actions when click in the button
 */
- (IBAction) startGame:(id)sender;
- (IBAction) startAbout:(id)sender;
- (IBAction) startSetup:(id)sender;
- (IBAction) startDashboard:(id)sender;

@end
