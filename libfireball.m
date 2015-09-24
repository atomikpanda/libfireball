#import "libfireball.h"

void FBSetPrefsTint(UIViewController *prefs, UIColor *tintColor)
{
	UIViewController *self = prefs;

	UISplitViewController *splitViewController = (UISplitViewController *)self.splitViewController;//[[UIApplication sharedApplication] keyWindow].rootViewController;
	UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
	UIViewController *lastViewController = navigationController.visibleViewController;//

	[navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:tintColor}];

	navigationController.navigationBar.tintColor = tintColor;
	lastViewController.view.tintColor = tintColor;
	[lastViewController.view setAutoresizesSubviews:YES];
	if([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
		[self setEdgesForExtendedLayout:UIRectEdgeBottom];
	}

	[UISegmentedControl appearanceWhenContainedIn:self.class, nil].tintColor = tintColor;
	[UISlider appearanceWhenContainedIn:self.class, nil].maximumTrackTintColor = tintColor;

	[[UISwitch appearanceWhenContainedIn:self.class, nil] setOnTintColor:tintColor];
}

void FBResetPrefsTint(UIViewController *prefs)
{
	UIViewController *self = prefs;

	UISplitViewController *splitViewController = (UISplitViewController *)self.splitViewController;//[[UIApplication sharedApplication] keyWindow].rootViewController;
	UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
	UIViewController *lastViewController = navigationController.visibleViewController;//

	navigationController.navigationBar.barTintColor = nil;
	navigationController.navigationBar.tintColor = nil;
	[navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
	lastViewController.view.tintColor = nil;
	[lastViewController.view setAutoresizesSubviews:NO];
}

void FBKillProcess(NSString *signal, NSString *processName)
{
	pid_t pid;
	signal = signal ? signal : @"9";
	signal = [NSString stringWithFormat:@"-%@", signal];
	
	const char *args[] = {"killall", signal.UTF8String, processName.UTF8String, NULL};
	posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char *const *)args, NULL);
}

@interface FBTwitterShareHandler : NSObject
@property (nonatomic, retain) NSString *shareText;
@property (assign) UIViewController *container;
@end

@implementation FBTwitterShareHandler
@synthesize shareText, container;

- (void)shareTapped:(UIBarButtonItem *)sender
{
	SLComposeViewController *composeController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
	[composeController setInitialText:shareText];
	[self.container presentViewController:composeController animated:YES completion:nil];
}

- (void)dealloc
{
	self.shareText = nil;
	[super dealloc];
}

@end

void FBAddTwitterShareButton(UIViewController *prefs, UIImage *twitterIcon, NSString *shareText)
{
	FBTwitterShareHandler *shareHandler = [[FBTwitterShareHandler new] autorelease];
	shareHandler.container = prefs;
	shareHandler.shareText = shareText;

	UIBarButtonItem *tweet = [[UIBarButtonItem alloc] initWithImage:twitterIcon style:UIBarButtonItemStylePlain target:shareHandler action:@selector(shareTapped:)];
	UIGraphicsBeginImageContextWithOptions(CGSizeMake(20, 20), NO, 0.0);
	UIImage *blank = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	[tweet setBackgroundImage:blank forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
	[prefs.navigationItem setRightBarButtonItem:tweet];

	[tweet release];
}
