.class public Lcom/samsung/android/gamesdk/GameSDKManager;
.super Ljava/lang/Object;
.source "GameSDKManager.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/samsung/android/gamesdk/GameSDKManager$Listener;
    }
.end annotation


# static fields
.field private static final DEFAULT_REFRESH_RATE:I = 0x3c

.field private static final GameSDK2_0:F = 2.0f

.field private static final GameSDK3_0:F = 3.0f

.field private static final GameSDK3_1:F = 3.1f

.field private static final GameSDK3_2:F = 3.2f

.field private static final GameSDK3_3:F = 3.3f

.field private static final GameSDK3_4:F = 3.4f

.field private static final INVALID_DOUBLE:D = -999.0

.field private static final INVALID_INT:I = -0x3e7

.field private static final TAG:Ljava/lang/String; = "GameSDKManager"


# instance fields
.field private final mEmptyIntArrary:[I

.field private mListener:Lcom/samsung/android/gamesdk/GameSDKManager$Listener;

.field private mService:Lcom/samsung/android/gamesdk/IGameSDKService;

.field private mServiceVersion:F


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 76
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    .line 20
    iput-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mService:Lcom/samsung/android/gamesdk/IGameSDKService;

    .line 23
    iput-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mListener:Lcom/samsung/android/gamesdk/GameSDKManager$Listener;

    const/high16 v0, -0x40800000    # -1.0f

    .line 24
    iput v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mServiceVersion:F

    const/4 v0, 0x0

    new-array v0, v0, [I

    .line 31
    iput-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mEmptyIntArrary:[I

    const-string v0, "gamesdk"

    .line 77
    invoke-static {v0}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 79
    invoke-static {v0}, Lcom/samsung/android/gamesdk/IGameSDKService$Stub;->asInterface(Landroid/os/IBinder;)Lcom/samsung/android/gamesdk/IGameSDKService;

    move-result-object v0

    iput-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mService:Lcom/samsung/android/gamesdk/IGameSDKService;

    .line 80
    invoke-direct {p0}, Lcom/samsung/android/gamesdk/GameSDKManager;->updateServiceVersion()V

    :cond_0
    return-void
.end method

.method static synthetic access$000(Lcom/samsung/android/gamesdk/GameSDKManager;)Lcom/samsung/android/gamesdk/GameSDKManager$Listener;
    .locals 0

    .line 14
    iget-object p0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mListener:Lcom/samsung/android/gamesdk/GameSDKManager$Listener;

    return-object p0
.end method

.method private getGpuUsage()D
    .locals 7

    const-wide v0, -0x3f70c80000000000L    # -999.0

    :try_start_0
    const-string v2, "/sys/kernel/gpu/gpu_busy"

    const/4 v3, 0x0

    new-array v4, v3, [Ljava/lang/String;

    .line 437
    invoke-static {v2, v4}, Ljava/nio/file/Paths;->get(Ljava/lang/String;[Ljava/lang/String;)Ljava/nio/file/Path;

    move-result-object v2

    invoke-static {v2}, Ljava/nio/file/Files;->readAllBytes(Ljava/nio/file/Path;)[B

    move-result-object v2

    if-eqz v2, :cond_2

    .line 438
    array-length v4, v2

    if-nez v4, :cond_0

    goto :goto_0

    .line 441
    :cond_0
    new-instance v4, Ljava/lang/String;

    sget-object v5, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v4, v2, v5}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    const-string v2, "%"

    .line 442
    invoke-virtual {v4, v2}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v2

    const-wide v5, 0x3f847ae140000000L    # 0.009999999776482582

    if-lez v2, :cond_1

    .line 444
    invoke-virtual {v4, v3, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    .line 445
    invoke-static {v2}, Ljava/lang/Double;->parseDouble(Ljava/lang/String;)D

    move-result-wide v0

    mul-double v0, v0, v5

    return-wide v0

    .line 451
    :cond_1
    invoke-static {v4}, Ljava/lang/Double;->parseDouble(Ljava/lang/String;)D

    move-result-wide v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    mul-double v0, v0, v5

    :cond_2
    :goto_0
    return-wide v0

    :catch_0
    move-exception v2

    .line 456
    invoke-virtual {v2}, Ljava/lang/Exception;->printStackTrace()V

    return-wide v0
.end method

.method public static isAvailable()Z
    .locals 1

    const-string v0, "gamesdk"

    .line 157
    invoke-static {v0}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return v0

    :cond_0
    const/4 v0, 0x1

    return v0
.end method

.method private updateServiceVersion()V
    .locals 3

    .line 700
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mService:Lcom/samsung/android/gamesdk/IGameSDKService;

    const-string v1, "GameSDKManager"

    if-nez v0, :cond_0

    const-string v0, "gamesdk system service is not available"

    .line 701
    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    .line 705
    :cond_0
    :try_start_0
    invoke-interface {v0}, Lcom/samsung/android/gamesdk/IGameSDKService;->getVersion()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v0

    iput v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mServiceVersion:F

    .line 706
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "updateServiceVersion() : "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v2, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mServiceVersion:F

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 708
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    :goto_0
    return-void
.end method


# virtual methods
.method public finalize(Ljava/lang/String;)V
    .locals 2

    const-string v0, "GameSDKManager"

    if-nez p1, :cond_0

    const-string p1, "packagename is null"

    .line 138
    invoke-static {v0, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 140
    :cond_0
    iget-object v1, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mService:Lcom/samsung/android/gamesdk/IGameSDKService;

    if-nez v1, :cond_1

    const-string p1, "gamesdk system service is not available"

    .line 141
    invoke-static {v0, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 145
    :cond_1
    :try_start_0
    invoke-interface {v1, p1}, Lcom/samsung/android/gamesdk/IGameSDKService;->finalGameSDK(Ljava/lang/String;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 147
    invoke-virtual {p1}, Landroid/os/RemoteException;->printStackTrace()V

    :goto_0
    return-void
.end method

.method public getCPULevelMax()I
    .locals 5

    .line 227
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mService:Lcom/samsung/android/gamesdk/IGameSDKService;

    const-string v1, "GameSDKManager"

    const/16 v2, -0x3e7

    if-nez v0, :cond_0

    const-string v0, "gamesdk system service is not available"

    .line 228
    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return v2

    .line 231
    :cond_0
    iget v3, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mServiceVersion:F

    const/high16 v4, 0x40400000    # 3.0f

    cmpg-float v3, v3, v4

    if-gez v3, :cond_1

    const-string v0, "getCPULevelMax() API is not supported this GameSDK Version"

    .line 232
    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return v2

    .line 236
    :cond_1
    :try_start_0
    invoke-interface {v0}, Lcom/samsung/android/gamesdk/IGameSDKService;->getCPULevelMax()I

    move-result v0
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    move-exception v0

    .line 238
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    return v2
.end method

.method public getClusterInfo()I
    .locals 5

    .line 578
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mService:Lcom/samsung/android/gamesdk/IGameSDKService;

    const-string v1, "GameSDKManager"

    const/16 v2, -0x3e7

    if-nez v0, :cond_0

    const-string v0, "gamesdk system service is not available"

    .line 579
    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return v2

    .line 582
    :cond_0
    iget v3, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mServiceVersion:F

    const v4, 0x4059999a    # 3.4f

    cmpg-float v3, v3, v4

    if-gez v3, :cond_1

    const-string v0, "getClusterInfo() API is not supported this GameSDK Version"

    .line 583
    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return v2

    .line 587
    :cond_1
    :try_start_0
    invoke-interface {v0}, Lcom/samsung/android/gamesdk/IGameSDKService;->getClusterInfo()I

    move-result v0
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    move-exception v0

    .line 589
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    return v2
.end method

.method public getCpuJTLevel()I
    .locals 3

    .line 371
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mService:Lcom/samsung/android/gamesdk/IGameSDKService;

    const/16 v1, -0x3e7

    if-nez v0, :cond_0

    const-string v0, "GameSDKManager"

    const-string v2, "gamesdk system service is not available"

    .line 372
    invoke-static {v0, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return v1

    .line 376
    :cond_0
    :try_start_0
    invoke-interface {v0}, Lcom/samsung/android/gamesdk/IGameSDKService;->getCpuJTLevel()I

    move-result v0
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    move-exception v0

    .line 378
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    return v1
.end method

.method public getCurrentRefreshRate()I
    .locals 5

    .line 683
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mService:Lcom/samsung/android/gamesdk/IGameSDKService;

    const-string v1, "GameSDKManager"

    const/16 v2, 0x3c

    if-nez v0, :cond_0

    const-string v0, "gamesdk system service is not available"

    .line 684
    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return v2

    .line 687
    :cond_0
    iget v3, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mServiceVersion:F

    const v4, 0x40466666    # 3.1f

    cmpg-float v3, v3, v4

    if-gez v3, :cond_1

    const-string v0, "getCurrentRefreshRate() API is not supported this GameSDK Version"

    .line 688
    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return v2

    .line 692
    :cond_1
    :try_start_0
    invoke-interface {v0}, Lcom/samsung/android/gamesdk/IGameSDKService;->getCurrentRefreshRate()I

    move-result v0
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    move-exception v0

    .line 694
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    return v2
.end method

.method public getGPULevelMax()I
    .locals 5

    .line 250
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mService:Lcom/samsung/android/gamesdk/IGameSDKService;

    const-string v1, "GameSDKManager"

    const/16 v2, -0x3e7

    if-nez v0, :cond_0

    const-string v0, "gamesdk system service is not available"

    .line 251
    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return v2

    .line 254
    :cond_0
    iget v3, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mServiceVersion:F

    const/high16 v4, 0x40400000    # 3.0f

    cmpg-float v3, v3, v4

    if-gez v3, :cond_1

    const-string v0, "getGPULevelMax() API is not supported this GameSDK Version"

    .line 255
    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return v2

    .line 259
    :cond_1
    :try_start_0
    invoke-interface {v0}, Lcom/samsung/android/gamesdk/IGameSDKService;->getGPULevelMax()I

    move-result v0
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    move-exception v0

    .line 261
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    return v2
.end method

.method public getGpuFrameTime()D
    .locals 9

    .line 409
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mService:Lcom/samsung/android/gamesdk/IGameSDKService;

    const-wide v1, -0x3f70c80000000000L    # -999.0

    if-nez v0, :cond_0

    const-string v0, "GameSDKManager"

    const-string v3, "gamesdk system service is not available"

    .line 410
    invoke-static {v0, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return-wide v1

    .line 414
    :cond_0
    :try_start_0
    invoke-interface {v0}, Lcom/samsung/android/gamesdk/IGameSDKService;->getGpuFrameTime()D

    move-result-wide v3

    cmpl-double v0, v1, v3

    if-nez v0, :cond_1

    .line 417
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mService:Lcom/samsung/android/gamesdk/IGameSDKService;

    invoke-interface {v0}, Lcom/samsung/android/gamesdk/IGameSDKService;->getFrameworkFPS()D

    move-result-wide v3

    .line 418
    invoke-direct {p0}, Lcom/samsung/android/gamesdk/GameSDKManager;->getGpuUsage()D

    move-result-wide v5

    cmpl-double v0, v5, v1

    if-eqz v0, :cond_2

    const-wide v7, 0x408f400000000000L    # 1000.0

    div-double/2addr v7, v3

    mul-double v5, v5, v7

    const-wide/high16 v3, 0x4059000000000000L    # 100.0

    mul-double v5, v5, v3

    .line 422
    invoke-static {v5, v6}, Ljava/lang/Math;->round(D)J

    move-result-wide v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    long-to-double v0, v0

    div-double/2addr v0, v3

    return-wide v0

    :cond_1
    return-wide v3

    :catch_0
    move-exception v0

    .line 430
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    :cond_2
    return-wide v1
.end method

.method public getGpuJTLevel()I
    .locals 3

    .line 390
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mService:Lcom/samsung/android/gamesdk/IGameSDKService;

    const/16 v1, -0x3e7

    if-nez v0, :cond_0

    const-string v0, "GameSDKManager"

    const-string v2, "gamesdk system service is not available"

    .line 391
    invoke-static {v0, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return v1

    .line 395
    :cond_0
    :try_start_0
    invoke-interface {v0}, Lcom/samsung/android/gamesdk/IGameSDKService;->getGpuJTLevel()I

    move-result v0
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    move-exception v0

    .line 397
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    return v1
.end method

.method public getHighPrecisionSkinTempLevel()D
    .locals 6

    .line 273
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mService:Lcom/samsung/android/gamesdk/IGameSDKService;

    const-string v1, "GameSDKManager"

    const-wide v2, -0x3f70c80000000000L    # -999.0

    if-nez v0, :cond_0

    const-string v0, "gamesdk system service is not available"

    .line 274
    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return-wide v2

    .line 277
    :cond_0
    iget v4, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mServiceVersion:F

    const/high16 v5, 0x40000000    # 2.0f

    cmpg-float v4, v4, v5

    if-gez v4, :cond_1

    const-string v0, "getHighPrecisionSkinTempLevel() API is not supported this GameSDK Version"

    .line 278
    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return-wide v2

    .line 282
    :cond_1
    :try_start_0
    invoke-interface {v0}, Lcom/samsung/android/gamesdk/IGameSDKService;->getHighPrecisionSkinTempLevel()D

    move-result-wide v0
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    return-wide v0

    :catch_0
    move-exception v0

    .line 284
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    return-wide v2
.end method

.method public getSkinTempLevel()I
    .locals 3

    .line 208
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mService:Lcom/samsung/android/gamesdk/IGameSDKService;

    const/16 v1, -0x3e7

    if-nez v0, :cond_0

    const-string v0, "GameSDKManager"

    const-string v2, "gamesdk system service is not available"

    .line 209
    invoke-static {v0, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return v1

    .line 213
    :cond_0
    :try_start_0
    invoke-interface {v0}, Lcom/samsung/android/gamesdk/IGameSDKService;->getSkinTempLevel()I

    move-result v0
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    move-exception v0

    .line 215
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    return v1
.end method

.method public getSupportedRefreshRates()[I
    .locals 4

    .line 622
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mService:Lcom/samsung/android/gamesdk/IGameSDKService;

    const-string v1, "GameSDKManager"

    if-nez v0, :cond_0

    const-string v0, "gamesdk system service is not available"

    .line 623
    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 624
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mEmptyIntArrary:[I

    return-object v0

    .line 626
    :cond_0
    iget v2, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mServiceVersion:F

    const v3, 0x40466666    # 3.1f

    cmpg-float v2, v2, v3

    if-gez v2, :cond_1

    const-string v0, "getSupportedRefreshRates() API is not supported this GameSDK Version"

    .line 627
    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 628
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mEmptyIntArrary:[I

    return-object v0

    .line 631
    :cond_1
    :try_start_0
    invoke-interface {v0}, Lcom/samsung/android/gamesdk/IGameSDKService;->getSupportedRefreshRates()[I

    move-result-object v0
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    move-exception v0

    .line 633
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 635
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mEmptyIntArrary:[I

    return-object v0
.end method

.method public getTempLevel()I
    .locals 3

    .line 189
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mService:Lcom/samsung/android/gamesdk/IGameSDKService;

    const/16 v1, -0x3e7

    if-nez v0, :cond_0

    const-string v0, "GameSDKManager"

    const-string v2, "gamesdk system service is not available"

    .line 190
    invoke-static {v0, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return v1

    .line 194
    :cond_0
    :try_start_0
    invoke-interface {v0}, Lcom/samsung/android/gamesdk/IGameSDKService;->getTempLevel()I

    move-result v0
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    move-exception v0

    .line 196
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    return v1
.end method

.method public getVersion()Ljava/lang/String;
    .locals 3

    .line 170
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mService:Lcom/samsung/android/gamesdk/IGameSDKService;

    const-string v1, "0"

    if-nez v0, :cond_0

    const-string v0, "GameSDKManager"

    const-string v2, "gamesdk system service is not available"

    .line 171
    invoke-static {v0, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return-object v1

    .line 175
    :cond_0
    :try_start_0
    invoke-interface {v0}, Lcom/samsung/android/gamesdk/IGameSDKService;->getVersion()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    move-exception v0

    .line 177
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    return-object v1
.end method

.method public initialize()Z
    .locals 3

    .line 92
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mService:Lcom/samsung/android/gamesdk/IGameSDKService;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    const-string v0, "GameSDKManager"

    const-string v2, "gamesdk system service is not available"

    .line 93
    invoke-static {v0, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return v1

    .line 97
    :cond_0
    :try_start_0
    invoke-interface {v0}, Lcom/samsung/android/gamesdk/IGameSDKService;->initGameSDK()Z

    move-result v0
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    move-exception v0

    .line 99
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    return v1
.end method

.method public initialize(Ljava/lang/String;)Z
    .locals 5

    .line 112
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mService:Lcom/samsung/android/gamesdk/IGameSDKService;

    const-string v1, "GameSDKManager"

    const/4 v2, 0x0

    if-nez v0, :cond_0

    const-string p1, "gamesdk system service is not available"

    .line 113
    invoke-static {v1, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return v2

    .line 117
    :cond_0
    :try_start_0
    iget v3, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mServiceVersion:F

    const v4, 0x40466666    # 3.1f

    cmpg-float v3, v3, v4

    if-gtz v3, :cond_1

    const-string p1, "initialize(String version) API is not supported this GameSDK Version"

    .line 118
    invoke-static {v1, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return v2

    .line 122
    :cond_1
    invoke-interface {v0, p1}, Lcom/samsung/android/gamesdk/IGameSDKService;->initGameSDKWithVersion(Ljava/lang/String;)Z

    move-result p1
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    return p1

    :catch_0
    move-exception p1

    .line 125
    invoke-virtual {p1}, Landroid/os/RemoteException;->printStackTrace()V

    return v2
.end method

.method public isGameSDKVariableRefreshRateSupported()Z
    .locals 5

    .line 601
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mService:Lcom/samsung/android/gamesdk/IGameSDKService;

    const-string v1, "GameSDKManager"

    const/4 v2, 0x0

    if-nez v0, :cond_0

    const-string v0, "gamesdk system service is not available"

    .line 602
    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return v2

    .line 605
    :cond_0
    iget v3, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mServiceVersion:F

    const v4, 0x40466666    # 3.1f

    cmpg-float v3, v3, v4

    if-gez v3, :cond_1

    const-string v0, "isGameSDKVariableRefreshRateSupported() API is not supported this GameSDK Version"

    .line 606
    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return v2

    .line 610
    :cond_1
    :try_start_0
    invoke-interface {v0}, Lcom/samsung/android/gamesdk/IGameSDKService;->isGameSDKVrrSupported()Z

    move-result v0
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    move-exception v0

    .line 612
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    return v2
.end method

.method public resetRefreshRate()V
    .locals 4

    .line 663
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mService:Lcom/samsung/android/gamesdk/IGameSDKService;

    const-string v1, "GameSDKManager"

    if-nez v0, :cond_0

    const-string v0, "gamesdk system service is not available"

    .line 664
    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    .line 667
    :cond_0
    iget v2, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mServiceVersion:F

    const v3, 0x40466666    # 3.1f

    cmpg-float v2, v2, v3

    if-gez v2, :cond_1

    const-string v0, "resetRefreshRate() API is not supported this GameSDK Version"

    .line 668
    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    .line 672
    :cond_1
    :try_start_0
    invoke-interface {v0}, Lcom/samsung/android/gamesdk/IGameSDKService;->resetRefreshRate()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 674
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    :goto_0
    return-void
.end method

.method public setCpuBoostMode(I)Z
    .locals 5

    .line 528
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mService:Lcom/samsung/android/gamesdk/IGameSDKService;

    const-string v1, "GameSDKManager"

    const/4 v2, 0x0

    if-nez v0, :cond_0

    const-string p1, "gamesdk system service is not available"

    .line 529
    invoke-static {v1, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return v2

    .line 532
    :cond_0
    iget v3, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mServiceVersion:F

    const v4, 0x4059999a    # 3.4f

    cmpg-float v3, v3, v4

    if-gez v3, :cond_1

    const-string p1, "setCpuBoostMode() API is not supported this GameSDK Version"

    .line 533
    invoke-static {v1, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return v2

    .line 537
    :cond_1
    :try_start_0
    invoke-interface {v0, p1}, Lcom/samsung/android/gamesdk/IGameSDKService;->setCpuBoostMode(I)Z

    move-result p1
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    return p1

    :catch_0
    move-exception p1

    .line 539
    invoke-virtual {p1}, Landroid/os/RemoteException;->printStackTrace()V

    return v2
.end method

.method public setDisableTMLevel(I)Z
    .locals 5

    .line 470
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mService:Lcom/samsung/android/gamesdk/IGameSDKService;

    const-string v1, "GameSDKManager"

    const/4 v2, 0x0

    if-nez v0, :cond_0

    const-string p1, "gamesdk system service is not available"

    .line 471
    invoke-static {v1, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return v2

    .line 474
    :cond_0
    iget v3, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mServiceVersion:F

    const v4, 0x40466666    # 3.1f

    cmpg-float v3, v3, v4

    if-gez v3, :cond_1

    const-string p1, "setDisableTMLevel() API is not supported this GameSDK Version"

    .line 475
    invoke-static {v1, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return v2

    .line 479
    :cond_1
    :try_start_0
    invoke-interface {v0, p1}, Lcom/samsung/android/gamesdk/IGameSDKService;->setDisableTMLevel(I)Z

    move-result p1
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    return p1

    :catch_0
    move-exception p1

    .line 481
    invoke-virtual {p1}, Landroid/os/RemoteException;->printStackTrace()V

    return v2
.end method

.method public setFreqLevels(II)I
    .locals 4

    .line 499
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mService:Lcom/samsung/android/gamesdk/IGameSDKService;

    const-string v1, "GameSDKManager"

    const/16 v2, -0x3e7

    if-nez v0, :cond_0

    const-string p1, "gamesdk system service is not available"

    .line 500
    invoke-static {v1, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return v2

    .line 503
    :cond_0
    iget v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mServiceVersion:F

    const v3, 0x40466666    # 3.1f

    cmpg-float v3, v0, v3

    if-gez v3, :cond_1

    const-string p1, "setFreqLevels() API is not supported this GameSDK Version"

    .line 504
    invoke-static {v1, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return v2

    :cond_1
    const v1, 0x404ccccd    # 3.2f

    cmpl-float v0, v0, v1

    if-nez v0, :cond_2

    if-nez p1, :cond_2

    const/4 p1, 0x1

    .line 511
    :cond_2
    :try_start_0
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mService:Lcom/samsung/android/gamesdk/IGameSDKService;

    invoke-interface {v0, p1, p2}, Lcom/samsung/android/gamesdk/IGameSDKService;->setFreqLevels(II)I

    move-result p1
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    return p1

    :catch_0
    move-exception p1

    .line 513
    invoke-virtual {p1}, Landroid/os/RemoteException;->printStackTrace()V

    return v2
.end method

.method public setGpuBoostMode(I)Z
    .locals 5

    .line 554
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mService:Lcom/samsung/android/gamesdk/IGameSDKService;

    const-string v1, "GameSDKManager"

    const/4 v2, 0x0

    if-nez v0, :cond_0

    const-string p1, "gamesdk system service is not available"

    .line 555
    invoke-static {v1, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return v2

    .line 558
    :cond_0
    iget v3, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mServiceVersion:F

    const v4, 0x4059999a    # 3.4f

    cmpg-float v3, v3, v4

    if-gez v3, :cond_1

    const-string p1, "setGpuBoostMode() API is not supported this GameSDK Version"

    .line 559
    invoke-static {v1, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return v2

    .line 563
    :cond_1
    :try_start_0
    invoke-interface {v0, p1}, Lcom/samsung/android/gamesdk/IGameSDKService;->setGpuBoostMode(I)Z

    move-result p1
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    return p1

    :catch_0
    move-exception p1

    .line 565
    invoke-virtual {p1}, Landroid/os/RemoteException;->printStackTrace()V

    return v2
.end method

.method public setLevelWithScene(Ljava/lang/String;II)Z
    .locals 3

    .line 298
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mService:Lcom/samsung/android/gamesdk/IGameSDKService;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    const-string p1, "GameSDKManager"

    const-string p2, "gamesdk system service is not available"

    .line 299
    invoke-static {p1, p2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return v1

    .line 304
    :cond_0
    :try_start_0
    iget v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mServiceVersion:F

    const v2, 0x404ccccd    # 3.2f

    cmpl-float v0, v0, v2

    if-nez v0, :cond_1

    if-nez p2, :cond_1

    const/4 p2, 0x1

    .line 307
    :cond_1
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mService:Lcom/samsung/android/gamesdk/IGameSDKService;

    invoke-interface {v0, p1, p2, p3}, Lcom/samsung/android/gamesdk/IGameSDKService;->setLevelWithScene(Ljava/lang/String;II)Z

    move-result p1
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    return p1

    :catch_0
    move-exception p1

    .line 309
    invoke-virtual {p1}, Landroid/os/RemoteException;->printStackTrace()V

    return v1
.end method

.method public setListener(Lcom/samsung/android/gamesdk/GameSDKManager$Listener;)Z
    .locals 1

    .line 321
    iput-object p1, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mListener:Lcom/samsung/android/gamesdk/GameSDKManager$Listener;

    .line 322
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mService:Lcom/samsung/android/gamesdk/IGameSDKService;

    if-eqz v0, :cond_1

    if-nez p1, :cond_0

    const/4 p1, 0x0

    .line 325
    :try_start_0
    invoke-interface {v0, p1}, Lcom/samsung/android/gamesdk/IGameSDKService;->setGameSDKListener(Lcom/samsung/android/gamesdk/IGameSDKListener;)Z

    move-result p1
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    return p1

    :catch_0
    move-exception p1

    .line 327
    invoke-virtual {p1}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .line 331
    :cond_0
    new-instance p1, Lcom/samsung/android/gamesdk/GameSDKManager$1;

    invoke-direct {p1, p0}, Lcom/samsung/android/gamesdk/GameSDKManager$1;-><init>(Lcom/samsung/android/gamesdk/GameSDKManager;)V

    .line 355
    :try_start_1
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mService:Lcom/samsung/android/gamesdk/IGameSDKService;

    invoke-interface {v0, p1}, Lcom/samsung/android/gamesdk/IGameSDKService;->setGameSDKListener(Lcom/samsung/android/gamesdk/IGameSDKListener;)Z

    move-result p1
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_1

    return p1

    :catch_1
    move-exception p1

    .line 357
    invoke-virtual {p1}, Landroid/os/RemoteException;->printStackTrace()V

    :cond_1
    :goto_0
    const/4 p1, 0x0

    return p1
.end method

.method public setRefreshRate(I)V
    .locals 4

    .line 643
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mService:Lcom/samsung/android/gamesdk/IGameSDKService;

    const-string v1, "GameSDKManager"

    if-nez v0, :cond_0

    const-string p1, "gamesdk system service is not available"

    .line 644
    invoke-static {v1, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    .line 647
    :cond_0
    iget v2, p0, Lcom/samsung/android/gamesdk/GameSDKManager;->mServiceVersion:F

    const v3, 0x40466666    # 3.1f

    cmpg-float v2, v2, v3

    if-gez v2, :cond_1

    const-string p1, "setRefreshRate() API is not supported this GameSDK Version"

    .line 648
    invoke-static {v1, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    .line 652
    :cond_1
    :try_start_0
    invoke-interface {v0, p1}, Lcom/samsung/android/gamesdk/IGameSDKService;->setRefreshRate(I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 654
    invoke-virtual {p1}, Landroid/os/RemoteException;->printStackTrace()V

    :goto_0
    return-void
.end method
