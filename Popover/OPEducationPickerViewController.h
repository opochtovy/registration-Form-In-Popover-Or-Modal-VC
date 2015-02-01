//
//  OPEducationPickerViewController.h
//  Popover
//
//  Created by Oleg Pochtovy on 26.01.15.
//  Copyright (c) 2015 Oleg Pochtovy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OPEducationPickerDelegate;

@interface OPEducationPickerViewController : UIViewController <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *educationListTableView;

@property (strong, nonatomic) NSArray *educationListArray;

// this property checkmarkIndexPath is necessary to store the selected value
@property (strong, nonatomic) NSIndexPath *checkmarkIndexPath;

// property delegate
@property (weak, nonatomic) id <OPEducationPickerDelegate> delegate;

@end

@protocol OPEducationPickerDelegate

@required
- (void)educationHasChangedInEducationList:(OPEducationPickerViewController *)educationList;

@end