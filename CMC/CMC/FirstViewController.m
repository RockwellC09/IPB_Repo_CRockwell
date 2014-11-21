//
//  FirstViewController.m
//  CMC
//
//  Created by Christopher Rockwell on 11/17/14.
//  Copyright (c) 2014 Christopher Rockwell. All rights reserved.
//

#import "FirstViewController.h"
#import "CategorySliderView.h"

@interface FirstViewController ()
@property (nonatomic, strong) CategorySliderView *sliderView;
@property (nonatomic, strong) CategorySliderView *sliderView2;
@end

UILabel *oldView;
UILabel *oldView2;
bool first;
bool first2;
NSInteger stepVal;
bool isStepper;

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // set tabbat color
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:0.82 green:0.125 blue:0.157 alpha:1] /*#d12028*/];
    
    // set defaults
    first = true;
    first2 = true;
    resultsLabel.clipsToBounds = YES;
    [resultsLabel.layer setCornerRadius:4];
    valField.delegate = self;
    [valField addTarget:self
                  action:@selector(textFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];
    [self.circularSlider addTarget:self action:@selector(updateProgress:) forControlEvents:UIControlEventValueChanged];
    self.circularSlider.minimumValue = 1;
    self.circularSlider.maximumValue = 600;
    self.circularSlider.continuous = YES;
    [self.circularSlider setMinimumTrackTintColor:[UIColor colorWithRed:0.82 green:0.125 blue:0.157 alpha:1] /*#d12028*/];
    stepVal = myTempStepper.value;
    saveBtn.layer.cornerRadius = 4;
    saveBtn.layer.borderWidth = 1;
    saveBtn.layer.borderColor = [UIColor colorWithRed:0.82 green:0.125 blue:0.157 alpha:1] /*#d12028*/.CGColor;
    
    // get screen size
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    //CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    // add done button for keyboard
    UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *flexibleSpace =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    UIBarButtonItem* doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleBordered target:self
                                                                  action:@selector(doneBtnClicked:)];
    [doneBtn setTintColor:[UIColor colorWithRed:0.267 green:0.267 blue:0.267 alpha:1] /*#444444*/];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:flexibleSpace, doneBtn, nil]];
    valField.inputAccessoryView = keyboardDoneButtonView;
    
    // setup bottom slider
    self.sliderView2 = [[CategorySliderView alloc] initWithSliderHeight:60 andCategoryViews:@[[self labelWithText2:@" US Teaspoons"], [self labelWithText2:@"US Tablespoons"], [self labelWithText2:@"Cups"], [self labelWithText2:@"US Ounces"], [self labelWithText2:@"Grams"], [self labelWithText2:@"Milliliters"], [self labelWithText2:@"Imp Teaspoons"], [self labelWithText2:@"Imp Tablespoons"], [self labelWithText2:@"Imp Ounces"]] categorySelectionBlock:^(UIView *categoryView, NSInteger categoryIndex) {
        [oldView2 setFont:[UIFont fontWithName:@"Raleway-Medium" size:16.0]];
        UILabel *selectedView = (UILabel *)categoryView;
        [selectedView setFont:[UIFont fontWithName:@"Raleway-Bold" size:17.0]];
        oldView2 = (UILabel *)categoryView;
        [resultsLabel setText:[NSString stringWithFormat:@"1 %@", selectedView.text]];
    }];
    
    // setup top slider
    self.sliderView = [[CategorySliderView alloc] initWithSliderHeight:60 andCategoryViews:@[[self labelWithText:@"US Teaspoons"], [self labelWithText:@"US Tablespoons"], [self labelWithText:@"Cups"], [self labelWithText:@"US Ounces"], [self labelWithText:@"Grams"], [self labelWithText2:@"Milliliters"], [self labelWithText2:@"Imp Teaspoons"], [self labelWithText2:@"Imp Tablespoons"], [self labelWithText2:@"Imp Ounces"]] categorySelectionBlock:^(UIView *categoryView, NSInteger categoryIndex) {
        [oldView setFont:[UIFont fontWithName:@"Raleway-Medium" size:16.0]];
        UILabel *selectedView = (UILabel *)categoryView;
        [selectedView setFont:[UIFont fontWithName:@"Raleway-Bold" size:17.0]];
        [startLabel setText:[NSString stringWithFormat:@"%@", selectedView.text]];
        oldView = (UILabel *)categoryView;
    }];
    [self.sliderView setY:-60];
    [self.sliderView moveY:60 duration:0.5 complation:nil];
    [self.view addSubview:self.sliderView];
    
    [self.sliderView2 setY:-60];
    [self.sliderView2 moveY:screenHeight - 110 duration:0.5 complation:nil];
    [self.view addSubview:self.sliderView2];
    
}

