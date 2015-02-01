//
//  OPTableViewController.h
//  Popover
//
//  Created by Oleg Pochtovy on 26.01.15.
//  Copyright (c) 2015 Oleg Pochtovy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OPTableViewController : UITableViewController

// connect elements from storyboard with code
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *dateOfBirthField;
@property (weak, nonatomic) IBOutlet UITextField *educationField;

// connect element from storyboard with code
@property (weak, nonatomic) IBOutlet UISegmentedControl *sexControl;

@property (weak, nonatomic) IBOutlet UITableViewCell *dateOfBirthCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *educationCell;

// connect button's action from storyboard with code
- (IBAction)actionInfo:(UIBarButtonItem *)sender;

@end