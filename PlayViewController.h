//
//  PlayViewController.h
//  Brain Numbers
//
//  Created by Patrick Santana on 19/09/09.
//  Copyright 2010 Moogu. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "OFCallbackable.h"
#import "OFDefaultTextField.h"
#import "OFLeaderboard.h"

@interface PlayViewController: UIViewController <OFCallbackable,  OFLeaderboardDelegate, OFHighScoreDelegate, UIActionSheetDelegate>{
	
	NSTimer *timer;
	NSInteger initialTimer;
	NSString *operation;
	NSString *operationHighScore;
	
	/** 
	 * Variables for the game 
	 */
	int number1;
	int number2;
	int result;
	NSInteger counterMaxNumber, maxNumber;
	
	UITextField *nameField;
	

	
	// to control the timer, sucessed and failed 
	IBOutlet UILabel  *numberOfSucessed;
	IBOutlet UILabel  *secondsToFinish;
	IBOutlet UILabel  *numberOfFailed;
	
	// For the question and solutions 
	IBOutlet UILabel  *question;
	IBOutlet UILabel  *solutionLeft;
	IBOutlet UILabel  *solutionCenter;
	IBOutlet UILabel  *solutionRight;
	
	// To disable button if needed
	IBOutlet UIButton *buttonLeft;
	IBOutlet UIButton *buttonCenter;
	IBOutlet UIButton *buttonRight;
	
	/** for the setup
	 * 1 Plus
	 * 2 Minus
	 * 3 Multiply
	 * 4 Divide
	 * 5 All
	 */
	int buttonSelectedOnSetup;
}

// to return to menu 
-(IBAction) returnToViewController:(id) sender;

// actions if user press the buttons 
-(IBAction) buttonLeft:(id) sender;
-(IBAction) buttonCenter:(id) sender;
-(IBAction) buttonRight:(id) sender;

// it will do all calculation to put in the screen 
-(void) generateChallenge;

// used to do the action from the 3 buttons 
-(void) actionButton:(int) pIntButton;

// validation time. It will make the Game Over
-(void) validationTime;

// return to the main menu
-(void) returnToMenu;

// initiate all variables for the game */
-(void) initVariables;
@end
