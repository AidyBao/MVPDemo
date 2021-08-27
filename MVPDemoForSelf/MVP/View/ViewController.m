//
//  ViewController.m
//  MVPDemoForSelf
//
//  Created by Mr Xie on 2018/11/8.
//  Copyright © 2018 Mr Xie. All rights reserved.
//

#import "ViewController.h"
#import "UserViewProtocol.h"
#import "Presenter.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UserViewProtocol>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic,strong) NSArray<UserModel *> *friendlyUIData;

@property (nonatomic,strong) Presenter *presenter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.indicatorView];
    
    [self.presenter fetchData];
    
//    [self test];
}


//-(void)test {
//    NSString *str = [NSString stringWithFormat:@"a55a45955200000490 6988696988686688666588656388615f885e5e885c5a885756885553885251884f4d884b48884644884240883c3a883937883531882e2d882b2888262388211f881b1888151388110e880a078806038800fd77faf877f6f377f0ed77ebea77e7e377e0de77dcd977d5d377d2d077cdca77c8c677c5c277bfbd77bcba77b8b377b1ae77acaa77a9a877a6a477a3a277a00b"];
//
//    NSData *buf = [str dataUsingEncoding:NSUTF8StringEncoding];
//
//    NSData *tmpData;
////    if (internal_index == 10) {
//        tmpData = [buf subdataWithRange:NSMakeRange(9, 0x60)];
////    } else {
//        tmpData = [buf subdataWithRange:NSMakeRange(9, buf.length)];
////    }
//
//    tmpData = [buf subdataWithRange:NSMakeRange(18, 288)];
//
//
//    NSMutableData *tmpMutData = [[NSMutableData alloc]init];
//    val1 = resultBytes[k];
//    val2 = resultBytes[k+1];
//    val3 = resultBytes[k+2];
//
//    value1.DataUint = (val2 & 0xf0) * 16 + val1;
//    value2.DataUint = (val2 & 0x0f) * 256 + val3;
//
//    value1.DataInt = value1.DataInt - 0x800;
//    value1.DataUint = (value1.DataUint + 0x8000) & 0xFFFF;
//    value2.DataInt = value2.DataInt - 0x800;
//    value2.DataUint = (value2.DataUint + 0x8000) & 0xFFFF;
//
//    unsigned int intValue = value1.DataUint & 0xff;
//    [tmpMutData appendBytes:&intValue length:1];
//    intValue = (value1.DataUint>>8) & 0xff;
//    [tmpMutData appendBytes:&intValue length:1];
//    intValue = value2.DataUint & 0xff;
//    [tmpMutData appendBytes:&intValue length:1];
//    intValue = (value2.DataUint>>8) & 0xff;
//    [tmpMutData appendBytes:&intValue length:1];
//
//
//    NSLog(@"%@", tmpData);
//}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    UserModel *model = self.friendlyUIData[indexPath.row];
    cell.textLabel.text = model.name;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friendlyUIData.count;
}

#pragma mark - UserViewProtocol
- (void)userViewDataSource:(NSArray<UserModel *> *)data {
    self.friendlyUIData = data;
    [self.tableView reloadData];
}

- (void)showIndicator {
    [self.indicatorView startAnimating];
    self.indicatorView.hidden = NO;
}

- (void)hideIndicator {
    [self.indicatorView stopAnimating];
}

- (void)showEmptyView {
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Alert" message:@"show empty view" preferredStyle:UIAlertControllerStyleAlert];
    [alertView addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertView animated:YES completion:^{
        
    }];
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (UIActivityIndicatorView *)indicatorView {
    if (_indicatorView == nil) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.center = self.view.center;
        _indicatorView.hidesWhenStopped = YES;
    }
    return _indicatorView;
}

- (Presenter *)presenter {
    if (_presenter == nil) {
        _presenter = [[Presenter alloc] init];
        [_presenter attachView:self];
    }
    return _presenter;
}

@end
