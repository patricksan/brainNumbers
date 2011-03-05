//
//  PlayViewController.m
//  Brain Numbers
//
//  Created by Patrick Santana on 19/09/09.
//  Copyright 2010 Moogu. All rights reserved.
//

#import "PlayViewController.h"
#import "OpenFeint.h"
#import "OFAchievement.h"
#import "OFAchievementService.h"
#import "OFHighScoreService.h"
#import "OFLeaderboardService.h"
#import "OFLeaderboard.h"
#import "OFViewHelper.h"
#import "OpenFeint+Dashboard.h"
#import "OFControllerLoader.h"
#import "OFLeaderboard.h"

@implementation PlayViewController


/** Return to the main Menu */
-(IBAction) returnToViewController:(id) sender{
	/** stop the timer */
	[timer invalidate];
	
	[self returnToMenu];
}

-(void) returnToMenu{
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

-(IBAction) buttonLeft:(id) sender{
	NSLog(@"Pressed button left");
	[self actionButton:1];
}

-(IBAction) buttonCenter:(id) sender{
	NSLog(@"Pressed button center");
	[self actionButton:2];
}

-(IBAction) buttonRight:(id) sender{
	NSLog(@"Pressed button right");	
	[self actionButton:3];
}

/**
 * Trigger the actions for each button
 * pIntButton = 1 => button left
 * pIntButton = 2 => button center
 * pIntButton = 3 => button right
 */
-(void) actionButton:(int) pIntButton{
	int answerUser = 0;
	
	if (pIntButton == 1){
		answerUser = [[solutionLeft text] integerValue];
	}else if (pIntButton == 2) {
		answerUser = [[solutionCenter text] integerValue];
	}else {
		/** button 3 */
		answerUser = [[solutionRight text] integerValue];
	}
	
	// compare with result
	if (answerUser == result) {
		NSLog(@"User got correct answer");
		
		// increase point
		int auxNumberOfSucessed = [[numberOfSucessed text] integerValue];
		auxNumberOfSucessed++;
		numberOfSucessed.text = [NSString stringWithFormat:@"%d", auxNumberOfSucessed];
		
		// increase second
		initialTimer++;
		secondsToFinish.text = [NSString stringWithFormat:@"%d", initialTimer];
		
		// increase counter
		counterMaxNumber++;
	}else {
		NSLog(@"User got incorrect answer");
		
		// increase erros
		int auxNumberOfFailed= [[numberOfFailed text] integerValue];
		auxNumberOfFailed++;
		numberOfFailed.text = [NSString stringWithFormat:@"%d", auxNumberOfFailed];
		
		
		// decrease second
		initialTimer--;
		secondsToFinish.text = [NSString stringWithFormat:@"%d", initialTimer];
	}
	
	
	if (counterMaxNumber >= 3){
		counterMaxNumber = 0;
		maxNumber++;
	}
	
	// can continue the game */
	[self validationTime];
	
	//new challenge
	[self generateChallenge];	
	
	
}
-(void) validationTime{
	if (initialTimer < 1){		
		/** stop the timer */
		[timer invalidate];
		
		/** time is over */
		NSLog(@"Game over");
		
		
		/** result from the game */
		int auxNumberOfSucessed = [[numberOfSucessed text] integerValue];
		int auxNumberOfFailed= [[numberOfFailed text] integerValue];
		NSLog(@"Failed %d",auxNumberOfFailed);
		
		/** Achievement just for All Operations */
		if (buttonSelectedOnSetup == 5) {
			if (auxNumberOfSucessed >= 10 && auxNumberOfSucessed < 20){
				[OFAchievementService updateAchievement:@"613162" andPercentComplete:100 andShowNotification:YES];
			}else if (auxNumberOfSucessed >= 20 && auxNumberOfSucessed < 30){
				[OFAchievementService updateAchievement:@"613162" andPercentComplete:100 andShowNotification:NO];
				[OFAchievementService updateAchievement:@"612672" andPercentComplete:100 andShowNotification:YES];
			}else if (auxNumberOfSucessed >= 30 && auxNumberOfSucessed < 50){
				[OFAchievementService updateAchievement:@"613162" andPercentComplete:100 andShowNotification:NO];
				[OFAchievementService updateAchievement:@"612672" andPercentComplete:100 andShowNotification:NO];
				[OFAchievementService updateAchievement:@"612682" andPercentComplete:100 andShowNotification:YES];
			}else if (auxNumberOfSucessed >= 50 && auxNumberOfSucessed < 60){
				[OFAchievementService updateAchievement:@"613162" andPercentComplete:100 andShowNotification:NO];
				[OFAchievementService updateAchievement:@"612672" andPercentComplete:100 andShowNotification:NO];
				[OFAchievementService updateAchievement:@"612682" andPercentComplete:100 andShowNotification:NO];
				[OFAchievementService updateAchievement:@"612692" andPercentComplete:100 andShowNotification:YES];
			}else if (auxNumberOfSucessed >= 60 && auxNumberOfSucessed < 100){
				[OFAchievementService updateAchievement:@"613162" andPercentComplete:100 andShowNotification:NO];
				[OFAchievementService updateAchievement:@"612672" andPercentComplete:100 andShowNotification:NO];
				[OFAchievementService updateAchievement:@"612682" andPercentComplete:100 andShowNotification:NO];
				[OFAchievementService updateAchievement:@"612692" andPercentComplete:100 andShowNotification:NO];
				[OFAchievementService updateAchievement:@"612842" andPercentComplete:100 andShowNotification:YES];
			}else if (auxNumberOfSucessed >= 100){
				[OFAchievementService updateAchievement:@"613162" andPercentComplete:100 andShowNotification:NO];
				[OFAchievementService updateAchievement:@"612672" andPercentComplete:100 andShowNotification:NO];
				[OFAchievementService updateAchievement:@"612682" andPercentComplete:100 andShowNotification:NO];
				[OFAchievementService updateAchievement:@"612692" andPercentComplete:100 andShowNotification:NO];
				[OFAchievementService updateAchievement:@"612842" andPercentComplete:100 andShowNotification:NO];
				[OFAchievementService updateAchievement:@"612852" andPercentComplete:100 andShowNotification:YES];
			}
		}
		BOOL isAll = NO;
		
		/** save highscore */
		if (buttonSelectedOnSetup == 1){	
			/** plus */
			[OFHighScoreService setHighScore: auxNumberOfSucessed forLeaderboard:@"504444" onSuccess:OFDelegate() onFailure:OFDelegate()];
		}else if (buttonSelectedOnSetup == 2){		
			/** minus */
			[OFHighScoreService setHighScore: auxNumberOfSucessed forLeaderboard:@"504434" onSuccess:OFDelegate() onFailure:OFDelegate()];
		}else if (buttonSelectedOnSetup == 3){
			/** Multiply */
			[OFHighScoreService setHighScore: auxNumberOfSucessed forLeaderboard:@"504454" onSuccess:OFDelegate() onFailure:OFDelegate()];
		}else if (buttonSelectedOnSetup == 4){
			/** Divide */
			[OFHighScoreService setHighScore: auxNumberOfSucessed forLeaderboard:@"504464" onSuccess:OFDelegate() onFailure:OFDelegate()];
		}else if (buttonSelectedOnSetup == 5) {
			/** All Operations */
			[OFHighScoreService setHighScore: auxNumberOfSucessed forLeaderboard:@"504214" onSuccess:OFDelegate() onFailure:OFDelegate()];
			isAll = YES;
		}
		
		if (isAll){
			UIActionSheet *showResult = [[UIActionSheet alloc] initWithTitle:[NSString stringWithFormat:@"GAME OVER \nYou did %d / %d! Congratulations.", auxNumberOfSucessed, auxNumberOfFailed] delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles: @"OK",nil];		
			[showResult showInView:self.view];
		}else {
			UIActionSheet *showResult = [[UIActionSheet alloc] initWithTitle:[NSString stringWithFormat:@"GAME OVER \nYou did %d / %d! Achievements come just with All Operations Games.", auxNumberOfSucessed, auxNumberOfFailed] delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles: @"OK",nil];		
			[showResult showInView:self.view];

		}
		
		

		
		
		/** return to the menu */
		[self returnToMenu];
	}
}

- (void) decreaseTime{
	NSLog(@"Let's decrease the time");
	initialTimer = [[secondsToFinish text] integerValue];
	initialTimer--;
	secondsToFinish.text = [NSString stringWithFormat:@"%d", initialTimer];
	
	[self validationTime];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {	    
	[super viewDidLoad];
}


- (void) generateChallenge{
	NSLog(@"Starting the game");
	
	if (buttonSelectedOnSetup == 5){
		//Calculate operation with user selected in setup to show all operations 
		int randomOperation = 1 + arc4random() % 4;
		NSLog(@"Random value = %d", randomOperation);
		
		if ( randomOperation == 1 ){
			operation = @"+";
		}else if ( randomOperation == 2 ){
			operation = @"-";
		}else if ( randomOperation == 3 ){
			operation = @"X";
		}else if ( randomOperation == 4 ){
			operation = @":";
		}
	}else {
		if (buttonSelectedOnSetup == 1){	
			operation = @"+";
		}else if (buttonSelectedOnSetup == 2){	
			operation = @"-";
		}else if (buttonSelectedOnSetup == 3){
			operation = @"X";
		}else if (buttonSelectedOnSetup == 4){
			operation = @":";
		}
	}
	
	
	NSLog(@"Operation = %@", operation);
	
	/** 
	 * Calculation of Numbers
	 */
	BOOL isGoodNumber = NO;
	while ( isGoodNumber == NO ) {
		
		// Calculate number 1 
		number1 = 1 + arc4random() % maxNumber;
		// Calculate number 2 	
		number2 = 1 + arc4random() % maxNumber;
		
		// validate if it is a good number 
		if ( operation == @"-" && number1 != number2){
			isGoodNumber = YES;
		} else if (operation == @"+" || operation == @"X" || operation == @":") {
			isGoodNumber = YES;
		} 
    }
	
	NSLog(@"Number 1 = %d", number1);
	NSLog(@"Number 2 = %d", number2);	
	
	
	/**
	 * Validations
	 */
	if ( operation == @"-" && number1 < number2){
		int aux = number1;
		number1 = number2;
		number2 = aux;
	}
	
	if ( operation == @":"){
		number1 = number1*number2;
	}	
	
	// Calculate the result
	if ( operation == @"+"){
		result = number1+number2;
	} else if ( operation == @"-"){
		result = number1-number2;
	} else if ( operation == @"X"){
		result = number1*number2;
	} else if ( operation == @":"){
		result = number1/number2;
	}
	
	
	// Add number 1 + operation + number 2 to screen
	NSString *screenQuestion = [NSString stringWithFormat:@"%d %@ %d", number1, operation, number2];
	question.text = [NSString stringWithFormat:@"%@", screenQuestion];
	
	// calculate the random position 
	int position = 1 + arc4random() % 3;
	
	/** Add result to this position */
	if (position == 1){
		solutionLeft.text=[NSString stringWithFormat:@"%d", result];
	} else if (position == 2){
		solutionCenter.text=[NSString stringWithFormat:@"%d", result];
	} else {
		solutionRight.text=[NSString stringWithFormat:@"%d", result];
	}
	
	
	// create fake result 
	if ( operation == @"X"){
		if (number1 > 10 || number2 > 10){
			if (position != 1){
				solutionLeft.text=[NSString stringWithFormat:@"%d", result-10];
			}	
			
			if (position != 2){
				solutionCenter.text=[NSString stringWithFormat:@"%d", result+10];
			}
			
			if (position != 3){
				solutionRight.text=[NSString stringWithFormat:@"%d", result-20];
			}	
		}else {
			if (position != 1){
				solutionLeft.text=[NSString stringWithFormat:@"%d", result-number1];
			}	
			
			if (position != 2){
				solutionCenter.text=[NSString stringWithFormat:@"%d", result+number1];
			}
			
			if (position != 3){
				solutionRight.text=[NSString stringWithFormat:@"%d", result-number2];
			}	
		}
	} else {
		if (position != 1){
			solutionLeft.text=[NSString stringWithFormat:@"%d", result-1];
		}	
		
		if (position != 2){
			solutionCenter.text=[NSString stringWithFormat:@"%d", result+1];
		}
		
		if (position != 3){
			solutionRight.text=[NSString stringWithFormat:@"%d", result+2];
		}	
	}
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


- (void)dealloc {
	[operation release];
	[timer release];
	[super dealloc];
}

- (void) initVariables{
	NSLog(@"Invoking initVariables");
	
	/** set variables */
	initialTimer = 15;
	counterMaxNumber=0;
	maxNumber=3;
	int numbers = 0;
	
	/** Prepare screen */
	numberOfFailed.text = [NSString stringWithFormat:@"%d", numbers];
	numberOfSucessed.text = [NSString stringWithFormat:@"%d", numbers];
	secondsToFinish.text = [NSString stringWithFormat:@"%d", initialTimer];
	
	
	/** get information from the setup */
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:@"setup.plist"];
	NSDictionary *plistDict = [[NSDictionary alloc] initWithContentsOfFile:path];
	NSNumber *function = [plistDict objectForKey:@"function"];
	buttonSelectedOnSetup = [function intValue];
	
	
	/** generate the initial data*/
	[self generateChallenge];
	
	/** set initial timer */
	NSLog(@"Starting time");
	timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(decreaseTime) userInfo:nil repeats:YES];
}

- (void)didSubmit:(OFHighScore *)score
{
	OFLog(@"successfully submitted high score");
}

- (void)didFailSubmit:(OFHighScore *)score
{
	OFLog(@"failed submitting high score");
}

- (void)viewWillDisappear:(BOOL)animated{
	NSLog(@" viewWillDisappear");
	[super viewWillDisappear:animated];
}

- (bool)canReceiveCallbacksNow
{
	return YES;
}

@end
