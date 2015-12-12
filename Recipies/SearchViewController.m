//
//  SearchViewController.m
//  Recipies
//
//  Created by Brendan Kenny on 12/2/14.
//  Copyright (c) 2014 Brendan Kenny. All rights reserved.
//

#import "SearchViewController.h"
#import "Recipe.h"
#import "RecipeDetailTableVC.h"

@interface SearchViewController ()
@property (nonatomic) NSMutableArray *array;

@end

@implementation SearchViewController{
    NSMutableArray *_data;
    NSURLSession *_session;
}
//URL Components
NSString * YUMMLY_URL = @"http://api.yummly.com/v1/api/recipes?_app_id=";
NSString *YUMMLY_USER_KEY = @"2ca5145e";
NSString * YUMMLY_API_KEY = @"ac7c425cb35c9e0feb4be5749edf664c";

- (void)viewDidLoad {
    [super viewDidLoad];
    //initialize data
    _data = [NSMutableArray array];
}
- (void) awakeFromNib{
    [super awakeFromNib];
    [[UINavigationBar appearance] setBarTintColor: [UIColor colorWithRed:.24 green:.64 blue:.20 alpha:1.0]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:.24 green:.64 blue:.20 alpha:1.0]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return _data.count;
}

//Create the URL, and download the JSON from it.
-(void)loadData:(NSString *)artist{
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    _session = [NSURLSession sessionWithConfiguration:config];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSMutableString *searchString = [NSMutableString string];
    [searchString appendString:YUMMLY_URL];
    [searchString appendString:YUMMLY_USER_KEY];
    [searchString appendString:@"&_app_key="];
    [searchString appendString:YUMMLY_API_KEY];
    [searchString appendString:@"&q="];
    artist = [artist stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [searchString appendString:artist];
    NSURL *url = [NSURL URLWithString: searchString];
    
    NSURLSessionDataTask *dataTask = [_session dataTaskWithURL:url
                                             completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
                                                 if(!error){
                                                     NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*)response;
                                                     if (httpResp.statusCode == 200){
                                                         NSError *jsonError;
                                                         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
                                                         if (!jsonError) {
                                                             NSArray *allEvents = json[@"matches"];
                                                             NSMutableArray *tempArray = [NSMutableArray array];
                                                             
                                                        
                                                             
                                                             for(NSDictionary *d in allEvents){
                                                                 Recipe *concert = [[Recipe alloc]initWithDictionary:d];
                                                                 [tempArray addObject:concert];
                                                             }
                                                             
                                                             if(tempArray.count == 0){
                                                                 Recipe *concert = [[Recipe alloc] initWithDictionary:@{@"title": @"No results found"}];
                                                                 [tempArray addObject:concert];
                                                             }
                                                             
                                                             dispatch_async(dispatch_get_main_queue(),^{
                                                                 [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                                                 _data = tempArray;
                                                                 [self.tableView reloadData];
                                                             });
                                                         }
                                                     }
                                                 }
                                             }
                                      ];
    [dataTask resume];
}



//SearrchBar Functions
-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

-(void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES animated:YES];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:NO animated:YES];
}

-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [self loadData:searchBar.text];
}

//Displays results from the search
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Recipe *recipe = _data[indexPath.row];
    
    
    if([recipe.recipeTitle isEqualToString:@""]){
        [cell setUserInteractionEnabled:NO];
        cell.textLabel.font = [UIFont fontWithName:@"Avenir Next" size:20.0];
        cell.textLabel.text = @"NO RESULTS";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    else{
        cell.textLabel.text = recipe.recipeTitle;
        cell.textLabel.font = [UIFont fontWithName:@"Avenir Next" size:18.0];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.detailTextLabel.text = recipe.recipeID;
        
        [cell setUserInteractionEnabled:YES];
        
    }
    
    return cell;
    
}

//Sends the selected recipe to the next VC
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"ShowRecipeDetail"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        RecipeDetailTableVC * newVC = segue.destinationViewController;
        Recipe *recipe = [_data objectAtIndex:indexPath.row];
        newVC.recipe = recipe;
        newVC.title = recipe.recipeTitle;
    }
}

@end
