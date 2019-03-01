//
//  FMOfficeDetailController.m
//  EasyToSeeADoctor
//
//  Created by mai on 2019/1/15.
//  Copyright © 2019 Mai. All rights reserved.
//

#import "FMOfficeDetailController.h"
#import "FMDetailOfficeCell.h"
#import "FMHospitalController.h"

@interface FMOfficeDetailController ()

@end

@implementation FMOfficeDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择科室";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FMDetailOfficeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([FMDetailOfficeCell class])];

}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.officeDetailArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FMDetailOfficeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FMDetailOfficeCell class]) forIndexPath:indexPath];
    cell.textLabel.text = [self.officeDetailArr objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FMHospitalController *hos = [[FMHospitalController alloc] init];
    hos.officeTitle = [self.officeDetailArr objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:hos animated:YES];
}


@end
