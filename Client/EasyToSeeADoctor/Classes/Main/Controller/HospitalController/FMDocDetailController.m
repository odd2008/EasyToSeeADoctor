//
//  FMDocDetailController.m
//  EasyToSeeADoctor
//
//  Created by mai on 2019/1/15.
//  Copyright © 2019 Mai. All rights reserved.
//

#import "FMDocDetailController.h"
#import "FMDocConfirmController.h"

@interface FMDocDetailController ()
@property (weak, nonatomic) IBOutlet UIImageView *docImageView;
@property (weak, nonatomic) IBOutlet UILabel *docName;
@property (weak, nonatomic) IBOutlet UILabel *docTitle;
@property (weak, nonatomic) IBOutlet UILabel *docHos;
@property (weak, nonatomic) IBOutlet UILabel *docFee;
@property (weak, nonatomic) IBOutlet UITextView *docIntro;
@property (weak, nonatomic) IBOutlet UITextView *docGoodAt;
@property (weak, nonatomic) IBOutlet UITextView *docTimetable;

@property (nonatomic, strong) NSMutableArray *timeArr;
@property (nonatomic, strong) NSMutableArray *indexArr;

@end

@implementation FMDocDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.doctor.d_name;
    self.timeArr = [[NSMutableArray alloc] init];
    self.indexArr = [[NSMutableArray alloc] init];
    UIBarButtonItem *rigBut = [[UIBarButtonItem alloc] initWithTitle:@"预约医生" style:UIBarButtonItemStylePlain target:self action:@selector(chose)];
    self.navigationItem.rightBarButtonItem = rigBut;
    [self.docImageView sd_setImageWithURL:[NSURL URLWithString:[ServerHost stringByAppendingPathComponent:[NSString stringWithFormat:@"getimage/%@",self.doctor.image_name]]] placeholderImage:[UIImage imageNamed:@"default_doc.jpeg"]];
    self.docName.text = self.doctor.d_name;
    self.docTitle.text = self.doctor.title;
    self.docHos.text = self.h_name;
    self.docFee.text = [NSString stringWithFormat:@"预约费用:%@元",self.doctor.fee];
    self.docIntro.text = self.doctor.introduction;
    self.docGoodAt.text = self.doctor.good_at;
    [self setTimeTableText:self.doctor.work_time];
}

- (void)setTimeTableText:(NSString *)str{
    NSDate *currentDate =[NSDate date];
    NSTimeInterval oneDay = 24 * 60 * 60;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSString *finalString;
    for (int i = 0; i < 14; i++) {
        NSString *bStr = [str substringWithRange:NSMakeRange(i*2,2)];
        long num = [bStr integerValue];
        NSDate *appointDate = [currentDate initWithTimeIntervalSinceNow:oneDay * i/2];
        NSString *two;
        if (i%2 == 0) {
            two = @"上午";
        }else{
            two = @"下午";
        }
        if (finalString == nil) {
            if (num > 0) {
                [self.indexArr addObject:[NSNumber numberWithInteger:i*2]];
                NSString *timeTemp = [NSString stringWithFormat:@"%@ %@",[formatter stringFromDate:appointDate],two];
                [self.timeArr addObject:timeTemp];
                finalString = [NSString stringWithFormat:@"%@ 剩余预约数量:%ld",timeTemp,num];
            }
        }else{
            if (num > 0) {
                [self.indexArr addObject:[NSNumber numberWithInteger:i*2]];
                NSString *timeTemp = [NSString stringWithFormat:@"%@ %@",[formatter stringFromDate:appointDate],two];
                [self.timeArr addObject:timeTemp];
                finalString = [finalString stringByAppendingFormat:@"\n%@ 剩余预约数量:%ld",timeTemp,num];
            }
        }
    }
    self.docTimetable.text = finalString;
}

- (void)chose{
    FMDocConfirmController *fmDocConfirm = [[FMDocConfirmController alloc] init];
    fmDocConfirm.timeArr = self.timeArr;
    fmDocConfirm.h_name = self.h_name;
    fmDocConfirm.d_name = self.doctor.d_name;
    fmDocConfirm.did = self.doctor.did;
    fmDocConfirm.indexArr = self.indexArr;
    fmDocConfirm.work_time = self.doctor.work_time;
    fmDocConfirm.money = self.doctor.fee;
    [self.navigationController pushViewController:fmDocConfirm animated:YES];
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
