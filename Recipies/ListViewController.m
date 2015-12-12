//
//  ListViewController.m
//  Recipies
//
//  Created by Brendan Kenny on 12/2/14.
//  Copyright (c) 2014 Brendan Kenny. All rights reserved.
//

#import "ListViewController.h"
#import "AppDelegate.h"
#import "Recipe.h"
#import "RecipeDetailTableVC.h"

@interface ListViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) AppDelegate *appDelegate;
@end

@implementation ListViewController {
    UITextField *_taskField;
    
}
#pragma mark - Initialization
- (void)viewDidLoad{
    //Gets any data from AppDelegate to the VC
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self._tasks =  self.appDelegate._tasks;
    
    [super viewDidLoad];
       self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addScreen)];

    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    }

#pragma mark - Public Methods
// array - writeToFile saves a
- (void)saveTasks{
    [self._tasks writeToFile: [self docPath] atomically:YES];
}


#pragma mark - Actions
- (void)addTask{
    // Get the to-do item
    NSString *t = _taskField.text;
    // Quit here if taskField is empty
    if ([t isEqualToString:@""]) {
        [_taskField resignFirstResponder];
        return;
    }
    // Add it to our array
    [self._tasks addObject:t];
    
    // Refresh the table so that the new item shows up
    //[self.tableView reloadData];
    // OR
    // animate a new row sliding in from the right
    NSIndexPath *lastRow = [NSIndexPath indexPathForItem:self._tasks.count-1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[lastRow] withRowAnimation:UITableViewRowAnimationRight];
    
    // Clear out the text field
    _taskField.text = @"";
    // Dismiss the keyboard
    [_taskField resignFirstResponder];
}

#pragma mark - UITextFieldDelegate protocol
// enable the Return button on the keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self addTask];
    return YES;
}


#pragma mark - Table view data source methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    return self._tasks.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Creates cells with the list of ingredients you need to buy
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlainCell" forIndexPath:indexPath];
    cell.textLabel.font = [UIFont fontWithName:@"Avenir Next" size:20.0];
    cell.textLabel.text = self._tasks[indexPath.row];

    
    return cell;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self._tasks removeObjectAtIndex: indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath{
    NSString *s = [self._tasks objectAtIndex:fromIndexPath.row];
    [self._tasks removeObject: s];
    [self._tasks insertObject:s atIndex:toIndexPath.row];
}

-(void)addScreen{
//Creates an alert pop up to add an ingredient to the list
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add an ingredient to buy" message:@""
                                                           delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:NSLocalizedString(@"Add",nil), nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    _taskField =  [alert textFieldAtIndex: 0];
    
    [alert show];
}
//Adds the ingrdient
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(buttonIndex==1){
        [self addTask];
        
    }
}

#pragma mark - Helper methods
// Helper function to fetch the path to our to-do data stored on disk
- (NSString*) docPath{
    NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"to-do-data.plist"];
}

#pragma mark - View Lifecycle
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
