//
//  SGFindPasswordController.m
//  SafeGridProject
//
//  Created by zhongda on 2019/1/21.
//  Copyright © 2019 zhongdayingcai. All rights reserved.
//

#import "SGFindPasswordController.h"

#import "SGLoginPhoneCell.h"
#import "SGLoginPwdCell.h"
#import "SGLoginVerifyCodeCell.h"
#import "SGBottomButtonCell.h"

#import "SGTimerManager.h"

#import "SGSMSService.h"
#import "SGLoginService.h"

@interface SGFindPasswordController ()<UITableViewDataSource,UITableViewDelegate,SGLoginVerifyCodeCellDelegate>

@property (nonatomic, nullable, strong) UITableView *tableView;

@property (nonatomic, nullable, copy) NSString *phoneStr;
@property (nonatomic, nullable, copy) NSString *verifyCodeStr;
@property (nonatomic, nullable, copy) NSString *pwdStr;
@property (nonatomic, nullable, strong) SGLoginVerifyCodeCell *verifyCodeCell;
@property (nonatomic, nullable, strong) SGBottomButtonCell *bottomButtonCell;

@property (nonatomic, nullable, strong) SGSMSService *smsService;
@property (nonatomic, nullable, strong) SGLoginService *loginService;

@end

@implementation SGFindPasswordController

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(findPwdTimerCountDownCompleted) name:kFindPasswordCountDownCompletedNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(findPwdTimerCountDownExecutingWithTimeOut:) name:kFindPasswordCountDownExecutingNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = CGRectMake(0, NavBar_Height, self.view.width, self.view.height - NavBar_Height);
}

#pragma mark - inherit method

- (void)setupNavView {
    [super setupNavView];
    [self createNavigationBarWithTitle:@"找回密码"];
    [self createNavigationBarLeftItemWithImageName:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            SGLoginPhoneCell *phoneCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SGLoginPhoneCell class]) forIndexPath:indexPath];
            phoneCell.phoneTextField.tag = 1;
            [phoneCell.phoneTextField addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventEditingChanged];
            phoneCell.phoneTextField.text = self.phoneStr;
            return phoneCell;
        }
            break;
        case 1:
        {
            SGLoginVerifyCodeCell *verifyCodeCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SGLoginVerifyCodeCell class]) forIndexPath:indexPath];
            
            verifyCodeCell.verifyCodeTxtField.tag = 3;
            [verifyCodeCell.verifyCodeTxtField addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventEditingChanged];
            verifyCodeCell.verifyCodeTxtField.text = self.verifyCodeStr;
            verifyCodeCell.phoneLength = self.phoneStr.length;
            verifyCodeCell.delegate = self;
            
            self.verifyCodeCell = verifyCodeCell;
            return verifyCodeCell;
        }
            break;
        case 2:
        {
            SGLoginPwdCell *pwdCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SGLoginPwdCell class]) forIndexPath:indexPath];
            
            pwdCell.pwdTextField.tag = 2;
            [pwdCell.pwdTextField addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventEditingChanged];
            
            pwdCell.pwdTextField.text = self.pwdStr;
            return pwdCell;
        }
            break;
        case 3:
        {
            SGBottomButtonCell *bottomButtonCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SGBottomButtonCell class]) forIndexPath:indexPath];
            
            @weakify(self);
            bottomButtonCell.submitClickBlock = ^{
                @strongify(self);
                
                BOOL isLegalPhone = [[CommonTools shareInstance] isMobileNumber:self.phoneStr];
                if (!isLegalPhone) {
                    [self.view showTextMsgAtCenter:@"手机号码不合法"];
                    return;
                }
                [self findPasswordWithPhone:self.phoneStr password:self.pwdStr];
            };
            self.bottomButtonCell = bottomButtonCell;
            [self judegeLoginButtonStatus];
            return bottomButtonCell;
        }
            break;
        default:
            break;
    }
    return nil;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 3) {
        return 70.f;
    }
    return 45.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 25.f;
    }
    return 15.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return 30.f;
    }
    return FLT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 2) {
        
        UIView *containerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30.f)];
        UILabel *tipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(37.5, 0, SCREEN_WIDTH - 75.f, 30.f)];

        tipsLabel.text = @"请设置6位及以上包含数字、字母的密码";
        tipsLabel.font = [UIFont systemFontOfSize:12.f];
        tipsLabel.textColor = COLOR_WITH_HEX(0x3B5998);
        [containerV addSubview:tipsLabel];
        return containerV;
    }
    return nil;
}

#pragma mark - SGLoginVerifyCodeCellDelegate

