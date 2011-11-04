//  Constants.h
// Constants used in 2Swap

#define kSwaperSpriteZValue 100
#define kSwaperSpriteTagValue 0
#define kSwaperIdleTimer 3.0f
#define kSwaperFistDamage 10
#define kSwaperMalletDamage 40
//#define kRadarDishTagValue 10

#define kMainMenuTagValue 10
#define kSceneMenuTagValue 20

typedef enum {
    kNoSceneUninitialized=0,
    kMainMenuScene=1,
    kOptionsScene=2,
    kCreditsScene=3,
    kIntroScene=4,
    kLevelCompleteScene=5,
    kGameLevel1=101,
    kGameLevel2=102,
    kGameLevel3=103,
    kGameLevel4=104,
    kGameLevel5=105,
    kCutSceneForLevel2=201
} SceneTypes;

typedef enum {
    kLinkTypeBookSite,
    kLinkTypeDeveloperSiteRod,
    kLinkTypeDeveloperSiteRay,
    kLinkTypeArtistSite,
    kLinkTypeMusicianSite
} LinkTypes;

// Debug Enemy States with Labels
// 0 for OFF, 1 for ON
#define ENEMY_STATE_DEBUG 0