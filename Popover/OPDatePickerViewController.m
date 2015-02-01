//
//  OPDatePickerViewController.m
//  Popover
//
//  Created by Oleg Pochtovy on 26.01.15.
//  Copyright (c) 2015 Oleg Pochtovy. All rights reserved.
//

#import "OPDatePickerViewController.h"

@implementation OPDatePickerViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if (self.selectedDateOfBirth) {
        self.birthDatePicker.date = self.selectedDateOfBirth;
    }
    else {
        
        self.birthDatePicker.date = self.birthDatePicker.maximumDate;
        
        [self actionPickDate:self.birthDatePicker];
    }
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    
    NSLog(@"datePickerPopover is deallocated");
}

#pragma mark - Actions
- (IBAction)actionDone:(UIButton *)sender {
    
[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)actionPickDate:(UIDatePicker *)sender {
    
    // each time we choose a date in UIDatePicker delegate of this class executes the method  dateHasChangedInDatePicker:
    [self.delegate dateHasChangedInDatePicker:self];
    
}

@end