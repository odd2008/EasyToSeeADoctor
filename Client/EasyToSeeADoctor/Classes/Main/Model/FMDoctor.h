//
//  FMDoctor.h
//  EasyToSeeADoctor
//
//  Created by mai on 2019/1/15.
//  Copyright © 2019 Mai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMDoctor : NSObject
@property (nonatomic, strong) NSNumber *did;
@property (nonatomic, strong) NSString *d_name;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *good_at;
@property (nonatomic, strong) NSNumber *in_hospital;
@property (nonatomic, strong) NSString *office;
@property (nonatomic, strong) NSString *work_time;
@property (nonatomic, strong) NSNumber *fee;
@property (nonatomic, strong) NSString *image_name;
@property (nonatomic, strong) NSString *introduction;

@end

//'did': self.did,
//'d_name': self.d_name,
//'title': self.title,
//'good_at': self.good_at,
//'in_hospital': self.in_hospital,
//'office': self.office,
//'work_time': self.work_time,
//'fee': self.fee,
//'image_name': self.image_name,
//'introduction': self.introduction

NS_ASSUME_NONNULL_END
