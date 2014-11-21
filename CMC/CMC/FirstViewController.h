//
//  FirstViewController.h
//  CMC
//
//  Created by Christopher Rockwell on 11/17/14.
//  Copyright (c) 2014 Christopher Rockwell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICircularSlider.h"

@interface FirstViewController : UIViewController <UITextFieldDelegate>
{
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *resultsLabel;
    IBOutlet UILabel *startLabel;
    IBOutlet UIStepper *myStepper;
    IBOutlet UIStepper *myTempStepper;
    IBOutlet UITextField *valField;
    IBOutlet UILabel *farLabel;
    IBOutlet UILabel *celLabel;
    IBOutlet UIButton *saveBtn;
}

@property (unsafe_unretained, nonatomic) IBOutlet UICircularSlider *circularSlider;

@end

