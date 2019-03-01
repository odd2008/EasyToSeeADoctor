//
//  HospitalDetailController.h
//  EasyToSeeADoctor
//
//  Created by mai on 2019/1/15.
//  Copyright © 2019 Mai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMHospital.h"

NS_ASSUME_NONNULL_BEGIN

@interface HospitalDetailController : UIViewController

@property (nonatomic, strong) FMHospital *hospital;
@property (nonatomic, strong) NSString *office;
@end

NS_ASSUME_NONNULL_END
