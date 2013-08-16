//
//  Entrie.m
//  iOSFreeAppsoftheDay
//
//  Created by Tanawat Polsuwan on 8/16/56 BE.
//  Copyright (c) 2556 Tanawat Polsuwan. All rights reserved.
//

#import "Entrie.h"

@implementation Entrie
-(id)initWithDictionany:(NSDictionary *)dictionany{
    self = [super init];
    if (self) {
        self.name = [[dictionany objectForKey:@"author"] objectForKey:@"name"];
        self.detail = [dictionany objectForKey:@"content"];
    }
    return self;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%@",self.name];
}

@end
