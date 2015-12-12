//
//  Concert.h
//  ConcertFinder
//
//  Created by Student on 11/13/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Concert : NSObject
@property (nonatomic, copy) NSString *eventTitle;
@property (nonatomic, copy) NSString *eventUrl;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *street;
@property (nonatomic, copy) NSString *postalCode;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, assign) float latitude;
@property (nonatomic, assign) float longitude;
@property (nonatomic, copy) NSString *startDate;

-(instancetype)initWithDictionary: (NSDictionary*)dictionary;

@end
