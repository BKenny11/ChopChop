//
//  Recipe.h
//  Recipies
//
//  Created by Brendan Kenny on 12/2/14.
//  Copyright (c) 2014 Brendan Kenny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recipe : NSObject

@property (nonatomic, copy) NSString *recipeTitle;
@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, copy) NSMutableArray *ingredients;
@property (nonatomic, assign) float timeToMake;
@property (nonatomic, copy) NSString *recipeID;
@property (nonatomic, copy) NSString *rating;

-(instancetype)initWithDictionary: (NSDictionary*)dictionary;

@end
