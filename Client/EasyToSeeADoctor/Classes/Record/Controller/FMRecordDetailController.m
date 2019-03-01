//
//  FMRecordDetailController.m
//  EasyToSeeADoctor
//
//  Created by mai on 2019/1/16.
//  Copyright © 2019 Mai. All rights reserved.
//

#import "FMRecordDetailController.h"

@interface FMRecordDetailController ()
@property (weak, nonatomic) IBOutlet UITextField *personName;
@property (weak, nonatomic) IBOutlet UITextField *personTele;

@property (weak, nonatomic) IBOutlet UITextField *doctor;
@property (weak, nonatomic) IBOutlet UITextField *personPos;
@property (weak, nonatomic) IBOutlet UITextView *personDes;



@end

@implementation FMRecordDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"记录详情";
    self.personName.text = self.record.person_name;
    self.personTele.text = self.record.time;
    self.doctor.text = self.record.doctor;
    self.personPos.text = self.record.hospital;
    self.personDes.text = self.record.person_des;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
