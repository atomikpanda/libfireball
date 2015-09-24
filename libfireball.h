#import <UIKit/UIKit.h>
#import <substrate.h>
#import <spawn.h>
#import <Social/Social.h>
#import <objc/runtime.h>

@class PSSpecifier;

// Call after [super viewWillAppear:animated]
void FBSetPrefsTint(UIViewController *prefs, UIColor *tintColor);

// Call after [super viewWillDisappear:animated]
void FBResetPrefsTint(UIViewController *prefs);

PSSpecifier *FBVersionCopyrightSpecifier(NSString *packageIdentifier, NSString *copyrightName, NSString *yearMade);

void FBKillProcess(NSString *signal, NSString *processName);

// Call this in -loadView to add a share button.
void FBAddTwitterShareButton(UIViewController *prefs, UIImage *twitterIcon, NSString *shareText);

void FBOpenTwitterUsername(NSString *username);

void FBOpenMailAddress(NSString *email);
