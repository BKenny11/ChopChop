//
//  Recipe.m
//  Recipies
//
//  Created by Brendan Kenny on 12/2/14.
//  Copyright (c) 2014 Brendan Kenny. All rights reserved.
//

#import "Recipe.h"

@implementation Recipe

//Puts data from Yummly into a dictionary
-(instancetype) initWithDictionary:(NSDictionary *)d{
    self = [super init];
    if(self){
        self.recipeTitle = d[@"recipeName"] ? d[@"recipeName"] : @"";
        self.imageURL = d[@"imageUrlsBySize"][@"90"] ? d[@"imageUrlsBySize"][@"90"] : @"";
        self.ingredients = d[@"ingredients"] ? d[@"ingredients"] : @"";
        self.recipeID = d[@"id"] ? d[@"id"] : @"";
        self.rating = d[@"rating"] ? d[@"rating"] : @"";
        
        
        if(d[@"totalTimeInSeconds"] == (id)[NSNull null] ){
            self.timeToMake = 0.0;
        }else{
            self.timeToMake = [d[@"totalTimeInSeconds"] floatValue] ? [d[@"totalTimeInSeconds"] floatValue] : 0.0;
        }
    }
    return self;
}
@end