- (void)verifyCodeCell:(SGLoginVerifyCodeCell *)cell clickSendCode:(UIButton *)sender {
    [self.view endEditing:YES];
    
    BOOL isLegalPhone = [[CommonTools shareInstance] isMobileNumber:self.phoneStr];
    if (isLegalPhone) {
        [self sendSMSRequestWithPhone:self.phoneStr sender:sender];
    } else {
        [self.view showTextMsgAtCenter:@"手机号码不合法"];
    }
}

#pragma mark - private method

- (void)registerTableViewCells {
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SGLoginPwdCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SGLoginPwdCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SGLoginPhoneCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SGLoginPhoneCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SGLoginVerifyCodeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SGLoginVerifyCodeCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SGBottomButtonCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SGBottomButtonCell class])];
}

- (void)valueChanged:(UITextField *)textFiled {
    switch (textFiled.tag) {
        case 1:
            self.phoneStr = textFiled.text;
            [self.verifyCodeCell judgeSendCodeButtonStatusWithPhoneLength:self.phoneStr.length];
            break;
        case 2:
            self.pwdStr = textFiled.text;
            break;
        case 3:
            self.verifyCodeStr = textFiled.text;
            break;
        default:
            break;
    }
    
    [self judegeLoginButtonStatus];
}

- (void)judegeLoginButtonStatus {
    if (!isEmptyString(self.phoneStr) && !isEmptyString(self.pwdStr) && !isEmptyString(self.verifyCodeStr)) {//可以点击提交按钮
        self.bottomButtonCell.buttonEnabled = YES;
    } else {
        self.bottomButtonCell.buttonEnabled = NO;
    }
}

#pragma mark - NSNotification

- (void)findPwdTimerCountDownExecutingWithTimeOut:(NSNotification *)notification {
    NSInteger timeOut = [notification.object integerValue];
    NSString *timeStr = [NSString stringWithFormat:@"(%.2ld)重新获取",(long)timeOut];
    
    [self.verifyCodeCell changeColorToNormal];
    [self.verifyCodeCell.btnGetCode setTitle:timeStr forState:UIControlStateNormal];
    self.verifyCodeCell.btnGetCode.userInteractionEnabled = NO;
}

- (void)findPwdTimerCountDownCompleted {
    
    [self.verifyCodeCell.btnGetCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    if (self.phoneStr.length == 11) {
        [self.verifyCodeCell changeColorToRed];
        self.verifyCodeCell.btnGetCode.userInteractionEnabled = YES;
    }
    
}

#pragma mark - networkRequest

- (void)sendSMSRequestWithPhone:(NSString *)phone sender:(UIButton *)sender {
    
    [self.view showWaitStatusHUDWithMsg:@"请稍等..." graceTime:1];
    @weakify(self);
    [self.smsService sendSMSWithTypeName:@"学生登录验证码" phoenNum:phone sendType:1 success:^(NSString * _Nonnull message) {

        @strongify(self);
        [self.view hideHUDView];
        [self.view showTextMsgAtCenter:message];
        [[SGTimerManager sharedInstance] timerCountDownWithType:SGCountDownTypeLogin];

    } failure:^(NSError * _Nullable error) {
        @strongify(self);
        [self.view hideHUDView];
        [self.view showTextMsgAtCenter:error.localizedDescription];
    }];
}

- (void)findPasswordWithPhone:(NSString *)phone password:(NSString *)password {
    
    [self.view showWaitStatusHUDWithMsg:@"请稍等..." graceTime:1.f];
    @weakify(self);
    [self.loginService findPasswordWithPhone:phone password:password success:^(NSString * _Nonnull message) {

        @strongify(self);
        [self.view hideHUDView];
        [[SGTimerManager sharedInstance] cancelTimerWithType:SGCountDownTypeFindPassword];
        
        
    } failure:^(NSError * _Nullable error) {
        
        @strongify(self);
        [self.view hideHUDView];
        [self.view showTextMsgAtCenter:error.localizedDescription];
        
    }];
}

#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        _tableView.estimatedRowHeight = 0.f;
        _tableView.estimatedSectionFooterHeight = 0.f;
        _tableView.estimatedSectionHeaderHeight = 0.f;
        [self registerTableViewCells];
    }
    return _tableView;
}

- (SGSMSService *)smsService {
    if (!_smsService) {
        _smsService = [[SGSMSService alloc]init];
    }
    return _smsService;
}

- (SGLoginService *)loginService {
    
    if (!_loginService) {
        _loginService = [[SGLoginService alloc]init];
    }
    return _loginService;
}

@end
