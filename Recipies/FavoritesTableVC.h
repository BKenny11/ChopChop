//
//  FavoritesTableVC.h
//  Recipies
//
//  Created by Brendan Kenny on 12/3/14.
//  Copyright (c) 2014 Brendan Kenny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoritesTableVC : UITableViewController

 @property (strong, nonatomic) NSMutableArray *_favs;
 @property (strong, nonatomic) NSMutableArray *_urls;

@end
