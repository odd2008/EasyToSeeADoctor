//
//  HospitalDetailController.m
//  EasyToSeeADoctor
//
//  Created by mai on 2019/1/15.
//  Copyright © 2019 Mai. All rights reserved.
//

#import "HospitalDetailController.h"

#import "FMHosDoctorController.h"

@interface HospitalDetailController ()
@property (weak, nonatomic) IBOutlet UIImageView *hosImageView;
@property (weak, nonatomic) IBOutlet UILabel *hosName;
@property (weak, nonatomic) IBOutlet UILabel *hosGrade;
@property (weak, nonatomic) IBOutlet UITextView *introduceTextView;
@property (weak, nonatomic) IBOutlet UITextView *advantageTextView;
@property (weak, nonatomic) IBOutlet UITextView *awardTextView;


@end

@implementation HospitalDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.hospital.h_name;
    [self.hosImageView sd_setImageWithURL:[NSURL URLWithString:[ServerHost stringByAppendingPathComponent:[NSString stringWithFormat:@"getimage/%@",self.hospital.image_name]]] placeholderImage:[UIImage imageNamed:@"imagetemp.jpg"]];
    self.hosName.text = self.hospital.h_name;
    self.hosGrade.text = self.hospital.grade;
    self.introduceTextView.text = self.hospital.production;
    self.advantageTextView.text = self.hospital.advantage;
    self.awardTextView.text = self.hospital.honor;
    UIBarButtonItem *rigBut = [[UIBarButtonItem alloc] initWithTitle:@"确认选择" style:UIBarButtonItemStylePlain target:self action:@selector(chose)];
    self.navigationItem.rightBarButtonItem = rigBut;
}

- (void)chose{
    FMHosDoctorController *docController = [[FMHosDoctorController alloc] init];
    docController.in_hospital = self.hospital.hid;
    docController.office = self.office;
    docController.hospitalName = self.hospital.h_name;
    [self.navigationController pushViewController:docController animated:YES];
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
