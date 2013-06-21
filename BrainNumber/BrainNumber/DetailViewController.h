//
//  DetailViewController.h
//  BrainNumber
//
//  Created by Patrick Santana on 20/06/13.
//  Copyright (c) 2013 Patrick Santana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
