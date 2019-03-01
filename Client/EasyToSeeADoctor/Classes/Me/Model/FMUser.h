//
//  FMUser.h
//  EasyToSeeADoctor
//
//  Created by mai on 2019/1/14.
//  Copyright © 2019 Mai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMUser : NSObject
@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSNumber *gender;
@property (nonatomic, strong) NSNumber *age;
@property (nonatomic, strong) NSString *telephone;
@property (nonatomic, strong) NSNumber *money;

@end

NS_ASSUME_NONNULL_END
