//
//  SGLoginViewController.m
//  SafeGridProject
//
//  Created by zhongda on 2019/1/15.
//  Copyright © 2019 zhongdayingcai. All rights reserved.
//

#import "SGLoginViewController.h"
#import "SGFindPasswordController.h"

#import "SGLoginLogoCell.h"
#import "SGLoginPhoneCell.h"
#import "SGLoginPwdCell.h"
#import "SGLoginBottomCell.h"
#import "SGLoginVerifyCodeCell.h"

#import "SGTimerManager.h"

#import "SGSMSService.h"
#import "SGLoginService.h"

@interface SGLoginViewController ()<UITableViewDataSource,UITableViewDelegate,SGLoginBottomCellDelegate,SGLoginVerifyCodeCellDelegate>

@property (nonatomic, nullable, strong) UITableView *tableView;

@property (nonatomic, assign) SGLoginStyle loginStyle;

@property (nonatomic, nullable, copy) NSString *phoneStr;
@property (nonatomic, nullable, copy) NSString *pwdStr;
@property (nonatomic, nullable, copy) NSString *verifyCodeStr;
@property (nonatomic, nullable, strong) SGLoginBottomCell *bottomCell;
@property (nonatomic, nullable, strong) SGLoginVerifyCodeCell *verifyCodeCell;

@property (nonatomic, nullable, strong) SGSMSService *smsService;
@property (nonatomic, nullable, strong) SGLoginService *loginService;

@end

@implementation SGLoginViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginTimerCountDownCompleted) name:kLoginCountDownCompletedNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginTimerCountDownExecutingWithTimeOut:) name:kLoginCountDownExecutingNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showNav = NO;
    [self.view addSubview:self.tableView];
    
    self.tableView.contentInset = UIEdgeInsetsMake(NavBar_Height, 0, 0, 0);
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
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
            SGLoginLogoCell *logoCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SGLoginLogoCell class]) forIndexPath:indexPath];
            return logoCell;
        }
            break;
        case 1:
        {
            SGLoginPhoneCell *phoneCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SGLoginPhoneCell class]) forIndexPath:indexPath];
            phoneCell.phoneTextField.tag = 1;
            [phoneCell.phoneTextField addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventEditingChanged];
            phoneCell.phoneTextField.text = self.phoneStr;
            return phoneCell;
        }
            break;
        case 2:
        {
            if (self.loginStyle == SGLoginStylePhonePassword) {
                
                SGLoginPwdCell *pwdCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SGLoginPwdCell class]) forIndexPath:indexPath];
                
                pwdCell.pwdTextField.tag = 2;
                [pwdCell.pwdTextField addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventEditingChanged];
                
                pwdCell.pwdTextField.text = self.pwdStr;
                [pwdCell resetStatus];
                return pwdCell;
                
            } else {
                
                SGLoginVerifyCodeCell *verifyCodeCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SGLoginVerifyCodeCell class]) forIndexPath:indexPath];
                
                verifyCodeCell.verifyCodeTxtField.tag = 3;
                [verifyCodeCell.verifyCodeTxtField addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventEditingChanged];
                verifyCodeCell.verifyCodeTxtField.text = self.verifyCodeStr;
                verifyCodeCell.phoneLength = self.phoneStr.length;
                verifyCodeCell.delegate = self;
                
                self.verifyCodeCell = verifyCodeCell;
                return verifyCodeCell;
                
            }
            
        }
            break;
        case 3:
        {
            SGLoginBottomCell *bottomCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SGLoginBottomCell class]) forIndexPath:indexPath];
            bottomCell.delegate = self;
            self.bottomCell = bottomCell;
            [self judegeLoginButtonStatus];
            return bottomCell;
        }
            break;
        default:
            break;
    }
    return nil;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 135.f;
            break;
        case 1:
        case 2:
            return 45.f;
            break;
        case 3:
            return 115.f;
            break;
        default:
            break;
    }
    return 0.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return 15.f;
    }
    return FLT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return FLT_MIN;
}

