//
//  OPDatePickerViewController.h
//  Popover
//
//  Created by Oleg Pochtovy on 26.01.15.
//  Copyright (c) 2015 Oleg Pochtovy. All rights reserved.
//

// this class is a popover Controller after pressing the textField "Date of Birth"
#import <UIKit/UIKit.h>

@protocol OPDatePickerDelegate;

@interface OPDatePickerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIDatePicker *birthDatePicker;

@property (weak, nonatomic) id <OPDatePickerDelegate> delegate;

@property (strong, nonatomic) NSDate *selectedDateOfBirth;

// this property selectedEducation is necessary to store the selected value
@property (strong, nonatomic) NSString *selectedEducation;

- (IBAction)actionPickDate:(UIDatePicker *)sender;

- (IBAction)actionDone:(UIButton *)sender;

@end

@protocol OPDatePickerDelegate

@required
- (void)dateHasChangedInDatePicker:(OPDatePickerViewController *)datePicker;

@end