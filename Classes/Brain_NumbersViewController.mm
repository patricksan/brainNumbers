//
//  Brain_NumbersViewController.m
//  Brain Numbers
//
//  Created by Patrick Santana on 11/09/10.
//  Copyright 2010 Moogu. All rights reserved.
//

#import "Brain_NumbersViewController.h"
#import "OpenFeint.h"
#import "OFAchievement.h"
#import "OFAchievementService.h"
#import "AdMobView.h"

@implementation Brain_NumbersViewController


@synthesize playViewController;
@synthesize aboutViewController;
@synthesize recordViewController;
@synthesize setupViewController;

- (IBAction) startGame:(id)sender{
	
	if(self.playViewController == nil) {
		NSLog(@"Starting Play View Controller");
		PlayViewController *objInitialPlayViewController = [[PlayViewController alloc] initWithNibName:@"PlayController" bundle:nil];
		
		self.playViewController = objInitialPlayViewController;
		[objInitialPlayViewController release];
	}
	
	[UIView beginAnimations:@"flipping view" context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
	
	[self.view addSubview:playViewController.view];
	[UIView commitAnimations];	
	
	/** start game */
	[playViewController initVariables];
}


- (IBAction) startAbout:(id)sender{
	if(self.aboutViewController == nil) {
		NSLog(@"Starting About View Controller");
		AboutViewController *objInitialAboutViewController = [[AboutViewController alloc] initWithNibName:@"AboutController" bundle:nil];
		
		self.aboutViewController = objInitialAboutViewController;
		[objInitialAboutViewController release];
	}
	
	[UIView beginAnimations:@"flipping view" context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
	
	[self.view addSubview:aboutViewController.view];
	
	[UIView commitAnimations];	
	
}


- (IBAction) startSetup:(id)sender{
	if(self.setupViewController == nil) {
		NSLog(@"Starting Setup View Controller");
		SetupViewController *objInitialSetupViewController = [[SetupViewController alloc] initWithNibName:@"SetupController" bundle:nil];
		
		self.setupViewController = objInitialSetupViewController;
		[objInitialSetupViewController release];
	}
	
	[UIView beginAnimations:@"flipping view" context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
	
	
	[self.view addSubview:setupViewController.view];
	
	[UIView commitAnimations];	
	
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


-(void) viewDidLoad{
	/** Admob is usable for all. AdMob Publisher: a14caa347751a4f */
	adMobAd = [AdMobView requestAdWithDelegate:self]; // start a new ad request
	[adMobAd retain]; // this will be released when it loads (or fails to load)
}

- (IBAction) startDashboard:(id)sender{
	[OpenFeint launchDashboard];
	
}

- (void)dealloc {
	[playViewController release];
	[aboutViewController release];
	[recordViewController release];
	[setupViewController release];
	[adMobAd release];
	
	// In the dealloc section	
    [super dealloc];
}

//-(void) didFailToReceiveAdWithError{}

#pragma mark -
#pragma mark AdMobDelegate methods

- (NSString *)publisherIdForAd:(AdMobView *)adView {
	return @"a14caa347751a4f"; // this should be prefilled; if not, get it from www.admob.com
}

- (UIViewController *)currentViewControllerForAd:(AdMobView *)adView {
	return self;
}

- (UIColor *)adBackgroundColorForAd:(AdMobView *)adView {
	return [UIColor colorWithRed:1 green:1 blue:1 alpha:1]; // this should be prefilled; if not, provide a UIColor
}

- (UIColor *)primaryTextColorForAd:(AdMobView *)adView {
	return [UIColor colorWithRed:0 green:0 blue:0 alpha:1]; // this should be prefilled; if not, provide a UIColor
}

- (UIColor *)secondaryTextColorForAd:(AdMobView *)adView {
	return [UIColor colorWithRed:0 green:0 blue:0 alpha:1]; // this should be prefilled; if not, provide a UIColor
}

// Sent when an ad request loaded an ad; this is a good opportunity to attach
// the ad view to the hierachy.
- (void)didReceiveAd:(AdMobView *)adView {
	NSLog(@"AdMob: Did receive ad");
	// get the view frame
	CGRect frame = self.view.frame;
	
	// put the ad at the bottom of the screen
	adMobAd.frame = CGRectMake(0, frame.size.height - 48, frame.size.width, 48);
	
	[self.view addSubview:adMobAd];
}

// Sent when an ad request failed to load an ad
- (void)didFailToReceiveAd:(AdMobView *)adView {
	NSLog(@"AdMob: Did fail to receive ad");
	[adMobAd removeFromSuperview];  // Not necessary since never added to a view, but doesn't hurt and is good practice
	[adMobAd release];
	adMobAd = nil;
	// we could start a new ad request here, but in the interests of the user's battery life, let's not
}


@end
