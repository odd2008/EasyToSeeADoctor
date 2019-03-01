//
//  FMtableController.m
//  EasyToSeeADoctor
//
//  Created by mai on 2019/1/14.
//  Copyright © 2019 Mai. All rights reserved.
//

#import "FMtableController.h"
#import "FMRecordCell.h"
#import "FMRecord.h"
#import "FMRecordDetailController.h"

@interface FMtableController ()

@property (nonatomic ,strong)NSArray<FMRecord *> *recordArr;

@end

@implementation FMtableController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"挂号记录";
    [self.tableView registerNib:[UINib nibWithNibName:@"FMRecordCell" bundle:nil] forCellReuseIdentifier:@"FMRecordCell"];
    [self getRecordData];
}

- (void)getRecordData{
    [SVProgressHUD showWithStatus:@"正在获取挂号信息"];
    __weak typeof (self) weakSelf = self;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *requestStr = [ServerHost stringByAppendingFormat:@"/getrecord/%@", [[FMUserManager getManager] getUser].uid];
    
    [manager GET:requestStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue]== 200) {
            weakSelf.recordArr = [FMRecord mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.recordArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FMRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FMRecordCell" forIndexPath:indexPath];
    FMRecord *record = [self.recordArr objectAtIndex:indexPath.row];
    cell.timeLabel.text = record.time;
    cell.posLabel.text = record.hospital;
    cell.docLabel.text = [NSString stringWithFormat:@"预约医生:%@",record.doctor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 92;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FMRecordDetailController *vc = [[FMRecordDetailController alloc] init];
    vc.record = [self.recordArr objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getRecordData];
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
