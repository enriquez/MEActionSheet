//
//  MEActionSheet.h
//  MEActionSheet
//
//  Created by Michael Enriquez on 12/21/12.
//
//

#import <UIKit/UIKit.h>

@interface MEActionSheet : UIActionSheet <UIActionSheetDelegate>
- (id)initWithTitle:(NSString *)title;
- (id)initWithTitle:(NSString *)title delegate:(id<UIActionSheetDelegate>)delegate;
- (void)setCancelButtonWithTitle:(NSString *)title;
- (void)setCancelButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;
- (void)setCancelButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action withObject:(id)object;
- (void)setCancelButtonWithTitle:(NSString *)title onTapped:(void(^)())tappedBlock;
- (void)setDestructiveButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;
- (void)setDestructiveButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action withObject:(id)object;
- (void)setDestructiveButtonWithTitle:(NSString *)title onTapped:(void(^)())tappedBlock;
- (void)addButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;
- (void)addButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action withObject:(id)object;
- (void)addButtonWithTitle:(NSString *)title onTapped:(void(^)())tappedBlock;
@end
