//
//  TRDPinView.m
//  Pods
//
//  Created by Luis Gutierrez on 24-02-17.
//
//

#import "TRDPinView.h"

@interface TRDPinView ()

@property (nonatomic, strong) NSMutableArray<NSString *> *pinValue;
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) NSArray<UILabel *> *digitViews;
@property (nonatomic) BOOL hastText;

@end

@implementation TRDPinView

- (instancetype)initWithLength:(NSInteger)length {
    
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        
        _length = length;
        [self setup];
    }
    
    return self;
}

- (void)setup {
    
    NSMutableArray *views = [NSMutableArray arrayWithCapacity:self.length];
    self.pinValue = [NSMutableArray arrayWithCapacity:self.length];
    
    self.settingBlock = [self defultSettingBlock];
    
    for (NSInteger index = 0; index < self.length; index++) {
        
        UILabel *label = [UILabel new];
        
        self.settingBlock(label);
        
        [views addObject:label];
        
        [self.stackView addArrangedSubview:label];
    }
    
    self.digitViews = views;
    
    [self addSubview:self.stackView];
    
    NSArray *constraints = @[
                             [self.stackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
                             [self.stackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
                             [self.stackView.topAnchor constraintEqualToAnchor:self.topAnchor],
                             [self.stackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]
                             ];
    
    [NSLayoutConstraint activateConstraints:constraints];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(becomeFirstResponder)];
    
    [self addGestureRecognizer:tap];
}

- (TRDDigitViewSettingBlock)defultSettingBlock {
    
    return ^void(UILabel *digitView) {
        
        digitView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        digitView.layer.borderWidth = 1.0f;
        digitView.layer.cornerRadius = 4.0f;
        
        digitView.font = [UIFont systemFontOfSize:15];
        digitView.adjustsFontSizeToFitWidth = YES;
        digitView.textAlignment = NSTextAlignmentCenter;
    };
}

- (void)setSettingBlock:(TRDDigitViewSettingBlock)settingBlock {
    
    _settingBlock = settingBlock;
    
    if (settingBlock) {
        
        for (UILabel *digitView in self.digitViews) {
            
            settingBlock(digitView);
        }
    }
}

- (NSString *)rawValue {
    
    return [self.pinValue componentsJoinedByString:@""];
}

- (BOOL)canBecomeFirstResponder {
    
    return YES;
}

- (void)setPinValue:(NSMutableArray<NSString *> *)pinValue {
    
    [self.digitViews enumerateObjectsUsingBlock:^(UILabel * _Nonnull digitView, NSUInteger index, BOOL * _Nonnull stop) {
        
        if (index < pinValue.count) {
            
            digitView.text = [self isSecureTextEntry] ? @"*" : pinValue[index];
        }
        else {
            
            digitView.text = @" ";
            
        }
    }];
    
    _pinValue = pinValue;
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
    if (pinValue.count == self.length) {
        
        [self sendActionsForControlEvents:UIControlEventPrimaryActionTriggered];
    }
    
}

- (UIStackView *)stackView {
    
    if (!_stackView) {
        
        _stackView = [UIStackView new];
        _stackView.translatesAutoresizingMaskIntoConstraints = NO;
        _stackView.spacing = 8;
        _stackView.distribution = UIStackViewDistributionFillEqually;
    }
    
    return _stackView;
}

- (void)setLength:(NSInteger)length {
    
    _length = length;
}

#pragma mark - UITextInputTraits
- (UIKeyboardType)keyboardType {
    
    return UIKeyboardTypeNumberPad;
}

- (BOOL)isSecureTextEntry {
    
    return _secureText;
}

#pragma mark - UIKeyInput
- (BOOL)hasText {
    
    return [self.pinValue count] > 0;
}

- (void)insertText:(NSString *)text {
    
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    
    if (self.pinValue.count < self.length && [text length] == 1 && [text rangeOfCharacterFromSet:notDigits].location == NSNotFound) {
        
        NSMutableArray *array = [NSMutableArray arrayWithArray:self.pinValue];
        
        [array addObject:text];
        
        self.pinValue = array;
    }
}

- (void)deleteBackward {
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.pinValue];
    
    [array removeLastObject];
    
    self.pinValue = array;
    
}

@end
