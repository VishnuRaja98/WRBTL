.class public Lcom/unity3d/adaptiveperformance/samsung/GameLoadBooster;
.super Ljava/lang/Object;
.source "GameLoadBooster.java"


# static fields
.field private static manager:Lcom/samsung/android/gamesdk/GameSDKManager;

.field private static startupBoostEnabled:Ljava/lang/Boolean;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    .line 15
    invoke-static {}, Lcom/unity3d/adaptiveperformance/samsung/GameLoadBooster;->enableBoost()Z

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 10
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static checkStartupBoostEnabled()Z
    .locals 4

    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 51
    :try_start_0
    sget-object v2, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    if-nez v2, :cond_0

    return v0

    .line 54
    :cond_0
    invoke-virtual {v2}, Landroid/app/Activity;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v2

    const-string v3, "bin/Data/boot.config"

    invoke-virtual {v2, v3}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v2

    .line 55
    new-instance v3, Ljava/util/Scanner;

    invoke-direct {v3, v2}, Ljava/util/Scanner;-><init>(Ljava/io/InputStream;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    :try_start_1
    const-string v1, "\n"

    .line 56
    invoke-virtual {v3, v1}, Ljava/util/Scanner;->useDelimiter(Ljava/lang/String;)Ljava/util/Scanner;

    .line 57
    :cond_1
    invoke-virtual {v3}, Ljava/util/Scanner;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 58
    invoke-virtual {v3}, Ljava/util/Scanner;->next()Ljava/lang/String;

    move-result-object v1

    const-string v2, "adaptive-performance-samsung-boost-launch=0"

    .line 59
    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    if-eqz v1, :cond_1

    const/4 v0, 0x0

    .line 70
    :cond_2
    invoke-virtual {v3}, Ljava/util/Scanner;->close()V

    return v0

    :catchall_0
    move-exception v0

    move-object v1, v3

    goto :goto_0

    :catch_0
    move-object v1, v3

    goto :goto_1

    :catchall_1
    move-exception v0

    :goto_0
    if-eqz v1, :cond_3

    invoke-virtual {v1}, Ljava/util/Scanner;->close()V

    .line 71
    :cond_3
    throw v0

    :catch_1
    nop

    :goto_1
    if-eqz v1, :cond_4

    .line 70
    invoke-virtual {v1}, Ljava/util/Scanner;->close()V

    :cond_4
    return v0
.end method

.method public static enableBoost()Z
    .locals 6

    const/4 v0, 0x0

    .line 20
    :try_start_0
    invoke-static {}, Lcom/unity3d/adaptiveperformance/samsung/GameLoadBooster;->isStartupBoostEnabled()Z

    move-result v1

    if-nez v1, :cond_0

    return v0

    .line 22
    :cond_0
    sget-object v1, Lcom/unity3d/adaptiveperformance/samsung/GameLoadBooster;->manager:Lcom/samsung/android/gamesdk/GameSDKManager;

    if-nez v1, :cond_1

    .line 23
    new-instance v1, Lcom/samsung/android/gamesdk/GameSDKManager;

    invoke-direct {v1}, Lcom/samsung/android/gamesdk/GameSDKManager;-><init>()V

    sput-object v1, Lcom/unity3d/adaptiveperformance/samsung/GameLoadBooster;->manager:Lcom/samsung/android/gamesdk/GameSDKManager;

    .line 27
    :cond_1
    sget-object v1, Lcom/unity3d/adaptiveperformance/samsung/GameLoadBooster;->manager:Lcom/samsung/android/gamesdk/GameSDKManager;

    invoke-virtual {v1}, Lcom/samsung/android/gamesdk/GameSDKManager;->getVersion()Ljava/lang/String;

    move-result-object v1

    const-string v2, "3.5"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    const/4 v2, 0x1

    if-eqz v1, :cond_2

    .line 29
    sget-object v1, Lcom/unity3d/adaptiveperformance/samsung/GameLoadBooster;->manager:Lcom/samsung/android/gamesdk/GameSDKManager;

    invoke-virtual {v1, v2}, Lcom/samsung/android/gamesdk/GameSDKManager;->setCpuBoostMode(I)Z

    move-result v1

    .line 30
    sget-object v3, Lcom/unity3d/adaptiveperformance/samsung/GameLoadBooster;->manager:Lcom/samsung/android/gamesdk/GameSDKManager;

    invoke-virtual {v3, v2}, Lcom/samsung/android/gamesdk/GameSDKManager;->setGpuBoostMode(I)Z

    move-result v3

    goto :goto_0

    :cond_2
    const/4 v1, 0x0

    const/4 v3, 0x0

    :goto_0
    if-eqz v1, :cond_3

    if-eqz v3, :cond_3

    const-string v4, "Unity"

    const-string v5, "Enabled boost mode on launch"

    .line 33
    invoke-static {v4, v5}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :cond_3
    if-eqz v1, :cond_4

    if-eqz v3, :cond_4

    const/4 v0, 0x1

    :catch_0
    :cond_4
    return v0
.end method

.method private static isStartupBoostEnabled()Z
    .locals 1

    .line 41
    sget-object v0, Lcom/unity3d/adaptiveperformance/samsung/GameLoadBooster;->startupBoostEnabled:Ljava/lang/Boolean;

    if-nez v0, :cond_0

    .line 42
    invoke-static {}, Lcom/unity3d/adaptiveperformance/samsung/GameLoadBooster;->checkStartupBoostEnabled()Z

    move-result v0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    sput-object v0, Lcom/unity3d/adaptiveperformance/samsung/GameLoadBooster;->startupBoostEnabled:Ljava/lang/Boolean;

    .line 43
    :cond_0
    sget-object v0, Lcom/unity3d/adaptiveperformance/samsung/GameLoadBooster;->startupBoostEnabled:Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    return v0
.end method
