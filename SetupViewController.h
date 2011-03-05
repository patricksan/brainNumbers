//
//  SetupViewController.h
//  Brain Numbers
//
//  Created by Patrick Santana on 20/09/09.
//  Copyright 2010 Moogu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SetupViewController : UIViewController {
	
	/** the actual function selected */
	int buttonSelected;

	/** to show the actual button selected */
	IBOutlet UIImageView *buttonSelectedPlus;
	IBOutlet UIImageView *buttonSelectedMinus;
	IBOutlet UIImageView *buttonSelectedMultiply;
	IBOutlet UIImageView *buttonSelectedDivide;
	IBOutlet UIImageView *buttonSelectedAll;
}

-(IBAction) returnToViewController:(id) sender;

// actions if user press the buttons 
-(IBAction) buttonPlus:(id) sender;
-(IBAction) buttonMinus:(id) sender;
-(IBAction) buttonMultiply:(id) sender;
-(IBAction) buttonDivide:(id) sender;
-(IBAction) buttonAll:(id) sender;

- (void) updateSetup;
@end
