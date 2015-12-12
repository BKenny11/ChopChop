//
//  RecipeTableViewCell.h
//  Recipies
//
//  Created by Brendan Kenny on 12/3/14.
//  Copyright (c) 2014 Brendan Kenny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *ingredientsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *recipeImageView;
@property (weak, nonatomic) IBOutlet UILabel *cookingTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ratingImageView;

@end
