//
//  FMDocDetailController.h
//  EasyToSeeADoctor
//
//  Created by mai on 2019/1/15.
//  Copyright © 2019 Mai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDoctor.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMDocDetailController : UIViewController
@property (nonatomic, strong) FMDoctor *doctor;
@property (nonatomic, strong) NSString *h_name;
@end

NS_ASSUME_NONNULL_END
