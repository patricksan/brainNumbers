//
//  AboutViewController.m
//  Brain Numbers
//
//  Created by Patrick Santana on 19/09/09.
//  Copyright 2010 Moogu. All rights reserved.
//

#import "AboutViewController.h"


@implementation AboutViewController


/** Return to the main Menu */
-(IBAction) returnToViewController:(id) sender{
	/** Create an animation to return to the menu */
	[UIView beginAnimations:@"flipping view" context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	[UIView setAnimationTransition: UIViewAnimationTransitionFlipFromRight forView:self.view.superview cache:YES];
	
	/** remove from the view */
	[self.view removeFromSuperview];
	NSLog(@"Method returnToViewController executed");
	
	/** commit the animation */
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
	NSLog(@"Method viewDidUnload executed");
}

- (void) viewDidLoad{
		NSLog(@"Method viewDidLoad executed");
}
- (void) loadView{
	NSLog(@"Method loadView executed");
	[super loadView];
}


- (void) viewDidAppear{
	NSLog(@"Method viewDidAppear executed");
}


- (void) viewWillDisappear{
	NSLog(@"Method viewWillDisappear executed");
}


- (void) viewDidDisappear{
	NSLog(@"Method viewDidDisappear executed");
}

- (void)viewWillAppear:(BOOL)animated {
	NSLog(@"Method viewWillAppear executed");

    [super viewWillAppear:animated];
}
- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	NSLog(@"Method viewDidUnload executed");
}


- (void)dealloc {
    [super dealloc];
	NSLog(@"Method dealloc executed");
}


@end
