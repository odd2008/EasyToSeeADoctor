//
//  FMRecordCell.h
//  EasyToSeeADoctor
//
//  Created by mai on 2019/1/16.
//  Copyright © 2019 Mai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMRecordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *posLabel;

@property (weak, nonatomic) IBOutlet UILabel *docLabel;



@end

NS_ASSUME_NONNULL_END
