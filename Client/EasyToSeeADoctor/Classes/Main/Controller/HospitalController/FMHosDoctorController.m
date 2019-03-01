//
//  FMHosDoctorController.m
//  EasyToSeeADoctor
//
//  Created by mai on 2019/1/15.
//  Copyright © 2019 Mai. All rights reserved.
//

#import "FMHosDoctorController.h"
#import "FMDoctor.h"
#import "FMHosDocCell.h"
#import "FMDocDetailController.h"

@interface FMHosDoctorController ()
@property (nonatomic, strong)NSArray<FMDoctor *> *doctorsArr;

@end

@implementation FMHosDoctorController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择医生";
    [self.tableView registerNib:[UINib nibWithNibName:@"FMHosDocCell" bundle:nil] forCellReuseIdentifier:@"FMHosDocCell"];
    [self getDoctorsData];
    
}

- (void)getDoctorsData{
    [SVProgressHUD showWithStatus:@"正在获取医生数据"];
    __weak typeof (self) weakSelf = self;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"office"] = self.office;
    dic[@"in_hospital"] = self.in_hospital;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:[ServerHost stringByAppendingPathComponent:@"getdoctors"] parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue]== 200) {
            weakSelf.doctorsArr = [FMDoctor mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
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
    return 104;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.doctorsArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FMHosDocCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FMHosDocCell" forIndexPath:indexPath];
    FMDoctor *doc = [self.doctorsArr objectAtIndex:indexPath.row];
    [cell.myImageView sd_setImageWithURL:[NSURL URLWithString:[ServerHost stringByAppendingPathComponent:[NSString stringWithFormat:@"getimage/%@",doc.image_name]]] placeholderImage:[UIImage imageNamed:@"default_doc.jpeg"]];
    cell.nameLabel.text = doc.d_name;
    cell.titleLabel.text = doc.title;
    cell.feeLabel.text = [NSString stringWithFormat:@"预约费用:%@元",doc.fee];
    cell.introductionLabel.text = doc.introduction;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FMDocDetailController *docDetail = [[FMDocDetailController alloc] init];
    docDetail.doctor = [self.doctorsArr objectAtIndex:indexPath.row];
    docDetail.h_name = self.hospitalName;
    [self.navigationController pushViewController:docDetail animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
