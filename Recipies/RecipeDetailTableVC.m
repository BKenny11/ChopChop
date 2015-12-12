//
//  RecipeDetailTableVC.m
//  Recipies
//
//  Created by Brendan Kenny on 12/2/14.
//  Copyright (c) 2014 Brendan Kenny. All rights reserved.
//

#import "RecipeDetailTableVC.h"
#import "AppDelegate.h"
#import "RecipeTableViewCell.h"
#import "ListViewController.h"
#import "WebPageViewController.h"

@interface RecipeDetailTableVC ()
@property(weak, nonatomic) NSURL *pageURL;
@end

@implementation RecipeDetailTableVC

typedef enum {
    RecipeDetailSectionTop,
    RecipeDetailSectionRecipeLink,
    RecipeDetailSectionAddToList,
    RecipeDetailSectionAddToFav
}RecipeDetailSelection;

- (void)viewDidLoad {
    [super viewDidLoad];
    //Set styles
    self.view.backgroundColor = [UIColor colorWithRed:.89 green:.87 blue:.83 alpha:1.0];  //light brown
    
    [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 1;
}

//Creates and designs the Cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *DetailCell = @"DetailCell";
    static NSString *PlainCell = @"PlainCell";
    UITableViewCell *cell;
    
    UIColor *ios7BlueColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
    
    if(indexPath.section == RecipeDetailSectionTop){
        cell = [tableView dequeueReusableCellWithIdentifier:DetailCell forIndexPath:indexPath];
        RecipeTableViewCell *customCell = (RecipeTableViewCell *)cell;
        customCell.backgroundColor = [UIColor clearColor];
        
        //Recipe Name
        customCell.nameLabel.text = self.recipe.recipeTitle;
        
        //Recipe Ingredients
        NSMutableString *ingredients = [NSMutableString string];
        [ingredients appendString:@"Ingredients: "];
        [ingredients appendString:@"\n\n"];
        
        for (int i = 0; i < self.recipe.ingredients.count; i++){
             [ingredients appendString:self.recipe.ingredients[i]];
            [ingredients appendString:@"\n"];
        }
        customCell.ingredientsLabel.text = ingredients;
        
        //RECIPE IMAGE
        NSString *images = [NSString stringWithFormat:@"%@", self.recipe.imageURL];
            
            NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: images]];
            customCell.recipeImageView.image = [UIImage imageWithData: imageData];
            customCell.recipeImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        //TIME TO MAKE
        float totalSeconds = self.recipe.timeToMake;
        NSString *cookTime = [NSString stringWithFormat:@"%f",totalSeconds];
        
        if (totalSeconds == 0 || [cookTime isEqualToString:@"null"]){
            NSString *cookTime = @"Total time to make: N/A";
            customCell.cookingTimeLabel.text = cookTime;
        }
        else{
        
        float hours = totalSeconds / 3600;
        float sd = floor(hours);
        float minutes = (totalSeconds - (sd * 3600))/60;
            
            if(hours < 1){
                float minutes = totalSeconds/60;
                NSString *cookTime = [NSString stringWithFormat:@"Total time to make: %.0f min", minutes];
                customCell.cookingTimeLabel.text = cookTime;
            }
            else{
                NSString *cookTime = [NSString stringWithFormat:@"Total time to make: %.0f hr %.0f min",hours, minutes];
                customCell.cookingTimeLabel.text = cookTime;
            }
        }
        
        
        //rating(stars)
         NSString *rate = [NSString stringWithFormat:@"Ratings: %@", self.recipe.rating];
        
        if ([rate isEqualToString:@"Ratings: 0"]){
            
            rate = @"Rating: N/A";
            customCell.ratingLabel.text = rate;
        }
        else if ([rate isEqualToString:@"Ratings: 1"]){
            customCell.ratingImageView.image = [UIImage imageNamed: @"one-star.png"];
            customCell.ratingImageView.contentMode = UIViewContentModeScaleAspectFit;
            customCell.ratingLabel.text = @"";
        }
        else if ([rate isEqualToString:@"Ratings: 2"]){
            customCell.ratingImageView.image = [UIImage imageNamed: @"two-stars.png"];
            customCell.ratingImageView.contentMode = UIViewContentModeScaleAspectFit;
            customCell.ratingLabel.text = @"";
        }
        else if ([rate isEqualToString:@"Ratings: 3"]){
            customCell.ratingImageView.image = [UIImage imageNamed: @"three-stars.png"];
            customCell.ratingImageView.contentMode = UIViewContentModeScaleAspectFit;
            customCell.ratingLabel.text = @"";
        }
        else if ([rate isEqualToString:@"Ratings: 4"]){
            customCell.ratingImageView.image = [UIImage imageNamed: @"four-stars.png"];
            customCell.ratingImageView.contentMode = UIViewContentModeScaleAspectFit;
            customCell.ratingLabel.text = @"";
        }
        else if ([rate isEqualToString:@"Ratings: 5"]){
            customCell.ratingImageView.image = [UIImage imageNamed: @"five-stars.png"];
            customCell.ratingImageView.contentMode = UIViewContentModeScaleAspectFit;
            customCell.ratingLabel.text = @"";
            
        }
        else{
            rate = @"Rating: N/A";
            customCell.ratingLabel.text = rate;
        }
        
    }
    
    if(indexPath.section == RecipeDetailSectionRecipeLink){
        cell = [tableView dequeueReusableCellWithIdentifier:PlainCell forIndexPath:indexPath];
        cell.textLabel.text = @"View Recipe Directions Article";
        cell.textLabel.textColor = ios7BlueColor;
    }

    if(indexPath.section == RecipeDetailSectionAddToList){
        cell = [tableView dequeueReusableCellWithIdentifier:PlainCell forIndexPath:indexPath];
        cell.textLabel.text = @"Add Ingredients to Shopping List";
        cell.textLabel.textColor = ios7BlueColor;
    }
    
    if(indexPath.section == RecipeDetailSectionAddToFav){
        cell = [tableView dequeueReusableCellWithIdentifier:PlainCell forIndexPath:indexPath];
        cell.textLabel.text = @"Add Recipe to Favorites";
        cell.textLabel.textColor = ios7BlueColor;
    }
    
    return cell;
}

