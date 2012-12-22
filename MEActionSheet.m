//
//  MEActionSheet.m
//  MEActionSheet
//
//  Created by Michael Enriquez on 12/21/12.
//
//

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

#import "MEActionSheet.h"

typedef void (^MEActionSheetButtonTapped)();

@interface MEActionSheetButton : NSObject
- (id)initWithTitle:(NSString *)title onTapped:(void(^)())tappedBlock;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) MEActionSheetButtonTapped tappedBlock;
@end

@implementation MEActionSheetButton

- (id)initWithTitle:(NSString *)title onTapped:(void(^)())tappedBlock {
  self = [super init];
  if (self) {
    self.title = title;
    self.tappedBlock = tappedBlock;
  }
  
  return self;
}

@end

@interface MEActionSheet()
@property (nonatomic, assign) id<UIActionSheetDelegate> actionSheetDelegate;
@property (nonatomic, strong) NSMutableArray *actionSheetButtons;
- (void)addButton:(MEActionSheetButton *)button;
@end

@implementation MEActionSheet

#pragma mark - Constructors

- (id)initWithTitle:(NSString *)title {
  self = [super init];
  if (self) {
    self.title = title;
    self.actionSheetButtons = [NSMutableArray array];
    self.delegate = self;
  }
  
  return self;
}


- (id)initWithTitle:(NSString *)title delegate:(id<UIActionSheetDelegate>)delegate {
  self = [self initWithTitle:title];
  if (self) {
    self.delegate = delegate;
  }
  
  return self;
}


#pragma mark - Public

- (void)setCancelButtonWithTitle:(NSString *)title {
  [self addButtonWithTitle:title onTapped:nil];
  self.cancelButtonIndex = self.numberOfButtons - 1;
}


- (void)setCancelButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action {
  [self addButtonWithTitle:title target:target action:action];
  self.cancelButtonIndex = self.numberOfButtons - 1;
}


- (void)setCancelButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action withObject:(id)object {
  [self addButtonWithTitle:title target:target action:action withObject:object];
  self.cancelButtonIndex = self.numberOfButtons - 1;
}


- (void)setCancelButtonWithTitle:(NSString *)title onTapped:(void(^)())tappedBlock {
  [self addButtonWithTitle:title onTapped:tappedBlock];
  self.cancelButtonIndex = self.numberOfButtons - 1;
}


- (void)setDestructiveButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action {
  [self addButtonWithTitle:title target:target action:action];
  self.destructiveButtonIndex = self.numberOfButtons - 1;
}


- (void)setDestructiveButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action withObject:(id)object {
  [self addButtonWithTitle:title target:target action:action withObject:object];
  self.destructiveButtonIndex = self.numberOfButtons - 1;
}


- (void)setDestructiveButtonWithTitle:(NSString *)title onTapped:(void(^)())tappedBlock {
  [self addButtonWithTitle:title onTapped:tappedBlock];
  self.destructiveButtonIndex = self.numberOfButtons - 1;
}


- (void)addButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action {
  MEActionSheetButton *actionSheetButton = [[MEActionSheetButton alloc] initWithTitle:title onTapped:^{
    [target performSelector:action];
  }];
  
  [self addButton:actionSheetButton];
}


- (void)addButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action withObject:(id)object {
  MEActionSheetButton *actionSheetButton = [[MEActionSheetButton alloc] initWithTitle:title onTapped:^{
    [target performSelector:action withObject:object];
  }];
  
  [self addButton:actionSheetButton];
}


- (void)addButtonWithTitle:(NSString *)title onTapped:(void(^)())tappedBlock {
  MEActionSheetButton *actionSheetButton = [[MEActionSheetButton alloc] initWithTitle:title onTapped:tappedBlock];
  
  [self addButton:actionSheetButton];
}


#pragma mark - UIActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (self.actionSheetButtons.count > buttonIndex) {
    MEActionSheetButton *button = [self.actionSheetButtons objectAtIndex:buttonIndex];
    if (button.tappedBlock) button.tappedBlock();
  }
  
  if ([self.actionSheetDelegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
    [self.actionSheetDelegate actionSheet:actionSheet clickedButtonAtIndex:buttonIndex];
  }
}


- (void)actionSheetCancel:(UIActionSheet *)actionSheet {
  if ([self.actionSheetDelegate respondsToSelector:@selector(actionSheetCancel:)]) {
    [self.actionSheetDelegate actionSheetCancel:actionSheet];
  }
}


- (void)willPresentActionSheet:(UIActionSheet *)actionSheet {
  if ([self.actionSheetDelegate respondsToSelector:@selector(willPresentActionSheet:)]) {
    [self.actionSheetDelegate willPresentActionSheet:actionSheet];
  }
}


- (void)didPresentActionSheet:(UIActionSheet *)actionSheet {
  if ([self.actionSheetDelegate respondsToSelector:@selector(didPresentActionSheet:)]) {
    [self.actionSheetDelegate didPresentActionSheet:actionSheet];
  }
}


- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
  if ([self.actionSheetDelegate respondsToSelector:@selector(actionSheet:willDismissWithButtonIndex:)]) {
    [self.actionSheetDelegate actionSheet:actionSheet willDismissWithButtonIndex:buttonIndex];
  }
}


- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
  if ([self.actionSheetDelegate respondsToSelector:@selector(actionSheet:didDismissWithButtonIndex:)]) {
    [self.actionSheetDelegate actionSheet:actionSheet didDismissWithButtonIndex:buttonIndex];
  }
}


#pragma mark - UIActionView

- (void)setDelegate:(id<UIActionSheetDelegate>)delegate {
  if (self.delegate) {
    // Called if user sets a delegate. Messages are forwarded on to the actionSheetDelegate.
    self.actionSheetDelegate = delegate;
  } else {
    // Called in the constructor. MEActionSheet will take over as the delegate
    [super setDelegate:delegate];
  }
}


#pragma mark - Private

- (void)addButton:(MEActionSheetButton *)button {
  [self addButtonWithTitle:button.title];
  [self.actionSheetButtons addObject:button];
}

@end

#pragma clang diagnostic pop
