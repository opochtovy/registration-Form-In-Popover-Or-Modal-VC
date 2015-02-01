//
//  OPTableViewController.m
//  Popover
//
//  Created by Oleg Pochtovy on 26.01.15.
//  Copyright (c) 2015 Oleg Pochtovy. All rights reserved.
//

#import "OPTableViewController.h"
#import "OPInfoViewController.h"
#import "OPDatePickerViewController.h"
#import "OPEducationPickerViewController.h"

// here we create our custom data type for UISegmentedControl's index (value)
typedef enum {
    OPSexTypeFemale, // by default 0
    OPSexTypeMale // by default 1
} OPSexType;

@interface OPTableViewController () <UIPopoverControllerDelegate, UITextFieldDelegate, OPDatePickerDelegate, OPEducationPickerDelegate>

@property (strong, nonatomic) UIPopoverController *popover;

// property is necessary for saving the chosen date in UIDatePicker and loading it after the next pressing of dateOfBirthTextField
@property (strong, nonatomic) NSDate *selectedDateOfBirth;
// property is necessary for saving the chosen field index in education list
@property (strong, nonatomic) NSIndexPath *checkmarkIndexPath;

@end

@implementation OPTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // assign delegates for all textFields
    self.firstNameField.delegate = self;
    self.lastNameField.delegate = self;
    self.dateOfBirthField.delegate = self;
    self.educationField.delegate = self;
    
    self.sexControl.selectedSegmentIndex = OPSexTypeMale;
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Private Methods

- (void)showControllerAsModal:(UIViewController *)vc {
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:nav
                       animated:YES
                     completion:nil];
}

- (void)showControllerAsPopoverFromTextField:(UIViewController *)vc {
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:nav];
    
    vc.preferredContentSize = CGSizeMake(300, 240);
    
    popover.delegate = self;
    
    self.popover = popover;
    
    // we need convert coordinates of textField from textField's cellView to self.view!
    CGRect rectInSelfView = [self.view convertRect:[self.dateOfBirthField frame] fromView:self.dateOfBirthCell];
    [popover presentPopoverFromRect:rectInSelfView
                             inView:self.view
           permittedArrowDirections:UIPopoverArrowDirectionAny
                           animated:YES];
}

- (void)showController:(UIViewController *)vc inPopoverFromSender:(id)sender {
    
    // we need to check if there is no sender
    if (!sender) {
        return;
    }
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:nav];
    
    popover.delegate = self;
    
    self.popover = popover;
    
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
        
        popover.popoverContentSize = CGSizeMake(320, 320);
        
        [popover presentPopoverFromBarButtonItem:sender
                        permittedArrowDirections:UIPopoverArrowDirectionAny
                                        animated:YES];
    } else if ([sender isKindOfClass:[UITextField class]]) {
        
        CGRect rectInSelfView;
        if ([sender isEqual:self.dateOfBirthField]) {
            
            popover.popoverContentSize = CGSizeMake(300, 240);
            
            rectInSelfView = [self.view convertRect:[self.dateOfBirthField frame] fromView:self.dateOfBirthCell];
            
        } else {
            
            rectInSelfView = [self.view convertRect:[self.educationField frame] fromView:self.educationCell];
        }
        
        [popover presentPopoverFromRect:rectInSelfView
                                 inView:self.tableView
               permittedArrowDirections:UIPopoverArrowDirectionAny
                               animated:YES];
    }
    
}

#pragma mark - Actions

- (IBAction)actionInfo:(UIBarButtonItem *)sender {
    
    OPInfoViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"OPInfoViewController"];
    vc.title = @"App information";
    
    // here we check for kind of a device
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        [self showController:vc inPopoverFromSender:sender];
        
    } else {
        
        [self showControllerAsModal:vc];
        
    }
    
}

#pragma mark - UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    
    self.popover = nil; // this will dismiss popover immediately but we neen the code line ( popover.delegate = self; ) in methods showControllerAsPopoverFromTextField: or showController:inPopoverFromSender:
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([textField isEqual:self.firstNameField]) {
        [self.lastNameField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if ([textField isEqual:self.dateOfBirthField]) {
        
        // here we initialize popover with UIDatePicker
        
        // Storyboard ID = OPDatePickerViewController
        OPDatePickerViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"OPDatePickerViewController"];
        vc.title = @"Pick date of birth";
        
        // selected birthdate is always displayed every time we select dateOfBirthField
        if (self.selectedDateOfBirth) {
            
            vc.selectedDateOfBirth = self.selectedDateOfBirth;
        }
        
        vc.delegate = self; // every time we choose a date in UIDatePicker we need to execute the method dateHasChangedInDatePicker: in method actionPickDate: of OPDatePickerViewController
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            [self showController:vc inPopoverFromSender:textField];
            
            // We create a protocol OPDatePickerDelegate for the class OPDatePickerViewController and property delegate, through which we will send a date from UIDatePicker. After that we assign that protocol to the class OPTableViewController, write the code for protocol method and run that method!
            
        } else {
            
            [self showControllerAsModal:vc];
            
        }
        
        return NO;
    } else if ([textField isEqual:self.educationField]) { // 9.1
        
        
        OPEducationPickerViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"OPEducationPickerViewController"];
        vc.title = @"Pick education";
        
        // here we substitute the previously selected education field in our new popover
        vc.checkmarkIndexPath = self.checkmarkIndexPath;
        
        // here we set the delegate before creating a popover
        vc.delegate = self;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            [self showController:vc inPopoverFromSender:textField];
            
        } else {
            
            [self showControllerAsModal:vc];
            
        }
        
        return NO;
    }
    
    return YES;
    
}

#pragma mark - OPDatePickerDelegate
- (void)dateHasChangedInDatePicker:(OPDatePickerViewController *)datePicker {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"dd MMMM yyyy"];
    
    self.dateOfBirthField.text = [dateFormatter stringFromDate:datePicker.birthDatePicker.date];
    
    self.selectedDateOfBirth = datePicker.birthDatePicker.date;
    
}

- (void)educationHasChangedInEducationList:(OPEducationPickerViewController *)educationList {
    
    self.educationField.text = [educationList.educationListArray objectAtIndex:educationList.checkmarkIndexPath.row];
    self.checkmarkIndexPath = educationList.checkmarkIndexPath;
    
}

@end