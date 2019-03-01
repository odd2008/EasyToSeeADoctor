//
//  FMUserManager.m
//  EasyToSeeADoctor
//
//  Created by mai on 2019/1/14.
//  Copyright © 2019 Mai. All rights reserved.
//

#import "FMUserManager.h"

@interface FMUserManager()
@property(nonatomic, strong)FMUser *user;

@end

@implementation FMUserManager

+ (instancetype)getManager{
    static FMUserManager *manager = nil;
    if (manager == nil) {
        manager = [[FMUserManager alloc] initPrivate];
    }
    return manager;
}

- (instancetype)initPrivate{
    self = [super init];
    if (self) {
        _user = [[FMUser alloc] init];
    }
    return self;
}

- (void)updateUser:(FMUser *)user{
    self.user.uid = user.uid;
    self.user.username = user.username;
    self.user.gender = user.gender;
    self.user.age = user.age;
    self.user.telephone = user.telephone;
    self.user.money = user.money;
}

- (FMUser *)getUser{
    return self.user;
}


@end
