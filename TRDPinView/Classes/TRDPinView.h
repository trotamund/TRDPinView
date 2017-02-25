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
typedef void(^TRDPinViewActionBlock)(NSString * _Nullable value);

@interface TRDPinView : UIControl <UITextInputTraits, UIKeyInput>

@property (nonatomic) NSInteger length;
@property (nonatomic) UIKeyboardType keyboardType;
@property (nonatomic) BOOL secureText;

@property (nullable, nonatomic, copy) TRDDigitViewSettingBlock settingBlock;
@property (nullable, nonatomic, copy) TRDPinViewActionBlock actionBlock;

- (nullable instancetype)initWithLength:(NSInteger) length;

- (nullable NSString *)rawValue;

@end
