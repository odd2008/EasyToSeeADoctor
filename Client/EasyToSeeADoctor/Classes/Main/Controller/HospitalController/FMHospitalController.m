//
//  FMHospitalController.m
//  EasyToSeeADoctor
//
//  Created by mai on 2019/1/15.
//  Copyright © 2019 Mai. All rights reserved.
//

#import "FMHospitalController.h"
#import "FMHospital.h"
#import <UIImageView+WebCache.h>
#import "FMHospitalCell.h"
#import "HospitalDetailController.h"


@interface FMHospitalController ()

@property(nonatomic, strong)NSArray<FMHospital *> *hospitalArr;

@end

@implementation FMHospitalController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择医院";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FMHospitalCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([FMHospitalCell class])];
    [self getHospitalData];
}

- (void)getHospitalData{
    [SVProgressHUD showWithStatus:@"正在获取医院信息"];
    __weak typeof (self) weakSelf = self;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:[ServerHost stringByAppendingPathComponent:@"gethospitals"] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue]== 200) {
            weakSelf.hospitalArr = [FMHospital mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
            [SVProgressHUD dismissWithDelay:0.1];
            [weakSelf.tableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            [SVProgressHUD dismissWithDelay:1];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"获取信息失败"];
        [SVProgressHUD dismissWithDelay:1];
    }];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.hospitalArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    FMHospitalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FMHospitalCell class]) forIndexPath:indexPath];

    FMHospital *hos = [self.hospitalArr objectAtIndex:indexPath.row];
    cell.myTextLabel.text = hos.h_name;
    cell.myDetailLabel.text = hos.grade;
    
    [cell.myImageView sd_setImageWithURL:[NSURL URLWithString:[ServerHost stringByAppendingPathComponent:[NSString stringWithFormat:@"getimage/%@",hos.image_name]]] placeholderImage:[UIImage imageNamed:@"imagetemp.jpg"]];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HospitalDetailController *hosDetail = [[HospitalDetailController alloc] init];
    hosDetail.hospital = [self.hospitalArr objectAtIndex:indexPath.row];
    hosDetail.office = self.officeTitle;
    [self.navigationController pushViewController:hosDetail animated:YES];
}



@end
