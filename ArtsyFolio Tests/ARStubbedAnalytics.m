#import <ARAnalytics/ARAnalytics.h>
#import "ARStubbedAnalytics.h"


@implementation ARStubbedProvider

+ (ARStubbedProvider *)setupAnalyticsWithStubbedProvider
{
    NSSet *oldProviders = [ARAnalytics currentProviders].copy;
    for (id provider in oldProviders) {
        [ARAnalytics removeProvider:provider];
    }

    ARStubbedProvider *provider = [[ARStubbedProvider alloc] initWithIdentifier:@"Stubby"];
    [ARAnalytics setupProvider:provider];
    return provider;
}

- (instancetype)initWithIdentifier:(NSString *)identifier
{
    self = [super initWithIdentifier:identifier];
    if (!self) return nil;

    _lastProviderIdentifier = identifier;

    return self;
}

- (void)identifyUserWithID:(NSString *)userID andEmailAddress:(NSString *)email
{
    _identifier = userID;
    _email = email;
}

- (void)setUserProperty:(NSString *)property toValue:(NSString *)value
{
    _lastUserPropertyKey = property;
    _lastUserPropertyValue = value;
}

- (void)event:(NSString *)event withProperties:(NSDictionary *)properties;
{
    _lastEventName = event;
    _lastEventProperties = properties;
}

- (void)incrementUserProperty:(NSString *)counterName byInt:(NSNumber *)amount
{
    _lastUserPropertyKey = counterName;
    _lastUserPropertyCount += amount.integerValue;
}

- (void)error:(NSError *)error withMessage:(NSString *)message
{
    _lastError = error;
    _lastErrorMessage = message;
}

- (void)monitorNavigationViewController:(UINavigationController *)controller
{
    _lastMonitoredNavigationController = controller;
    [super monitorNavigationViewController:controller];
}


- (void)logTimingEvent:(NSString *)event withInterval:(NSNumber *)interval
{
    _lastEventName = event;
}

- (void)logTimingEvent:(NSString *)event withInterval:(NSNumber *)interval properties:(NSDictionary *)properties
{
    [super logTimingEvent:event withInterval:interval properties:properties];

    _lastEventName = event;
    _lastEventProperties = properties;
}

- (void)remoteLog:(NSString *)parsedString
{
    _lastRemoteLog = parsedString;
}

@end
