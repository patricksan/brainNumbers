//
//  SetupViewController.m
//  Brain Numbers
//
//  Created by Patrick Santana on 20/09/09.
//  Copyright 2010 Moogu. All rights reserved.
//

#import "SetupViewController.h"


@implementation SetupViewController


-(IBAction) buttonPlus:(id) sender{
	/** change properties in the screen */
	buttonSelectedPlus.hidden = NO;
	buttonSelectedMinus.hidden = YES;
	buttonSelectedMultiply.hidden = YES;
	buttonSelectedDivide.hidden = YES;
	buttonSelectedAll.hidden = YES;
	
	/** keep the function selected */
	buttonSelected = 1;
	
	/** save the configuration */
	[self updateSetup];
}

-(IBAction) buttonMinus:(id) sender{
	/** change properties in the screen */
	buttonSelectedPlus.hidden = YES;
	buttonSelectedMinus.hidden = NO;
	buttonSelectedMultiply.hidden = YES;
	buttonSelectedDivide.hidden = YES;
	buttonSelectedAll.hidden = YES;
	
	/** keep the function selected */
	buttonSelected = 2;
	
	/** save the configuration */
	[self updateSetup];
	
}
-(IBAction) buttonMultiply:(id) sender{
	/** change properties in the screen */
	buttonSelectedPlus.hidden = YES;
	buttonSelectedMinus.hidden = YES;
	buttonSelectedMultiply.hidden = NO;
	buttonSelectedDivide.hidden = YES;
	buttonSelectedAll.hidden = YES;
	
	/** keep the function selected */
	buttonSelected = 3;
	
	/** save the configuration */
	[self updateSetup];
	
}
-(IBAction) buttonDivide:(id) sender{
	/** change properties in the screen */
	buttonSelectedPlus.hidden = YES;
	buttonSelectedMinus.hidden = YES;
	buttonSelectedMultiply.hidden = YES;
	buttonSelectedDivide.hidden = NO;
	buttonSelectedAll.hidden = YES;
	
	/** keep the function selected */
	buttonSelected = 4;
	
	/** save the configuration */
	[self updateSetup];
	
}

-(IBAction) buttonAll:(id) sender{
	/** change properties in the screen */
	buttonSelectedPlus.hidden = YES;
	buttonSelectedMinus.hidden = YES;
	buttonSelectedMultiply.hidden = YES;
	buttonSelectedDivide.hidden = YES;
	buttonSelectedAll.hidden = NO;
	
	/** keep the function selected */
	buttonSelected = 5;
	
	/** save the configuration */
	[self updateSetup];
}

-(void) updateSetup{
	/** get the actual button selected via variable buttonSelected
	 * 1 Plus
	 * 2 Minus
	 * 3 Multiply
	 * 4 Divide
	 * 5 All
	 */
	NSNumber *functionToSave = [NSNumber numberWithInt:buttonSelected];
	NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:functionToSave,@"function",nil];
	
	/** properties to save */
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:@"setup.plist"];
	
	NSLog(@"path: %@", path);
	
	/** save information */
	bool blnSaved = [dict writeToFile:path atomically:YES];
	if (blnSaved){
		NSLog(@"Setup saved");
	}else {
		NSLog(@"Error to save setup");
	}

	/** log */
	NSLog(@"Saved function %d in the setup",buttonSelected);
}

/** Return to the main Menu */
-(IBAction) returnToViewController:(id) sender{
	/** Create an animation to return to the menu */
	[UIView beginAnimations:@"flipping view" context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	[UIView setAnimationTransition: UIViewAnimationTransitionFlipFromRight forView:self.view.superview cache:YES];
	
	/** remove from the view */
	[self.view removeFromSuperview];
	
	/** commit the animation */
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
	/** properties to save */
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:@"setup.plist"];
	
	NSLog(@"path: %@", path);
	
	NSDictionary *plistDict = [[NSDictionary alloc] initWithContentsOfFile:path];
	NSNumber *function = [plistDict objectForKey:@"function"];
	

	if ([function intValue] == 1){
		NSLog(@"Function 1");	
		buttonSelectedPlus.hidden = NO;
		buttonSelectedMinus.hidden = YES;
		buttonSelectedMultiply.hidden = YES;
		buttonSelectedDivide.hidden = YES;
		buttonSelectedAll.hidden = YES;
	}else if ([function intValue] == 2){
		NSLog(@"Function 2");	
		buttonSelectedPlus.hidden = YES;
		buttonSelectedMinus.hidden = NO;
		buttonSelectedMultiply.hidden = YES;
		buttonSelectedDivide.hidden = YES;
		buttonSelectedAll.hidden = YES;
	}else if ([function intValue] == 3){
		NSLog(@"Function 3");	
		buttonSelectedPlus.hidden = YES;
		buttonSelectedMinus.hidden = YES;
		buttonSelectedMultiply.hidden = NO;
		buttonSelectedDivide.hidden = YES;
		buttonSelectedAll.hidden = YES;
	}else if ([function intValue] == 4){
		NSLog(@"Function 4");	
		buttonSelectedPlus.hidden = YES;
		buttonSelectedMinus.hidden = YES;
		buttonSelectedMultiply.hidden = YES;
		buttonSelectedDivide.hidden = NO;
		buttonSelectedAll.hidden = YES;
	}else if ([function intValue] == 5){
		NSLog(@"Function 5");	
		buttonSelectedPlus.hidden = YES;
		buttonSelectedMinus.hidden = YES;
		buttonSelectedMultiply.hidden = YES;
		buttonSelectedDivide.hidden = YES;
		buttonSelectedAll.hidden = NO;
	}
	
	/** keep the function selected */
	buttonSelected = [function intValue];
}

- (void)dealloc {
    [super dealloc];
}


@end
