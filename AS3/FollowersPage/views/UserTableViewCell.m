//
//  UserTableViewCell.m
//  AS3
//
//  Created by zaka on 09/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "UserTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import <Chameleon.h>

#import <Masonry.h>

@implementation UserTableViewCell{
    
    __weak IBOutlet UIImageView *avatarImageView;
    __weak IBOutlet UILabel *userNameLbl;
    
//    UIImageView* backgroundView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.separatorInset=UIEdgeInsetsZero;
    self.clipsToBounds=YES;
    
    [avatarImageView.layer setCornerRadius:25];
    avatarImageView.layer.masksToBounds = YES;
    
//    backgroundView = [[UIImageView alloc] init];
//    [self.contentView addSubview:backgroundView];
//    [self.contentView sendSubviewToBack:backgroundView];
//    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.and.bottom.equalTo(self.contentView);
//    }];
//    
//    [backgroundView setContentMode:UIViewContentModeScaleAspectFill];
//    
//    UIVisualEffectView* blur =[[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
//    [backgroundView addSubview:blur];
//    [blur mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.and.bottom.equalTo(backgroundView);
//    }];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

-(void)setUsername:(NSString*)username{
    userNameLbl.text=username;
}

-(void)setAvatar:(NSString*)avatarUrl{
    //[avatarImageView setImageWithURL:[NSURL URLWithString:avatarUrl]];
    [avatarImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:avatarUrl]] placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        [avatarImageView setImage:image];
        UIColor * color =[UIColor colorWithAverageColorFromImage:image];
        [self.contentView setBackgroundColor:color];
        [userNameLbl setTextColor:[UIColor colorWithContrastingBlackOrWhiteColorOn:color isFlat:YES]];
    } failure:nil];
    //[backgroundView setImageWithURL:[NSURL URLWithString:avatarUrl]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
