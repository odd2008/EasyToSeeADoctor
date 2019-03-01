//
//  FMRecord.h
//  EasyToSeeADoctor
//
//  Created by mai on 2019/1/16.
//  Copyright © 2019 Mai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMRecord : NSObject
@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic, strong) NSString *person_name;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *doctor;
@property (nonatomic, strong) NSString *hospital;
@property (nonatomic, strong) NSString *telephone;
@property (nonatomic, strong) NSString *person_id;
@property (nonatomic, strong) NSString *person_des;

@end

NS_ASSUME_NONNULL_END
