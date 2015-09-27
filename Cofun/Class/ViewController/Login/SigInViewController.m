//
//  SigInViewController.m
//  Cofun
//
//  Created by APPLE TINPHAT on 9/24/15.
//  Copyright © 2015 TVT25. All rights reserved.
//

#import "SigInViewController.h"
#import "UITextField_Custom.h"
#import "UIButton_Custom.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "AppDelegate.h"

#import <MBProgressHUD.h>
#import "LSMacro.h"
#import "ConnectionManager.h"
#import "NSString+Extensions.h"
#import "FXBlurView.h"
#import <CoreText/CoreText.h>
#import <AVFoundation/AVFoundation.h>
#import "ViewController.h"
@interface SigInViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView        *viewSignupBot;
@property (weak, nonatomic) IBOutlet UIView        *viewForgotPW;
@property (strong, nonatomic) IBOutlet UIView        *viewLoading;
@property (strong, nonatomic) IBOutlet UIImageView   *imgLoading;

@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UILabel *lbSignupFB;

@property (weak, nonatomic) IBOutlet UIButton *btnLoginHere;

@property (weak, nonatomic) IBOutlet UIView *viewBlurMain;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UITextField *tfEmailSignup;
@property (weak, nonatomic) IBOutlet UITextField *tfUsernameSignup;
@property (weak, nonatomic) IBOutlet UITextField *tfPasswordSignup;

@property (weak, nonatomic) IBOutlet FBSDKLoginButton *btSignInFacebook;
@property (weak, nonatomic) IBOutlet UILabel *lbNewUserSignUp;
@property (weak, nonatomic) IBOutlet UIView  *viewTfSignUp;;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintsGofun;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintGoFunBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintsLoginTop;

@property (nonatomic, assign) CATransform3D initialTransform;
@property (nonatomic, assign) CATransform3D initialTransformViewSignUp;

@property (nonatomic, assign) CATransform3D initialTransformView;
@property (nonatomic, assign) CATransform3D initialTransformViewForget;


@end

@implementation SigInViewController {
    BOOL _isLoggingFB;
    AVPlayer *_player;
    AVPlayerLayer *avPlayerLayer;
    BOOL _isChangeSignup;
    UIAlertView *alertNotifytoUser;

    NSTimer *timer;
}
#pragma mark - Self

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _isChangeSignup = NO;
    
    [self setUIPlurForView];
    [self setupUI];
}