//Different actions taken depending on which cell is selected
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == RecipeDetailSectionRecipeLink){
        NSMutableString *recipeURL = [NSMutableString string];
        [recipeURL appendString:@"http://www.yummly.com/recipe/external/"];
        [recipeURL appendString:self.recipe.recipeID];
        NSURL *url = [NSURL URLWithString:recipeURL];
        self.pageURL = url;
        
        NSString *string = self.recipe.recipeID;
        if ([string containsString:@"Martha"]) {
          [[UIApplication sharedApplication] openURL:url];
        } else {
          [self performSegueWithIdentifier:@"ShowRecipePage" sender:indexPath];
        }
        
    }
    
    if(indexPath.section == RecipeDetailSectionAddToList){

        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        [appDelegate._tasks addObjectsFromArray:self.recipe.ingredients];
    }
    
    if(indexPath.section == RecipeDetailSectionAddToFav){
      
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        [appDelegate._favorites addObject:self.recipe.recipeTitle];
        [appDelegate._Urls addObject:self.recipe.recipeID];
    }
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

//Sets size for the main top detail cell
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    float se = self.recipe.ingredients.count;
    if(indexPath.section == RecipeDetailSectionTop) return se * 20 + 300;  //row height of box
    return 44.0;
}

//sends URL to the UIWebView
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    
    if([segue.identifier isEqualToString:@"ShowRecipePage"]){
        
        WebPageViewController *Webview = segue.destinationViewController;
        Webview.url = self.pageURL;
        
    }
}

@end
