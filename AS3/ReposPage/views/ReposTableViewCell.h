//
//  ReposTableViewCell.h
//  AS3
//
//  Created by zaka on 07/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReposTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *RepoName;
@property (weak, nonatomic) IBOutlet UILabel *owener;
@property (weak, nonatomic) IBOutlet UILabel *des;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;


@end
