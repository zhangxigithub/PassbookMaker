//
//  StoreCell.m
//  PassMaker
//
//  Created by 张 玺 on 13-11-21.
//  Copyright (c) 2013年 zhangxi. All rights reserved.
//

#import "StoreCell.h"
#import <UIImageView+AFNetworking.h>

@implementation StoreCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setStore:(Store *)store
{
    _store = store;
    
    
    [_logoImageView setImageWithURL:store.logo];
    [_nameLable setText:store.name];
    [_descriptionTextView setText:store.description];
    
    
    
    
}
@end
