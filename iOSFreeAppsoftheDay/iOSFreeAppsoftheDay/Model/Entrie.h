//
//  Entrie.h
//  iOSFreeAppsoftheDay
//
//  Created by Tanawat Polsuwan on 8/16/56 BE.
//  Copyright (c) 2556 Tanawat Polsuwan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Entrie;
@protocol EntrieDelegate
-(void)photoDidFinishLoadingImage:(Entrie *)entrie;
@end

@interface Entrie : NSObject
@property (nonatomic, weak) id <EntrieDelegate> delegate;
-(id)initWithDictionany:(NSDictionary *)dictionany;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *detail;
@property (nonatomic,strong)UIImage *image;
@end
