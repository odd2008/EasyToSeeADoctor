//
//  FMHosDoctorController.h
//  EasyToSeeADoctor
//
//  Created by mai on 2019/1/15.
//  Copyright © 2019 Mai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMHosDoctorController : UITableViewController

@property (nonatomic, strong) NSString *office;
@property (nonatomic, strong) NSNumber *in_hospital;
@property (nonatomic, strong) NSString *hospitalName;

@end

NS_ASSUME_NONNULL_END
