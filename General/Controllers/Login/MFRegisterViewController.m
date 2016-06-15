//
//  MFRegisterViewController.m
//  General
//
//  Created by patpat on 16/6/14.
//  Copyright © 2016年 test. All rights reserved.
//

#import "MFRegisterViewController.h"

@interface MFRegisterViewController ()
{
    RegisterType _registerType;
}

@property(nonatomic,strong) UIView* tableHeaderView;
@property(nonatomic,strong) UIView* tableFooterView;

@end

@implementation MFRegisterViewController


-(instancetype)initWithRegisterType:(RegisterType)type
{
    self = [super initWithNibName:@"MFRegisterViewController" bundle:nil];
    if (self) {
        _registerType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Register";
    [self setupNav];
    self.tableView.tableHeaderView = self.tableHeaderView;
    [self configureBottomView];
    [self configureTableView];
}

#pragma mark Setter and Getter

- (void)configureTableView
{

    
    

}


- (void)configureBottomView
{
    UIView* bottomView = [[UIView alloc]initWithFrame:CGRectZero];
    bottomView.backgroundColor = [UIColor clearColor];
    UIButton* bottomBtn = ({
       UIButton* button = [UIButton new];
        button.titleLabel.font = PPF4;
        [button setTitleColor:[UIColor colorWithHexString:@"0x3bbd79"] forState:UIControlStateNormal];
        [button setTitle:_registerType == RegisterTypeEmail? @"手机号注册": @"邮箱注册" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(changeRegisterAction) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [bottomView addSubview:bottomBtn];
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bottomView).insets(UIEdgeInsetsMake(0, 0, VMargin30, 0));
     }];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(VMargin50);
    }];
}

-(UIView *)tableHeaderView
{
    if (!_tableHeaderView) {
       _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 0.15*Main_Screen_Height)];
        _tableHeaderView.backgroundColor = [UIColor clearColor];
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, VMargin50)];
        headerLabel.backgroundColor = [UIColor clearColor];
        headerLabel.font = PPF4Border;
        headerLabel.textColor = [UIColor colorWithHexString:@"0x222222"];
        headerLabel.textAlignment = NSTextAlignmentCenter;
        headerLabel.text = @"加入Coding，体验云端开发之美！";
        [headerLabel setCenter:_tableHeaderView.center];
        [_tableHeaderView addSubview:headerLabel];
     }
    return _tableHeaderView;
}

-(UIView *)tableFooterView
{
    if (!_tableFooterView) {
        
        
        
    }
    return _tableFooterView;
}

- (void)changeRegisterAction
{
   
    
    

}



#pragma mark Private method
- (void)setupNav
{
    if (self.navigationController.childViewControllers.count <=1) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(dismissSelf)];
    }
}

- (void)dismissSelf
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
