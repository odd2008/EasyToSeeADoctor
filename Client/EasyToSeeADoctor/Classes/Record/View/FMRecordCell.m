//
//  FMRecordCell.m
//  EasyToSeeADoctor
//
//  Created by mai on 2019/1/16.
//  Copyright © 2019 Mai. All rights reserved.
//

#import "FMRecordCell.h"

@implementation FMRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