- (void)setupUI {
    _viewLoading = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    _viewLoading.center = self.view.center;
    [_viewLoading setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    _imgLoading = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    _imgLoading.contentMode = UIViewContentModeCenter;
    _imgLoading.image = [UIImage imageNamed:@"loadding.png"];
    _viewLoading.layer.cornerRadius = 10;
    [_viewLoading addSubview:_imgLoading];
    [_viewBlurMain addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    UIView *viewtfEmail = [[UIView alloc] initWithFrame:CGRectMake(0, self.tfEmail.frame.size.height - 1, self.tfEmail.frame.size.width, 1)];
    viewtfEmail.backgroundColor = [UIColor colorWithRed:74/255.f green:182/255.f blue:125/255.f alpha:1];
    UIView *viewtfPassword = [[UIView alloc] initWithFrame:CGRectMake(0, self.tfPassword.frame.size.height - 1, self.tfPassword.frame.size.width, 1)];
    viewtfPassword.backgroundColor = [UIColor colorWithRed:74/255.f green:182/255.f blue:125/255.f alpha:1];
    
    UIView *viewtfEmailSignup = [[UIView alloc] initWithFrame:CGRectMake(0, self.tfEmailSignup.frame.size.height - 1, self.tfEmailSignup.frame.size.width, 1)];
    viewtfEmailSignup.backgroundColor = [UIColor colorWithRed:74/255.f green:182/255.f blue:125/255.f alpha:1];
    UIView *viewtfPasswordSignup = [[UIView alloc] initWithFrame:CGRectMake(0, self.tfPasswordSignup.frame.size.height - 1, self.tfPasswordSignup.frame.size.width, 1)];
    viewtfPasswordSignup.backgroundColor = [UIColor colorWithRed:74/255.f green:182/255.f blue:125/255.f alpha:1];
    UIView *viewtfUsernameSignup = [[UIView alloc] initWithFrame:CGRectMake(0, self.tfUsernameSignup.frame.size.height - 1, self.tfUsernameSignup.frame.size.width, 1)];
    viewtfUsernameSignup.backgroundColor = [UIColor colorWithRed:74/255.f green:182/255.f blue:125/255.f alpha:1];

    
    [self.tfEmail insertSubview:viewtfEmail belowSubview:self.tfEmail];
    [self.tfPassword insertSubview:viewtfPassword belowSubview:self.tfPassword];
    [self.tfEmailSignup insertSubview:viewtfEmailSignup belowSubview:self.tfEmailSignup];
    [self.tfPasswordSignup insertSubview:viewtfPasswordSignup belowSubview:self.tfPasswordSignup];
    [self.tfUsernameSignup insertSubview:viewtfUsernameSignup belowSubview:self.tfUsernameSignup];
    
    NSString * string = @"New User? Sign Up";
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange redTextRange = [string rangeOfString:@"Sign Up"];

    [attString addAttribute:(NSString*)kCTUnderlineStyleAttributeName
                      value:[NSNumber numberWithInt:kCTUnderlineStyleSingle]
                      range:redTextRange];
    
    self.lbNewUserSignUp.attributedText=attString;
    
    /******* == >set color for textfield placeholder <==********/

    UIColor *color = [UIColor whiteColor];
    self.tfEmail.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"E-mail"
     attributes:@{NSForegroundColorAttributeName:color}];
    self.tfPassword.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"Password"
     attributes:@{NSForegroundColorAttributeName:color}];
    self.tfEmailSignup.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"E-mail"
     attributes:@{NSForegroundColorAttributeName:color}];
    self.tfUsernameSignup.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"Username"
     attributes:@{NSForegroundColorAttributeName:color}];
    self.tfPasswordSignup.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"Password"
     attributes:@{NSForegroundColorAttributeName:color}];
    
    /******* == >create animation for UITextField <==********/
    
    CGPoint offsetPositioning = CGPointMake(  -60, 0);
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, offsetPositioning.y, offsetPositioning.x, 0.0);
    transform = CATransform3DRotate(transform, 0.0, 0.0, 0.0, 1.0);
    _initialTransform = transform;


    CGPoint offsetPositioning2 = CGPointMake(  +60, 0);
    
    CATransform3D transform2 = CATransform3DIdentity;
    transform2 = CATransform3DTranslate(transform2, offsetPositioning2.y, offsetPositioning2.x, 0.0);
    transform2 = CATransform3DRotate(transform2, 0.0, 0.0, 0.0, 1.0);
    _initialTransformViewSignUp = transform2;
    
    /******* == >create animation for UIButton <==********/
    
    CGPoint offsetPositioning3 = CGPointMake(  -80, 0);
    
    CATransform3D transform3 = CATransform3DIdentity;
    transform3 = CATransform3DTranslate(transform3, offsetPositioning3.x, offsetPositioning3.y, 0.0);
    transform3 = CATransform3DRotate(transform3, 0.0, 0.0, 0.0, 1.0);
    _initialTransformView = transform3;
    
    
    CGPoint offsetPositioning4 = CGPointMake(  +80, 0);
    
    CATransform3D transform4 = CATransform3DIdentity;
    transform4 = CATransform3DTranslate(transform4, offsetPositioning4.x, offsetPositioning4.y, 0.0);
    transform4 = CATransform3DRotate(transform4, 0.0, 0.0, 0.0, 1.0);
    _initialTransformViewForget = transform4;
    
    
    //custom for iphone 4s
    if (IS_IPHONE_4S) {
        self.constraintsGofun.constant = 20;
        self.constraintGoFunBottom.constant = 20;
        self.constraintsLoginTop.constant = 73;
    }else {
        self.constraintsGofun.constant = 71;
        self.constraintGoFunBottom.constant = 72;
        self.constraintsLoginTop.constant = 48;

    }

}

