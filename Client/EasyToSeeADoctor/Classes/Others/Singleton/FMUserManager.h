//
//  FMUserManager.h
//  EasyToSeeADoctor
//
//  Created by mai on 2019/1/14.
//  Copyright © 2019 Mai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMUserManager : NSObject

+ (instancetype)getManager;

- (void)updateUser:(FMUser *)user;

- (FMUser *)getUser;

@end

NS_ASSUME_NONNULL_END
