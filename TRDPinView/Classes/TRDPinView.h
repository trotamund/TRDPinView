//
//  TRDPinView.h
//  Pods
//
//  Created by Luis Gutierrez on 24-02-17.
//
//

@import UIKit;

@class TRDPinView;

typedef void(^TRDDigitViewSettingBlock)( UILabel * _Nonnull digitView);

@interface TRDPinView : UIControl <UITextInputTraits, UIKeyInput>

@property (nonatomic) NSInteger length;
@property (nonatomic) UIKeyboardType keyboardType;
@property (nonatomic) BOOL secureText;

@property (nullable, nonatomic, copy) TRDDigitViewSettingBlock settingBlock;

- (nullable instancetype)initWithLength:(NSInteger) length;

- (nullable NSString *)rawValue;

@end