-(void) setUIPlurForView {
    //configure blur view
//    self.viewBlurMain.dynamic = YES;
    self.viewBlurMain.tintColor = [UIColor colorWithRed:0 green:0.5 blue:0.5 alpha:1];
    self.viewBlurMain.contentMode = UIViewContentModeScaleAspectFill;
//    [self.viewBlurMain setBlurRadius:40.0f];
}

#pragma mark - Facebook
- (void)fBSDKAccessTokenDidChangeNotification:(NSNotification *)notification
{
    if (_isLoggingFB) {
        if ([FBSDKAccessToken currentAccessToken]) {
            [self signUpWithFacebook];
        }
    }
}

- (void)signUpWithFacebook
{
    FBSDKProfile* profile = [FBSDKProfile currentProfile];
    NSLog(@"facebook firstname: %@, lastname = %@",profile.firstName, profile.lastName);
    
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@"id,name,email" forKey:@"fields"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:SharedAppDelegate.window animated:YES];
    [hud setLabelText:@"Signing up"];
    [hud setDetailsLabelText:@"Please wait..."];
    
    FBSDKGraphRequest *requestURL = [[FBSDKGraphRequest alloc]
                                     initWithGraphPath:@"/me?fields=name,picture.type(large),birthday,location"
                                     parameters:nil
                                     HTTPMethod:@"GET"];
    [requestURL startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                             id result,
                                             NSError *error) {
        
        NSString *str = [[[result objectForKey:@"picture"] objectForKey:@"data"] objectForKey:@"url"];
        NSUserDefaults *userDefalts=[NSUserDefaults standardUserDefaults];
        [userDefalts setObject:str forKey:@"AVATAR_FACEBOOK_GOOGLE"];
        [hud hide:YES];
        

    }];
    
    
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if (!error) {
             NSLog(@"fetched user:%@", result);
             
             NSString *email = [result objectForKey:@"email"];
             NSString *userId = [result objectForKey:@"id"];
             
             [hud hide:YES];
             
             [[[UIAlertView alloc] initWithTitle:@"LOGIN THÀNH CÔNG!" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];

             
         }
         else {
             
             NSLog(@"%@", [error localizedDescription]);
             [hud hide:YES];
         }
     }];
    
}
#pragma mark - Action
- (IBAction)btShowPassword:(id)sender {
    if (_isChangeSignup == NO) {
        if (!self.tfPassword.secureTextEntry)
        {
            self.tfPassword.secureTextEntry = YES;
        }
        else
        {
            self.tfPassword.secureTextEntry = NO;
        }
    }else{
        if (!self.tfPasswordSignup.secureTextEntry)
        {
            self.tfPasswordSignup.secureTextEntry = YES;
        }
        else
        {
            self.tfPasswordSignup.secureTextEntry = NO;
        }
    }
}

#pragma mark - create Animaton Loadding

- (void)createAnimationLoadding:(UIView *)view  scale:(CGFloat)scale{
    CGFloat Scalenumber = fabs(scale);
    CATransform3D rotationTransform = CATransform3DIdentity;
    rotationTransform = CATransform3DScale (rotationTransform, Scalenumber,Scalenumber, 0);
    view.layer.transform = rotationTransform;
}

