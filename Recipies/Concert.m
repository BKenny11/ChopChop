//
//  Concert.m
//  ConcertFinder
//
//  Created by Student on 11/13/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "Concert.h"

@implementation Concert

-(instancetype) initWithDictionary:(NSDictionary *)d{
    self = [super init];
    if(self){
        self.eventTitle = d[@"title"] ? d[@"title"] : @"";
        self.eventUrl = d[@"url"] ? d[@"url"] : @"";
        self.city = d[@"venue"][@"location"][@"city"] ? d[@"venue"][@"location"][@"city"] : @"";
        self.street = d[@"venue"][@"location"][@"street"] ? d[@"venue"][@"location"][@"street"] : @"";
        self.postalCode = d[@"venue"][@"location"][@"postalcode"] ? d[@"venue"][@"location"][@"postalcode"] : @"";
        self.country = d[@"venue"][@"location"][@"country"] ? d[@"venue"][@"location"][@"country"] : @"";
        self.latitude = [d[@"venue"][@"location"][@"geo:lat"] floatValue] ? [d[@"venue"][@"location"][@"geo:lat"] floatValue] : 0.0;
        self.longitude = [d[@"venue"][@"location"][@"geo:long"] floatValue] ? [d[@"venue"][@"location"][@"geo:long"] floatValue] : 0.0;
        self.startDate = d[@"startDate"] ? d[@"startDate"] : @"";
    }
    return self;
}
@end
