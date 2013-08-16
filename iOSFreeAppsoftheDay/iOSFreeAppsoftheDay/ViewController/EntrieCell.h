//
//  EntrieCell.h
//  iOSFreeAppsoftheDay
//
//  Created by Tanawat Polsuwan on 8/16/56 BE.
//  Copyright (c) 2556 Tanawat Polsuwan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Entrie;

@interface EntrieCell : UITableViewCell
-(void)configureWithPhoto:(Entrie *)entrie;
@end
