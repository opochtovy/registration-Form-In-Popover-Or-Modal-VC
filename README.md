registration-Form-In-Popover-Or-Modal-VC
==============================================================

API illustrates the work with popover VC in universal app, for iPhone I used modal VC instead of popover.

During my app’s realization I touched the following topics:

- custom type of data; 
- protocols and delegates;
- UIDatePicker.

Key features of the app: 

1. this app is universal (iPhone / iPad);
2. using table views with static cells and dynamic cells;
3. creating of my own protocols and using delegates for them;
4. after pressing textField with birthDate there is no textField editing but the popover with UIDatePicker appears to choose a date and display it in the textField (create protocol OPDatePickerDelegate);
5. after pressing textField with education there is no textField editing but the popover with UITableView appears to choose a field in the list and display it in the textField and checkbox for it (create protocol OPEducationPickerDelegate).