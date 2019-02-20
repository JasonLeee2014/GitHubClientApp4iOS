//
//  ReposTableViewCell.m
//  AS3
//
//  Created by zaka on 07/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "ReposTableViewCell.h"

@implementation ReposTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.separatorInset=UIEdgeInsetsZero;
    _des.lineBreakMode = NSLineBreakByWordWrapping;
    _des.numberOfLines = 0;
    _RepoName.numberOfLines = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
