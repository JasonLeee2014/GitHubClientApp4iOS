//
//  TokenModel.m
//  AS3
//
//  Created by zaka on 08/03/2018.
//  Copyright © 2018 zaka. All rights reserved.
//

#import "TokenModel.h"

@implementation TokenModel

-(void)saveToken{
    if (self.token) {
        NSUserDefaults* store = [NSUserDefaults standardUserDefaults];
        [store setValue:self.token forKey:@"token"];
    }
}

@end
