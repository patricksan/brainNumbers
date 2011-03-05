//
//  RecordViewController.h
//  Brain Numbers
//
//  Created by Patrick Santana on 19/09/09.
//  Copyright 2010 Moogu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HighScoreRecord.h"
#import "HighScores.h"


@interface RecordViewController : UIViewController {
	
	/** the actual function selected */
	int buttonSelected;
	
	/** to configure */
	IBOutlet UIImageView *buttonSelectedPlus;
	IBOutlet UIImageView *buttonSelectedMinus;
	IBOutlet UIImageView *buttonSelectedMultiply;
	IBOutlet UIImageView *buttonSelectedDivide;
	IBOutlet UIImageView *buttonSelectedAll;
	
	/** values for the record - name */
	IBOutlet UILabel *labelScoreName1;
	IBOutlet UILabel *labelScoreName2;
	IBOutlet UILabel *labelScoreName3;
	IBOutlet UILabel *labelScoreName4;
	IBOutlet UILabel *labelScoreName5;
	IBOutlet UILabel *labelScoreName6;
	IBOutlet UILabel *labelScoreName7;
	IBOutlet UILabel *labelScoreName8;
	IBOutlet UILabel *labelScoreName9;
	IBOutlet UILabel *labelScoreName10;
	
	/** values for the record - value */
	IBOutlet UILabel *labelScoreValue1;
	IBOutlet UILabel *labelScoreValue2;
	IBOutlet UILabel *labelScoreValue3;
	IBOutlet UILabel *labelScoreValue4;
	IBOutlet UILabel *labelScoreValue5;
	IBOutlet UILabel *labelScoreValue6;
	IBOutlet UILabel *labelScoreValue7;
	IBOutlet UILabel *labelScoreValue8;
	IBOutlet UILabel *labelScoreValue9;
	IBOutlet UILabel *labelScoreValue10;

}

- (void) showHighScore;
- (void) cleanHighScore;
-(void) showData:(NSArray *) array;

-(IBAction) returnToViewController:(id) sender;

// actions if user press the buttons 
-(IBAction) buttonPlus:(id) sender;
-(IBAction) buttonMinus:(id) sender;
-(IBAction) buttonMultiply:(id) sender;
-(IBAction) buttonDivide:(id) sender;
-(IBAction) buttonAll:(id) sender;


@end