// ran when tempurature slider value is changed
- (IBAction)updateProgress:(UISlider *)sender {
    farLabel.text = [NSString stringWithFormat:@"%.0f° F", self.circularSlider.value];
    celLabel.text = [NSString stringWithFormat:@"%.0f° C", (self.circularSlider.value - 32) * 5 / 9 ];
    if (isStepper) {
        // do nothing
    } else {
        myTempStepper.value = self.circularSlider.value;
        stepVal = myTempStepper.value;
    }
}

// ran when keyboard done button clicked
- (void)doneBtnClicked:(id)sender {
    NSString *strWithoutCommas = [valField.text
                                  stringByReplacingOccurrencesOfString:@"," withString:@""];
    myStepper.value = [strWithoutCommas intValue];
    if ([valField.text isEqualToString:@"0"]) {
        valField.text = @"1";
    }
    [self.view endEditing:YES];
}

// ran when measurements stepper is clicked
-(IBAction)stepperPress:(id)sender{
    NSString *textFieldText = [[NSString stringWithFormat:@"%f", myStepper.value] stringByReplacingOccurrencesOfString:@"," withString:@""];
    
    NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
    [numFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *formattedOutput = [numFormatter stringFromNumber:[NSNumber numberWithInt:[textFieldText intValue]]];
    valField.text = formattedOutput;
}

// ran when temperature stepper is clicked
-(IBAction)stepperPress2:(id)sender{
    if (stepVal >= myTempStepper.value) {
        if (self.circularSlider.value == 1) {
            isStepper = true;
            [self.circularSlider setValue:600];
            isStepper = false;
            stepVal = 0;
        } else {
            isStepper = true;
            [self.circularSlider setValue:self.circularSlider.value - 1];
            isStepper = false;
            stepVal--;
        }
    } else {
        if (self.circularSlider.value < 600) {
            isStepper = true;
            [self.circularSlider setValue:self.circularSlider.value + 1];
            stepVal++;
        } else {
            isStepper = true;
            [self.circularSlider setValue:1];
            isStepper = false;
            stepVal = 1;
        }
    }
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [textField selectAll:self];
}

-(void)textFieldDidChange:(UITextField *)textField
{
    NSString *textFieldText = [textField.text stringByReplacingOccurrencesOfString:@"," withString:@""];
    
    NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
    [numFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *formattedOutput = [numFormatter stringFromNumber:[NSNumber numberWithInt:[textFieldText intValue]]];
    valField.text = formattedOutput;
}

- (UILabel *)labelWithText:(NSString *)text {
    //float w = [text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}].width;
    
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 60)];
    [myLabel setTextColor:[UIColor whiteColor]];
    if (first) {
        [myLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:17.0]];
        oldView = (UILabel *)myLabel;
        first = false;
    } else {
        [myLabel setFont:[UIFont fontWithName:@"Raleway-Medium" size:16.0]];
    }
    [myLabel setText:text];
    [myLabel setTextAlignment:NSTextAlignmentCenter];
    return myLabel;
}

- (UILabel *)labelWithText2:(NSString *)text {
    //float w = [text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}].width;
    
    UILabel *myLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 60)];
    [myLabel2 setTextColor:[UIColor whiteColor]];
    if (first2) {
        [myLabel2 setFont:[UIFont fontWithName:@"Raleway-Bold" size:17.0]];
        oldView2 = (UILabel *)myLabel2;
        first2 = false;
    } else {
        [myLabel2 setFont:[UIFont fontWithName:@"Raleway-Medium" size:16.0]];
    }
    [myLabel2 setText:text];
    [myLabel2 setTextAlignment:NSTextAlignmentCenter];
    return myLabel2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
