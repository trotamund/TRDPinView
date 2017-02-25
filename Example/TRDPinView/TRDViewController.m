//
//  TRDViewController.m
//  TRDPinView
//
//  Created by trotamund on 02/24/2017.
//  Copyright (c) 2017 trotamund. All rights reserved.
//

#import "TRDViewController.h"
#import <TRDPinView/TRDPinView.h>

@interface TRDViewController ()

@property (nullable, nonatomic, strong) TRDPinView *pinView;

@end

@implementation TRDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pinView.showSecureText = YES;
    self.pinView.secureText = @"";
    self.pinView.actionBlock = ^void(NSString *value){
    
        NSLog(@"PIN: %@",value);
    };
    
    [self.view addSubview:self.pinView];
    
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.pinView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                                              [self.pinView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
                                              [self.pinView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.6],
                                              [self.pinView.heightAnchor constraintEqualToConstant:40]
                                              ]];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self.pinView becomeFirstResponder];
}

- (TRDPinView *)pinView {
    
    if (!_pinView) {
        
        TRDPinView *pinView = [[TRDPinView alloc] initWithLength:4];
        pinView.translatesAutoresizingMaskIntoConstraints = NO;
        
        pinView.settingBlock = ^void(UILabel *digitView){
            
            digitView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            digitView.layer.borderWidth = 1.0f;
            digitView.layer.cornerRadius = 0.0f;
            
            digitView.font = [UIFont systemFontOfSize:15];
            digitView.adjustsFontSizeToFitWidth = YES;
            digitView.textAlignment = NSTextAlignmentCenter;
            
            digitView.textColor = [UIColor blueColor];
        };
        
        _pinView = pinView;
    }
    
    return _pinView;
}

@end
