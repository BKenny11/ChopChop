//
//  RecipeDetailTableVC.h
//  Recipies
//
//  Created by Brendan Kenny on 12/2/14.
//  Copyright (c) 2014 Brendan Kenny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

@interface RecipeDetailTableVC : UITableViewController
@property (nonatomic, strong) Recipe *recipe;
@end
