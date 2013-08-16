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
        self.alternate = [dictionany objectForKey:@"alternate"];
        self.published = [dictionany objectForKey:@"published"];
        // self.url = [dictionany objectForKey:@""];
    }
    return self;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%@",self.name];
}

-(UIImage *)image{
    if (_image == nil) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.url]];
            _image = [UIImage imageWithData:data];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"%@",_url);
                [self.delegate photoDidFinishLoadingImage:self];
            });
            
            
        });
        
        
        
    }
    return _image;
    
}


@end
