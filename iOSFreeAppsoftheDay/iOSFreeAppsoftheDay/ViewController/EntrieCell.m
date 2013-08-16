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

@property (weak, nonatomic) IBOutlet UILabel *subTitle;

@end

@implementation EntrieCell

-(void)photoDidFinishLoadingImage:(Entrie *)entrie{
    // [self.imageView setImage:entrie.image];
}

-(void)configureWithPhoto:(Entrie *)entrie{
    entrie.delegate = self;
    
    [self.name setText:[NSString stringWithFormat:@"Published : %@",[[[entrie published] componentsSeparatedByString:@"T"] objectAtIndex:0]]];
    [self.name setHighlightedTextColor:[UIColor orangeColor]];
    [self.subTitle setHighlightedTextColor:[UIColor orangeColor]];
    [self.detail setValue:[entrie detail] forKey:@"contentToHTMLString"];
    
    UIView *bgColor = [[UIView alloc] initWithFrame:self.frame];
    [bgColor setBackgroundColor:[UIColor clearColor]];
    [self setSelectedBackgroundView:bgColor];

}

-(void)link{
    // https:\/\/itunes.apple.com\/th\/app\/puzzle-retreat\/id561834333\u003C\/a>

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
