//
//  GetAccountReposAPI.h
//  AS3
//
//  Created by zaka on 16/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "APIRequester.h"

@interface GetAccountReposAPI : APIRequester

-(id)initWithAccount:(NSString*)account AndPage:(NSInteger)page;

@end
