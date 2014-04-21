//
//  HCFirendCell.m
//  FMDBDemo
//
//  Created by Reese on 13-10-30.
//  Copyright (c) 2013年 Reese@objcoder.com. All rights reserved.
//

#import "HCFirendCell.h"

@implementation HCFirendCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.headImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
        [self.contentView addSubview:self.headImage];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)prepareForReuse
{
    [super prepareForReuse];
    
}

@end