- (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat animation:(BOOL)animation;
{
    if (animation == YES) {
        CABasicAnimation* rotationAnimation;
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * rotations * duration ];
        rotationAnimation.duration = duration;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = repeat;
        
        [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    }else {
        [view.layer removeAnimationForKey:@"rotationAnimation"];
    }
    
}

#pragma mark - event click button

/// event tap to button Login or Signup
- (IBAction)tappedLoginOrSignup:(id)sender {
   
    _viewLoading.hidden = _viewBlurMain.userInteractionEnabled = NO;
    [self createAnimationLoadding:_viewLoading scale:0];
    [UIView animateWithDuration:0.6 animations:^{
        [self runSpinAnimationOnView:_imgLoading duration:10 rotations:1 repeat:100 animation:YES];
        [self createAnimationLoadding:_viewLoading scale:1.1];
    } completion:^(BOOL finished) {
        [self createAnimationLoadding:_viewLoading scale:1];
        timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(hideViewLoading) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }];
}

/// hide view loading in 5 seconds

- (void)hideViewLoading{
    [self createAnimationLoadding:_viewLoading scale:1];
    [UIView animateWithDuration:0.6 animations:^{
        [self createAnimationLoadding:_viewLoading scale:0];
    } completion:^(BOOL finished) {
        [self runSpinAnimationOnView:_imgLoading duration:0 rotations:0 repeat:0 animation:NO];
        [timer invalidate];
        timer = nil;
        _viewLoading.hidden = _viewBlurMain.userInteractionEnabled = YES;
        if (_isChangeSignup == NO) {
            //  user username or password correct
            NSString *EmailUser = [[NSUserDefaults standardUserDefaults]
                                   stringForKey:@"preferenceEmailUser"];
            NSString *PassWordUser = [[NSUserDefaults standardUserDefaults]
                                      stringForKey:@"preferencePassWordUser"];

            
            if ([_tfEmail.text isEqualToString:EmailUser] && [_tfPassword.text isEqualToString:PassWordUser]) {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"StoryboardofHau" bundle:nil];

                ViewController *view = [sb instantiateViewControllerWithIdentifier:@"viewdemo"];
                UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:view];

                [self presentViewController:navi animated:YES completion:nil];
            }else {
                
                // notify to user username or password incorrect
                UIAlertView * alertNotifytoUser2 = [[UIAlertView alloc] initWithTitle:@"Notify of Gofun" message:@"Username or password your can incorrect." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK,Thank!", nil];
                
                [alertNotifytoUser2 show];
            }

        }else {
            /// tapped sign up
            if ([_tfEmailSignup.text length] == 0 || [_tfUsernameSignup.text length] < 4 || [_tfPasswordSignup.text length] < 6){
                if (!alertNotifytoUser) {
                    alertNotifytoUser = [[UIAlertView alloc] initWithTitle:@"Notify of Gofun" message:@"Please enter your full information " delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK,Thank!", nil];
                }
                
                [alertNotifytoUser show];
            }else{
                [[NSUserDefaults standardUserDefaults] setObject:_tfUsernameSignup.text forKey:@"preferenceNameUser"];
                [[NSUserDefaults standardUserDefaults] synchronize];

                [[NSUserDefaults standardUserDefaults] setObject:_tfEmailSignup.text forKey:@"preferenceEmailUser"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [[NSUserDefaults standardUserDefaults] setObject:_tfPasswordSignup.text forKey:@"preferencePassWordUser"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                _tfEmail.text = _tfEmailSignup.text;
                _tfPassword.text = @"";
                [self tappedLoginHere:nil];
                _tfEmailSignup.text = _tfUsernameSignup.text = _tfPasswordSignup.text = @"";
                
            }
            
        }
    }];
}

- (IBAction)btFacebookTapped:(id)sender {
    
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, do work such as go to next view controller.
        [self signUpWithFacebook];
    }
    else{
        _isLoggingFB = YES;
       // appDelegate.isFacebookLogin = YES;
        [self.btSignInFacebook sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (IBAction)btSignUp:(id)sender {
    _tfEmailSignup.text = _tfUsernameSignup.text = _tfPasswordSignup.text = @"";
    _isChangeSignup = YES;
    [_btnLogin setTitle:@"SIGN UP" forState:UIControlStateNormal];
    [UIView animateWithDuration:0.6 animations:^{
        self.tfEmail.layer.transform = self.initialTransform;
        self.tfEmail.layer.opacity = 0;
        _lbSignupFB.text = @"SIGN UP WITH FACEBOOK";
    }];
    
    [UIView animateWithDuration:0.6 animations:^{
        
        self.tfPassword.layer.transform = self.initialTransform;
        self.tfPassword.layer.opacity = 0;
        _viewForgotPW.layer.transform = self.initialTransformViewForget;
        _viewForgotPW.layer.opacity = 0;
        _viewSignupBot.layer.transform = self.initialTransformView;
        _viewSignupBot.layer.opacity = 0;

    } completion:^(BOOL finished) {
        _viewForgotPW.hidden = _viewSignupBot.hidden = YES;
        _btnLoginHere.hidden = NO;
    }];

    
    
    [self.viewTfSignUp setHidden:NO];
    self.viewTfSignUp.layer.transform = self.initialTransformViewSignUp;
    self.viewTfSignUp.layer.opacity = 0;
    [UIView animateWithDuration:0.8 animations:^{
        self.viewTfSignUp.layer.transform = CATransform3DIdentity;
        self.viewTfSignUp.layer.opacity = 1;
    }];
}

- (IBAction)btForgotPassword:(id)sender {
    [[[UIAlertView alloc] initWithTitle:@"Lấy lại mật khẩu?" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
}

- (IBAction)tappedLoginHere:(id)sender{
    
    [self runSpinAnimationOnView:_lbSignupFB duration:0 rotations:0 repeat:0 animation:NO];

    _isChangeSignup = NO;
     self.viewTfSignUp.hidden = NO;
    _btnLoginHere.hidden = YES;
    _viewForgotPW.hidden = _viewSignupBot.hidden = NO;

    [_btnLogin setTitle:@"LOG IN" forState:UIControlStateNormal];

    [UIView animateWithDuration:0.6 animations:^{
        self.viewTfSignUp.layer.transform = self.initialTransform;
        self.viewTfSignUp.layer.opacity = 0;
        _lbSignupFB.text =  @"LOG IN WITH FACEBOOK";
    }];
    
    self.tfPassword.layer.transform = self.tfEmail.layer.transform = self.initialTransformViewSignUp;
    self.viewSignupBot.layer.transform = _initialTransformView;
    self.viewForgotPW.layer.transform = _initialTransformViewForget;

    self.tfPassword.layer.opacity = self.tfEmail.layer.opacity = 0;
    self.viewForgotPW.layer.opacity = self.viewSignupBot.layer.opacity = 0;
    [UIView animateWithDuration:0.8 animations:^{
        self.tfPassword.layer.transform = self.tfEmail.layer.transform = CATransform3DIdentity;
        self.tfPassword.layer.opacity = self.tfEmail.layer.opacity = 1;
        self.viewForgotPW.layer.transform = self.viewSignupBot.layer.transform = CATransform3DIdentity;
        self.viewForgotPW.layer.opacity = self.viewSignupBot.layer.opacity = 1;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];
}

- (void) playVideoBackground{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!_player) {
            self.view.clipsToBounds = YES;
            _player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"videoLogin" ofType:@"mp4"]]];
            avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
            CGRect rect = [UIScreen mainScreen].bounds;
            [avPlayerLayer setFrame:rect];
            avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
            [self.view.layer addSublayer:avPlayerLayer];
            _player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(playerItemDidReachEnd:)
                                                         name:AVPlayerItemDidPlayToEndTimeNotification
                                                       object:[_player currentItem]];
            
            
            [self.view bringSubviewToFront:_viewBlurMain];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:@"applicationWillResignActive" object:Nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:) name:@"applicationDidBecomeActive" object:Nil];
        }
        [_player seekToTime:kCMTimeZero];
        [_player play];
    });
    
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self playVideoBackground];
    self.tfPassword.text = @"";
    self.navigationController.navigationBarHidden = YES;
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_player pause];
    [_player replaceCurrentItemWithPlayerItem:nil];
    [avPlayerLayer removeFromSuperlayer];
    _player = nil;
}

#pragma mark - NSNotification
- (void)applicationWillResignActive:(NSNotification *)ntf
{
//    if ([self.navigationController.viewControllers.lastObject isKindOfClass:[self class]]) {
        [_player pause];
        [_player replaceCurrentItemWithPlayerItem:nil];
        [avPlayerLayer removeFromSuperlayer];
        _player = nil;
   // }
}

- (void)applicationDidBecomeActive:(NSNotification *)ntf
{
//    if ([self.navigationController.viewControllers.lastObject isKindOfClass:[self class]]) {
        [self playVideoBackground];
    //}
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_tfEmail resignFirstResponder];
    [_tfPassword resignFirstResponder];
    return YES;
}

- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
