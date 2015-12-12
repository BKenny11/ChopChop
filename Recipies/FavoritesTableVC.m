//
//  FavoritesTableVC.m
//  Recipies
//
//  Created by Brendan Kenny on 12/3/14.
//  Copyright (c) 2014 Brendan Kenny. All rights reserved.
//

#import "FavoritesTableVC.h"
#import "AppDelegate.h"
#import "Recipe.h"
#import "RecipeDetailTableVC.h"
#import "WebPageViewController.h"

@interface FavoritesTableVC ()
@property (weak, nonatomic) AppDelegate *appDelegate;
@end

@implementation FavoritesTableVC{
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    //Gets data from App Delegate to fill list
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self._favs = self.appDelegate._favorites;
    self._urls = self.appDelegate._Urls;
    
}

- (void)saveTasks{
    [self._favs writeToFile: [self docPath] atomically:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return self._favs.count;
}

//Writes favorites to the cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlainCell" forIndexPath:indexPath];
    cell.textLabel.font = [UIFont fontWithName:@"Avenir Next" size:20.0];
    cell.textLabel.text = self._favs[indexPath.row];
    
    return cell;
}

//Sends user to recipe webpage
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"GoToWebPage"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSMutableString *recipeURL = [NSMutableString string];
        [recipeURL appendString:@"http://www.yummly.com/recipe/external/"];
        [recipeURL appendString:self._urls[indexPath.row]];
        NSURL *url = [NSURL URLWithString:recipeURL];
        
        //Created to deal with UIWebView crashing Bug.
        NSString *string = self._urls[indexPath.row];
        if ([string containsString:@"Martha"]) {
            [[UIApplication sharedApplication] openURL:url];
        } else {
            WebPageViewController *Webview = segue.destinationViewController;
            Webview.url = url;

        }
        
    }
}

//Makes Favorites editable
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self._favs removeObjectAtIndex: indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
- (NSString*) docPath{
    NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"to-do-data.plist"];
}

@end
