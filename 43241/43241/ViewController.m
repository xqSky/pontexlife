//
//  ViewController.m
//  43241
//
//  Created by 肖强 on 16/9/9.
//  Copyright © 2016年 xiaoqiang. All rights reserved.
//

#import "ViewController.h"
#import <SSKeychain.h>
static NSString *kKeychainService = @"com.xuhaoran.keychaindemo";
static NSString *kKeychainDeviceId    = @"KeychainDeviceId";
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *uuidLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.uuidLabel.layer.position=CGPointMake(10, 10);
    [CATransaction commit];
//    CALayer *layer = [CALayer layer];
    CABasicAnimation *animation = [CABasicAnimation animation];
    NSString*strAtt=[NSString stringWithFormat:@"设备号:\n%@", [self getDeviceId]];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:strAtt];
   
    [attrString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:[strAtt rangeOfString:strAtt]];
    animation.keyPath = @"transform.scale";
    animation.toValue = @0;
    
    [self.uuidLabel.layer addAnimation:animation forKey:nil];
    self.uuidLabel.attributedText=attrString ;

    self.accountTextField.returnKeyType=UIReturnKeyDone;
    self.accountTextField.delegate=self;
    UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicked:)];
    [self.view addGestureRecognizer:tap];
}
-(void)clicked:(UITapGestureRecognizer*)tap
{
    [self.accountTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}
- (IBAction)loginAction:(id)sender {
    if (!self.accountTextField.text || !self.passwordTextField.text) {
        [self showMsg:@"输入账号和密码!"];
        return;
    }
    [SSKeychain setPassword:self.passwordTextField.text forService:kKeychainService account:self.accountTextField.text];
}
- (IBAction)clearAction:(id)sender {
    // 删除对应账户密码
    if ([SSKeychain deletePasswordForService:kKeychainService account:self.accountTextField.text]) {
        [self showMsg:[NSString stringWithFormat:@"账户%@的密码已清空!", self.accountTextField.text]];
        self.passwordTextField.text = nil;
    }
    else {
        [self showMsg:@"删除失败了"];
    }
}
- (IBAction)searchAllAction:(id)sender {
    NSArray *accounts = [SSKeychain accountsForService:kKeychainService];
    NSLog(@"accounts:\n%@", accounts);
    [self showMsg:@"看下控制台输出"];
}
- (NSString *)getDeviceId {
    NSString *localDeviceId =[SSKeychain passwordForService:kKeychainService account:kKeychainDeviceId error:nil];
    if (localDeviceId==nil) {
        CFUUIDRef deviceId=CFUUIDCreate(kCFAllocatorDefault);
        assert(deviceId != NULL);
        CFStringRef deviceIdStr=CFUUIDCreateString(kCFAllocatorDefault, deviceId);
        [SSKeychain setPassword:[NSString stringWithFormat:@"%@",deviceIdStr] forService:kKeychainService account:kKeychainDeviceId];
        localDeviceId=[NSString stringWithFormat:@"%@", deviceIdStr];
        NSLog(@"DeviceId=%@",localDeviceId);
    }
    NSLog(@"DeviceId=%@",localDeviceId);
    return localDeviceId;
}
//64841E0D-8546-4254-BF32-20E6DFF09D60
- (void)showMsg:(NSString *)msg {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tip" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    [self showViewController:alert sender:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString*str=[textField.text stringByReplacingCharactersInRange:range withString:string];
    if (str.length>4&&textField==self.accountTextField) {
        return NO;
    }
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
    }
    return YES;
}


@end
