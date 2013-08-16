//
//  EntrieCell.m
//  iOSFreeAppsoftheDay
//
//  Created by Tanawat Polsuwan on 8/16/56 BE.
//  Copyright (c) 2556 Tanawat Polsuwan. All rights reserved.
//

#import "EntrieCell.h"
#import "Entrie.h"
@interface EntrieCell() <EntrieDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UITextView *detail;


@end

@implementation EntrieCell

-(void)photoDidFinishLoadingImage:(Entrie *)entrie{
//    [self.imageView setImage:entrie.image];
}

-(void)configureWithPhoto:(Entrie *)entrie{
    entrie.delegate = self;
    [self.name setText:[entrie name]];
//    [self.detail setText:[entrie detail]];

    [self.detail setValue:[entrie detail] forKey:@"contentToHTMLString"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
