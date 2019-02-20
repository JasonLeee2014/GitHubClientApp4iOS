//
//  SearchReposModel.m
//  AS3
//
//  Created by zaka on 09/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "SearchReposModel.h"

@implementation SearchReposModel

@end

@implementation RepoModel

+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"description":@"des"}];
}

@end
