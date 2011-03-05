//
//  RecordViewController.m
//  Brain Numbers
//
//  Created by Patrick Santana on 19/09/09.
//  Copyright 2010 Moogu. All rights reserved.
//

#import "RecordViewController.h"

@implementation RecordViewController

-(IBAction) buttonPlus:(id) sender{
	/** change properties in the screen */
	buttonSelectedPlus.hidden = NO;
	buttonSelectedMinus.hidden = YES;
	buttonSelectedMultiply.hidden = YES;
	buttonSelectedDivide.hidden = YES;
	buttonSelectedAll.hidden = YES;
	
	/** keep the function selected */
	buttonSelected = 1;
	
	[self showHighScore];
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
	
	[self showHighScore];
	
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
	
	[self showHighScore];
	
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
	
	[self showHighScore];
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
	
	[self showHighScore];
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
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidLoad {
	/** change properties in the screen */
	buttonSelectedPlus.hidden = YES;
	buttonSelectedMinus.hidden = YES;
	buttonSelectedMultiply.hidden = YES;
	buttonSelectedDivide.hidden = YES;
	buttonSelectedAll.hidden = NO;
	
	/** keep the function selected */
	buttonSelected = 5;
	
	[self showHighScore];
	
}

- (void) showHighScore{
	/** first clean all data */
	[self cleanHighScore];
	
	/** fill the 10 possibles records. If less than 10, don't show. */
	
	if (buttonSelected == 1){
		
		NSArray *highScoreData = [HighScores getLocalHighScores:HIGH_SCORE_OPERATION_PLUS];
		NSLog(@"Size local high score for PLUS = %d",highScoreData.count);
		
		[self showData:highScoreData];
	}else if (buttonSelected == 2){
		
		NSArray *highScoreData = [HighScores getLocalHighScores:HIGH_SCORE_OPERATION_MINUS];
		NSLog(@"Size local high score for MINUS = %d",highScoreData.count);
		
		[self showData:highScoreData];
	}else if (buttonSelected == 3){
		
		NSArray *highScoreData = [HighScores getLocalHighScores:HIGH_SCORE_OPERATION_MULTIPLY];
		NSLog(@"Size local high score for MULTIPLY = %d",highScoreData.count);
		
		[self showData:highScoreData];
	}else if (buttonSelected == 4){
		
		NSArray *highScoreData = [HighScores getLocalHighScores:HIGH_SCORE_OPERATION_DIVIDE];
		NSLog(@"Size local high score for DIVIDE = %d",highScoreData.count);
		
		[self showData:highScoreData];
	}else if (buttonSelected == 5){
		
		NSArray *highScoreData = [HighScores getLocalHighScores:HIGH_SCORE_OPERATION_ALL];
		NSLog(@"Size local high score for ALL = %d",highScoreData.count);
		[self showData:highScoreData];
	}
}

-(void) showData:(NSArray *) array{
	/** return if there is no record */
	if (array.count == 0){
		return;
	}
	
	HighScoreRecord *score;
	int iCounter = 1;
	
	for (score in array) {
		if (iCounter == 1){
			labelScoreName1.text = [NSString stringWithFormat:@"%@",[score name]];
			labelScoreValue1.text = [NSString stringWithFormat:@"%@ / %@",[score totalScore],[score totalFailScore]];
		}else if (iCounter == 2){
			labelScoreName2.text = [NSString stringWithFormat:@"%@",[score name]];
			labelScoreValue2.text = [NSString stringWithFormat:@"%@ / %@",[score totalScore],[score totalFailScore]];
		}else if (iCounter == 3){
			labelScoreName3.text = [NSString stringWithFormat:@"%@",[score name]];
			labelScoreValue3.text = [NSString stringWithFormat:@"%@ / %@",[score totalScore],[score totalFailScore]];
		}else if (iCounter == 4){
			labelScoreName4.text = [NSString stringWithFormat:@"%@",[score name]];
			labelScoreValue4.text = [NSString stringWithFormat:@"%@ / %@",[score totalScore],[score totalFailScore]];
		}else if (iCounter == 5){
			labelScoreName5.text = [NSString stringWithFormat:@"%@",[score name]];
			labelScoreValue5.text = [NSString stringWithFormat:@"%@ / %@",[score totalScore],[score totalFailScore]];
		}else if (iCounter == 6){
			labelScoreName6.text = [NSString stringWithFormat:@"%@",[score name]];
			labelScoreValue6.text = [NSString stringWithFormat:@"%@ / %@",[score totalScore],[score totalFailScore]];
		}else if (iCounter == 7){
			labelScoreName7.text = [NSString stringWithFormat:@"%@",[score name]];
			labelScoreValue7.text = [NSString stringWithFormat:@"%@ / %@",[score totalScore],[score totalFailScore]];
		}else if (iCounter == 8){
			labelScoreName8.text = [NSString stringWithFormat:@"%@",[score name]];
			labelScoreValue8.text = [NSString stringWithFormat:@"%@ / %@",[score totalScore],[score totalFailScore]];
		}else if (iCounter == 9){
			labelScoreName9.text = [NSString stringWithFormat:@"%@",[score name]];
			labelScoreValue9.text = [NSString stringWithFormat:@"%@ / %@",[score totalScore],[score totalFailScore]];
		}else if (iCounter == 10){
			labelScoreName10.text = [NSString stringWithFormat:@"%@",[score name]];
			labelScoreValue10.text = [NSString stringWithFormat:@"%@ / %@",[score totalScore],[score totalFailScore]];
		}
		iCounter++;
	}

//[score release];
}

-(void) cleanHighScore{

	labelScoreName1.text = [NSString stringWithFormat:@""];
	labelScoreName2.text = [NSString stringWithFormat:@""];
	labelScoreName3.text = [NSString stringWithFormat:@""];
	labelScoreName4.text = [NSString stringWithFormat:@""];
	labelScoreName5.text = [NSString stringWithFormat:@""];
	labelScoreName6.text = [NSString stringWithFormat:@""];
	labelScoreName7.text = [NSString stringWithFormat:@""];
	labelScoreName8.text = [NSString stringWithFormat:@""];
	labelScoreName9.text = [NSString stringWithFormat:@""];
	labelScoreName10.text = [NSString stringWithFormat:@""];
	
	labelScoreValue1.text = [NSString stringWithFormat:@""];
	labelScoreValue2.text = [NSString stringWithFormat:@""];
	labelScoreValue3.text = [NSString stringWithFormat:@""];
	labelScoreValue4.text = [NSString stringWithFormat:@""];
	labelScoreValue5.text = [NSString stringWithFormat:@""];
	labelScoreValue6.text = [NSString stringWithFormat:@""];
	labelScoreValue7.text = [NSString stringWithFormat:@""];
	labelScoreValue8.text = [NSString stringWithFormat:@""];
	labelScoreValue9.text = [NSString stringWithFormat:@""];
	labelScoreValue10.text = [NSString stringWithFormat:@""];
}

- (void)dealloc {
    [super dealloc];
}


@end
