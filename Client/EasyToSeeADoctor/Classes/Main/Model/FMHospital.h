//
//  FMHospital.h
//  EasyToSeeADoctor
//
//  Created by mai on 2019/1/15.
//  Copyright © 2019 Mai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMHospital : NSObject
@property (nonatomic, strong) NSNumber *hid;
@property (nonatomic, strong) NSString *h_name;
@property (nonatomic, strong) NSString *production;
@property (nonatomic, strong) NSString *advantage;
@property (nonatomic, strong) NSString *honor;
@property (nonatomic, strong) NSString *image_name;
@property (nonatomic, strong) NSString *grade;

@end

NS_ASSUME_NONNULL_END
