//
//  FMFunCell.m
//  EasyToSeeADoctor
//
//  Created by mai on 2019/1/15.
//  Copyright © 2019 Mai. All rights reserved.
//

#import "FMFunCell.h"

@implementation FMFunCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.borderWidth = 0.2;
    // Initialization code
}

@end