#pragma mark - SGLoginBottomCellDelegate

- (void)bottomCell:(SGLoginBottomCell *)loginBottomCell clickLogin:(UIButton *)sender {
    [self.view endEditing:YES];
    
    BOOL isLegalPhone = [[CommonTools shareInstance] isMobileNumber:self.phoneStr];
    if (!isLegalPhone) {
        [self.view showTextMsgAtCenter:@"手机号码不合法"];
        return;
    }
    
    if (self.loginStyle == SGLoginStylePhonePassword) {
        [self loginRequestWithAccount:self.phoneStr password:self.pwdStr loginStyle:1];
    } else {
        [self loginRequestWithAccount:self.phoneStr password:self.verifyCodeStr loginStyle:2];
    }
    
}

- (void)bottomCell:(SGLoginBottomCell *)loginBottomCell switchLoginStyle:(SGLoginStyle)loginStyle {
    
    if (loginStyle == SGLoginStylePhonePassword) {
        self.verifyCodeStr = nil;
    } else {
        self.pwdStr = nil;
    }
    [self judegeLoginButtonStatus];
    self.loginStyle = loginStyle;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)bottomCell:(SGLoginBottomCell *)loginBottomCell clickForgetPwd:(UIButton *)sender {
    
    [self.view endEditing:YES];
    SGFindPasswordController *findPwdVC = [[SGFindPasswordController alloc]init];
    [self.navigationController pushViewController:findPwdVC animated:YES];
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
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SGLoginLogoCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SGLoginLogoCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SGLoginPwdCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SGLoginPwdCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SGLoginPhoneCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SGLoginPhoneCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SGLoginBottomCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SGLoginBottomCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SGLoginVerifyCodeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SGLoginVerifyCodeCell class])];
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
    if (!isEmptyString(self.phoneStr) && (!isEmptyString(self.pwdStr) || !isEmptyString(self.verifyCodeStr))) {//可以点击登录按钮
        self.bottomCell.loginButtonEnabled = YES;
    } else {
        self.bottomCell.loginButtonEnabled = NO;
    }
}

- (void)executeBlockWhenLoginSuccess {
    
    [self.view showTextMsgAtCenter:@"登录成功"];
    [[SGTimerManager sharedInstance] cancelTimerWithType:SGCountDownTypeLogin];

}

#pragma mark - NSNotification

- (void)loginTimerCountDownExecutingWithTimeOut:(NSNotification *)notification {
    NSInteger timeOut = [notification.object integerValue];
    NSString *timeStr = [NSString stringWithFormat:@"(%.2ld)重新获取",(long)timeOut];
    
    [self.verifyCodeCell changeColorToNormal];
    [self.verifyCodeCell.btnGetCode setTitle:timeStr forState:UIControlStateNormal];
    self.verifyCodeCell.btnGetCode.userInteractionEnabled = NO;
}

- (void)loginTimerCountDownCompleted {
    [self.verifyCodeCell.btnGetCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    if (self.phoneStr.length == 11) {
        [self.verifyCodeCell changeColorToRed];
        self.verifyCodeCell.btnGetCode.userInteractionEnabled = YES;
    }
}

#pragma mark - networkRequest

- (void)sendSMSRequestWithPhone:(NSString *)phone sender:(UIButton *)sender {
    
    [self.view showWaitStatusHUDWithMsg:@"请稍等..." graceTime:.5];
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

- (void)loginRequestWithAccount:(NSString *)account password:(NSString *)password loginStyle:(NSInteger)style {
    
    [self.view showWaitStatusHUDWithMsg:@"请稍等..." graceTime:1.f];
    @weakify(self);
    [self.loginService loginWithAccount:account password:password logintType:style success:^{
        @strongify(self);
        [self.view hideHUDView];
        [self executeBlockWhenLoginSuccess];
        
        
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
