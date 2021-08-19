#import <UIKit/UIKit.h>

%group Functions

%hookf(BOOL, EmojiSearchEnabledForDevice) {
    return YES;
}

%hookf(NSString *, KeyboardReturnKeyStringConstantFromReturnKeyType, NSInteger keyType) {
    return %orig(keyType == 125 ? 9 : keyType);
}

%end

%ctor {
    MSImageRef ref = MSGetImageByName("/System/Library/PrivateFrameworks/UIKitCore.framework/UIKitCore");
    BOOL (*EmojiSearchEnabledForDevice)() = MSFindSymbol(ref, "_EmojiSearchEnabledForDevice");
    NSString *(*KeyboardReturnKeyStringConstantFromReturnKeyType)(NSInteger) = MSFindSymbol(ref, "_KeyboardReturnKeyStringConstantFromReturnKeyType");
    if (EmojiSearchEnabledForDevice && KeyboardReturnKeyStringConstantFromReturnKeyType) {
        %init(Functions);
    }
}