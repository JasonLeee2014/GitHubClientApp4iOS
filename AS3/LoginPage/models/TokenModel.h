//
//  TokenModel.h
//  AS3
//
//  Created by zaka on 08/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "JSONModel.h"

@interface TokenModel : JSONModel

@property (nonatomic) NSString <Optional> *token;

-(void)saveToken;

@end
