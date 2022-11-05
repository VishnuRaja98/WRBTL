.class public Lcom/unity/androidnotifications/UnityNotificationManager;
.super Landroid/content/BroadcastReceiver;
.source "UnityNotificationManager.java"


# static fields
.field protected static final KEY_CHANNEL_ID:Ljava/lang/String; = "channelID"

.field protected static final KEY_FIRE_TIME:Ljava/lang/String; = "fireTime"

.field protected static final KEY_ID:Ljava/lang/String; = "id"

.field protected static final KEY_INTENT_DATA:Ljava/lang/String; = "data"

.field protected static final KEY_LARGE_ICON:Ljava/lang/String; = "largeIcon"

.field protected static final KEY_NOTIFICATION:Ljava/lang/String; = "unityNotification"

.field protected static final KEY_NOTIFICATION_DISMISSED:Ljava/lang/String; = "com.unity.NotificationDismissed"

.field protected static final KEY_NOTIFICATION_ID:Ljava/lang/String; = "com.unity.NotificationID"

.field protected static final KEY_REPEAT_INTERVAL:Ljava/lang/String; = "repeatInterval"

.field protected static final KEY_SMALL_ICON:Ljava/lang/String; = "smallIcon"

.field protected static final NOTIFICATION_CHANNELS_SHARED_PREFS:Ljava/lang/String; = "UNITY_NOTIFICATIONS"

.field protected static final NOTIFICATION_CHANNELS_SHARED_PREFS_KEY:Ljava/lang/String; = "ChannelIDs"

.field protected static final NOTIFICATION_IDS_SHARED_PREFS:Ljava/lang/String; = "UNITY_STORED_NOTIFICATION_IDS"

.field protected static final NOTIFICATION_IDS_SHARED_PREFS_KEY:Ljava/lang/String; = "UNITY_NOTIFICATION_IDS"

.field protected static final SAMSUNG_NOTIFICATION_LIMIT:I = 0x1f4

.field protected static final TAG_UNITY:Ljava/lang/String; = "UnityNotifications"

.field protected static mNotificationCallback:Lcom/unity/androidnotifications/NotificationCallback;

.field private static mPerformingHousekeeping:Z

.field private static mScheduledNotifications:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Ljava/lang/Integer;",
            "Landroid/app/Notification;",
            ">;"
        }
    .end annotation
.end field

.field private static mSentSinceLastHousekeeping:I

.field protected static mUnityNotificationManager:Lcom/unity/androidnotifications/UnityNotificationManager;

.field private static mVisibleNotifications:Ljava/util/HashSet;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashSet<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field protected mActivity:Landroid/app/Activity;

.field public mContext:Landroid/content/Context;

.field protected mOpenActivity:Ljava/lang/Class;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 40
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/unity/androidnotifications/UnityNotificationManager;->mScheduledNotifications:Ljava/util/HashMap;

    .line 41
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    sput-object v0, Lcom/unity/androidnotifications/UnityNotificationManager;->mVisibleNotifications:Ljava/util/HashSet;

    const/4 v0, 0x0

    .line 42
    sput v0, Lcom/unity/androidnotifications/UnityNotificationManager;->mSentSinceLastHousekeeping:I

    .line 43
    sput-boolean v0, Lcom/unity/androidnotifications/UnityNotificationManager;->mPerformingHousekeeping:Z

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 70
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    const/4 v0, 0x0

    .line 45
    iput-object v0, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mContext:Landroid/content/Context;

    .line 46
    iput-object v0, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mActivity:Landroid/app/Activity;

    .line 47
    iput-object v0, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mOpenActivity:Ljava/lang/Class;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/app/Activity;)V
    .locals 5

    const-string v0, "UnityNotifications"

    .line 75
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    const/4 v1, 0x0

    .line 45
    iput-object v1, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mContext:Landroid/content/Context;

    .line 46
    iput-object v1, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mActivity:Landroid/app/Activity;

    .line 47
    iput-object v1, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mOpenActivity:Ljava/lang/Class;

    .line 76
    iput-object p1, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mContext:Landroid/content/Context;

    .line 77
    iput-object p2, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mActivity:Landroid/app/Activity;

    .line 80
    :try_start_0
    invoke-virtual {p2}, Landroid/app/Activity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v2

    invoke-virtual {p2}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v3

    const/16 v4, 0x80

    invoke-virtual {v2, v3, v4}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;

    move-result-object v2

    .line 81
    iget-object v2, v2, Landroid/content/pm/ApplicationInfo;->metaData:Landroid/os/Bundle;

    const-string v3, "reschedule_notifications_on_restart"

    .line 83
    invoke-virtual {v2, v3}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v2

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    .line 85
    invoke-virtual {v2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 86
    new-instance v2, Landroid/content/ComponentName;

    const-class v3, Lcom/unity/androidnotifications/UnityNotificationRestartOnBootReceiver;

    invoke-direct {v2, p1, v3}, Landroid/content/ComponentName;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 87
    invoke-virtual {p1}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v3

    const/4 v4, 0x1

    .line 89
    invoke-virtual {v3, v2, v4, v4}, Landroid/content/pm/PackageManager;->setComponentEnabledSetting(Landroid/content/ComponentName;II)V

    :cond_0
    const/4 v2, 0x0

    .line 94
    invoke-static {p1, v2}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->getOpenAppActivity(Landroid/content/Context;Z)Ljava/lang/Class;

    move-result-object v2

    iput-object v2, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mOpenActivity:Ljava/lang/Class;

    if-nez v2, :cond_1

    .line 96
    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p2

    iput-object p2, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mOpenActivity:Ljava/lang/Class;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p2

    .line 100
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Failed to load meta-data, NullPointer: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/NullPointerException;->getMessage()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-static {v0, p2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :catch_1
    move-exception p2

    .line 98
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Failed to load meta-data, NameNotFound: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Landroid/content/pm/PackageManager$NameNotFoundException;->getMessage()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-static {v0, p2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 103
    :cond_1
    :goto_0
    invoke-static {p1, v1}, Lcom/unity/androidnotifications/UnityNotificationManager;->triggerHousekeeping(Landroid/content/Context;Ljava/util/Set;)V

    return-void
.end method

.method protected static buildNotificationForSending(Landroid/content/Context;Ljava/lang/Class;Landroid/app/Notification$Builder;)Landroid/app/Notification;
    .locals 3

    .line 326
    invoke-virtual {p2}, Landroid/app/Notification$Builder;->getExtras()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "id"

    const/4 v2, -0x1

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v0

    .line 327
    invoke-static {p0, p1}, Lcom/unity/androidnotifications/UnityNotificationManager;->buildOpenAppIntent(Landroid/content/Context;Ljava/lang/Class;)Landroid/content/Intent;

    move-result-object p1

    const-string v1, "com.unity.NotificationID"

    .line 328
    invoke-virtual {p1, v1, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const/4 v1, 0x0

    .line 329
    invoke-static {p0, v0, p1, v1}, Lcom/unity/androidnotifications/UnityNotificationManager;->getActivityPendingIntent(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object p1

    .line 330
    invoke-virtual {p2, p1}, Landroid/app/Notification$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/app/Notification$Builder;

    .line 332
    sget p1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x17

    if-ge p1, v2, :cond_0

    .line 334
    new-instance p1, Landroid/content/Intent;

    const-class v2, Lcom/unity/androidnotifications/UnityNotificationManager;

    invoke-direct {p1, p0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v2, "com.unity.NotificationDismissed"

    .line 335
    invoke-virtual {p1, v2}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 336
    invoke-virtual {p1, v2, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    .line 337
    invoke-static {p0, v0, p1, v1}, Lcom/unity/androidnotifications/UnityNotificationManager;->getBroadcastPendingIntent(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object p1

    .line 338
    invoke-virtual {p2, p1}, Landroid/app/Notification$Builder;->setDeleteIntent(Landroid/app/PendingIntent;)Landroid/app/Notification$Builder;

    .line 341
    :cond_0
    invoke-static {p0, p2}, Lcom/unity/androidnotifications/UnityNotificationManager;->finalizeNotificationForDisplay(Landroid/content/Context;Landroid/app/Notification$Builder;)V

    .line 342
    invoke-virtual {p2}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;

    move-result-object p0

    return-object p0
.end method

.method protected static buildNotificationIntent(Landroid/content/Context;)Landroid/content/Intent;
    .locals 2

    .line 472
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/unity/androidnotifications/UnityNotificationManager;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const p0, 0x10008000

    .line 473
    invoke-virtual {v0, p0}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    return-object v0
.end method

.method private static declared-synchronized buildNotificationIntentUpdateList(Landroid/content/Context;I)Landroid/content/Intent;
    .locals 4

    const-class v0, Lcom/unity/androidnotifications/UnityNotificationManager;

    monitor-enter v0

    .line 355
    :try_start_0
    invoke-static {p0}, Lcom/unity/androidnotifications/UnityNotificationManager;->getScheduledNotificationIDs(Landroid/content/Context;)Ljava/util/Set;

    move-result-object v1

    .line 356
    sget-object v2, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;

    const-string v3, "samsung"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Set;->size()I

    move-result v2

    const/16 v3, 0x1f3

    if-lt v2, v3, :cond_0

    const-string p0, "UnityNotifications"

    const-string p1, "Attempting to schedule more than %1$d notifications. There is a limit of %1$d concurrently scheduled Alarms on Samsung devices either wait for the currently scheduled ones to be triggered or cancel them if you wish to schedule additional notifications."

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    const/16 v3, 0x1f4

    .line 361
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v1, v2

    .line 359
    invoke-static {p1, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const/4 p0, 0x0

    .line 362
    monitor-exit v0

    return-object p0

    .line 365
    :cond_0
    :try_start_1
    invoke-static {p0}, Lcom/unity/androidnotifications/UnityNotificationManager;->buildNotificationIntent(Landroid/content/Context;)Landroid/content/Intent;

    move-result-object v2

    .line 366
    new-instance v3, Ljava/util/HashSet;

    invoke-direct {v3, v1}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    .line 367
    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p1

    invoke-interface {v3, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 368
    invoke-static {p0, v3}, Lcom/unity/androidnotifications/UnityNotificationManager;->saveScheduledNotificationIDs(Landroid/content/Context;Ljava/util/Set;)V

    .line 369
    invoke-static {p0, v3}, Lcom/unity/androidnotifications/UnityNotificationManager;->scheduleHousekeeping(Landroid/content/Context;Ljava/util/Set;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 370
    monitor-exit v0

    return-object v2

    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method protected static buildOpenAppIntent(Landroid/content/Context;Ljava/lang/Class;)Landroid/content/Intent;
    .locals 1

    .line 347
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0, p0, p1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 p0, 0x30000000

    .line 348
    invoke-virtual {v0, p0}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    return-object v0
.end method

.method private static canScheduleExactAlarms(Landroid/app/AlarmManager;)Z
    .locals 2

    .line 546
    sget p0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/4 v0, 0x0

    const/16 v1, 0x1f

    if-lt p0, v1, :cond_0

    return v0

    .line 548
    :cond_0
    sget p0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x17

    if-lt p0, v1, :cond_1

    const/4 v0, 0x1

    :cond_1
    return v0
.end method

.method protected static cancelPendingNotificationIntent(Landroid/content/Context;I)V
    .locals 2

    .line 634
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/unity/androidnotifications/UnityNotificationManager;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 v1, 0x20000000

    .line 635
    invoke-static {p0, p1, v0, v1}, Lcom/unity/androidnotifications/UnityNotificationManager;->getBroadcastPendingIntent(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object p1

    if-eqz p1, :cond_1

    if-eqz p0, :cond_0

    const-string v0, "alarm"

    .line 639
    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/app/AlarmManager;

    .line 640
    invoke-virtual {p0, p1}, Landroid/app/AlarmManager;->cancel(Landroid/app/PendingIntent;)V

    .line 642
    :cond_0
    invoke-virtual {p1}, Landroid/app/PendingIntent;->cancel()V

    :cond_1
    return-void
.end method

.method protected static createNotificationBuilder(Landroid/content/Context;Ljava/lang/String;)Landroid/app/Notification$Builder;
    .locals 4

    .line 764
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-ge v0, v1, :cond_6

    .line 765
    new-instance v0, Landroid/app/Notification$Builder;

    invoke-direct {v0, p0}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;)V

    .line 768
    invoke-static {p0, p1}, Lcom/unity/androidnotifications/UnityNotificationManager;->getNotificationChannel(Landroid/content/Context;Ljava/lang/String;)Lcom/unity/androidnotifications/NotificationChannelWrapper;

    move-result-object p0

    .line 770
    iget-object v1, p0, Lcom/unity/androidnotifications/NotificationChannelWrapper;->vibrationPattern:[J

    const/4 v2, -0x1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/unity/androidnotifications/NotificationChannelWrapper;->vibrationPattern:[J

    array-length v1, v1

    if-lez v1, :cond_0

    const/4 v1, 0x5

    .line 771
    invoke-virtual {v0, v1}, Landroid/app/Notification$Builder;->setDefaults(I)Landroid/app/Notification$Builder;

    .line 772
    iget-object v1, p0, Lcom/unity/androidnotifications/NotificationChannelWrapper;->vibrationPattern:[J

    invoke-virtual {v0, v1}, Landroid/app/Notification$Builder;->setVibrate([J)Landroid/app/Notification$Builder;

    goto :goto_0

    .line 774
    :cond_0
    invoke-virtual {v0, v2}, Landroid/app/Notification$Builder;->setDefaults(I)Landroid/app/Notification$Builder;

    .line 777
    :goto_0
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x15

    if-lt v1, v3, :cond_1

    .line 778
    iget v1, p0, Lcom/unity/androidnotifications/NotificationChannelWrapper;->lockscreenVisibility:I

    invoke-virtual {v0, v1}, Landroid/app/Notification$Builder;->setVisibility(I)Landroid/app/Notification$Builder;

    .line 783
    :cond_1
    iget p0, p0, Lcom/unity/androidnotifications/NotificationChannelWrapper;->importance:I

    const/4 v1, 0x0

    const/4 v3, 0x2

    if-eqz p0, :cond_4

    if-eq p0, v3, :cond_5

    const/4 v2, 0x3

    if-eq p0, v2, :cond_2

    const/4 v2, 0x4

    if-eq p0, v2, :cond_3

    :cond_2
    const/4 v2, 0x0

    goto :goto_1

    :cond_3
    const/4 v2, 0x2

    goto :goto_1

    :cond_4
    const/4 v2, -0x2

    .line 799
    :cond_5
    :goto_1
    invoke-virtual {v0, v2}, Landroid/app/Notification$Builder;->setPriority(I)Landroid/app/Notification$Builder;

    .line 800
    invoke-virtual {v0}, Landroid/app/Notification$Builder;->getExtras()Landroid/os/Bundle;

    move-result-object p0

    const-string v1, "channelID"

    invoke-virtual {p0, v1, p1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    return-object v0

    .line 804
    :cond_6
    new-instance v0, Landroid/app/Notification$Builder;

    invoke-direct {v0, p0, p1}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    return-object v0
.end method

.method protected static declared-synchronized deleteExpiredNotificationIntent(Landroid/content/Context;Ljava/lang/String;)V
    .locals 2

    const-class v0, Lcom/unity/androidnotifications/UnityNotificationManager;

    monitor-enter v0

    .line 648
    :try_start_0
    invoke-static {p1}, Lcom/unity/androidnotifications/UnityNotificationManager;->getSharedPrefsNameByNotificationId(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p0

    .line 649
    invoke-interface {p0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    invoke-interface {p0}, Landroid/content/SharedPreferences$Editor;->clear()Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    invoke-interface {p0}, Landroid/content/SharedPreferences$Editor;->apply()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 650
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method public static finalizeNotificationForDisplay(Landroid/content/Context;Landroid/app/Notification$Builder;)V
    .locals 2

    .line 745
    invoke-virtual {p1}, Landroid/app/Notification$Builder;->getExtras()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "smallIcon"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 746
    invoke-static {p0, v0}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->findResourceIdInContextByName(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_0

    .line 748
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v0

    iget v0, v0, Landroid/content/pm/ApplicationInfo;->icon:I

    .line 750
    :cond_0
    invoke-virtual {p1, v0}, Landroid/app/Notification$Builder;->setSmallIcon(I)Landroid/app/Notification$Builder;

    .line 751
    invoke-virtual {p1}, Landroid/app/Notification$Builder;->getExtras()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "largeIcon"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 752
    invoke-static {p0, v0}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->findResourceIdInContextByName(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_1

    .line 754
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p0

    invoke-static {p0, v0}, Landroid/graphics/BitmapFactory;->decodeResource(Landroid/content/res/Resources;I)Landroid/graphics/Bitmap;

    move-result-object p0

    invoke-virtual {p1, p0}, Landroid/app/Notification$Builder;->setLargeIcon(Landroid/graphics/Bitmap;)Landroid/app/Notification$Builder;

    :cond_1
    return-void
.end method

.method private static findInvalidNotificationIds(Landroid/content/Context;Ljava/util/Set;)Ljava/util/Set;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 433
    invoke-static {p0}, Lcom/unity/androidnotifications/UnityNotificationManager;->buildNotificationIntent(Landroid/content/Context;)Landroid/content/Intent;

    move-result-object v0

    .line 434
    new-instance v1, Ljava/util/HashSet;

    invoke-direct {v1}, Ljava/util/HashSet;-><init>()V

    .line 435
    invoke-interface {p1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_0
    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 438
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    const/high16 v4, 0x20000000

    invoke-static {p0, v3, v0, v4}, Lcom/unity/androidnotifications/UnityNotificationManager;->getBroadcastPendingIntent(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v3

    if-nez v3, :cond_0

    .line 440
    invoke-virtual {v1, v2}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 444
    :cond_1
    sget p1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v0, 0x17

    if-lt p1, v0, :cond_2

    .line 445
    invoke-static {p0}, Lcom/unity/androidnotifications/UnityNotificationManager;->getNotificationManager(Landroid/content/Context;)Landroid/app/NotificationManager;

    move-result-object p0

    invoke-virtual {p0}, Landroid/app/NotificationManager;->getActiveNotifications()[Landroid/service/notification/StatusBarNotification;

    move-result-object p0

    .line 446
    array-length p1, p0

    const/4 v0, 0x0

    :goto_1
    if-ge v0, p1, :cond_4

    aget-object v2, p0, v0

    .line 448
    invoke-virtual {v2}, Landroid/service/notification/StatusBarNotification;->getId()I

    move-result v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    .line 449
    invoke-virtual {v1, v2}, Ljava/util/HashSet;->remove(Ljava/lang/Object;)Z

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 452
    :cond_2
    const-class p0, Lcom/unity/androidnotifications/UnityNotificationManager;

    monitor-enter p0

    .line 453
    :try_start_0
    sget-object p1, Lcom/unity/androidnotifications/UnityNotificationManager;->mVisibleNotifications:Ljava/util/HashSet;

    invoke-virtual {p1}, Ljava/util/HashSet;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_2
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 454
    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 455
    invoke-virtual {v1, v0}, Ljava/util/HashSet;->remove(Ljava/lang/Object;)Z

    goto :goto_2

    .line 457
    :cond_3
    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 460
    :cond_4
    sget-object p0, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    if-eqz p0, :cond_5

    .line 461
    sget-object p0, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    invoke-virtual {p0}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;

    move-result-object p0

    const-string p1, "com.unity.NotificationID"

    .line 462
    invoke-virtual {p0, p1}, Landroid/content/Intent;->hasExtra(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_5

    .line 463
    invoke-virtual {p0}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object p0

    const-string p1, "com.unity.NotificationID"

    invoke-virtual {p0, p1}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result p0

    .line 464
    invoke-static {p0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v1, p0}, Ljava/util/HashSet;->remove(Ljava/lang/Object;)Z

    :cond_5
    return-object v1

    :catchall_0
    move-exception p1

    .line 457
    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method

.method public static getActivityPendingIntent(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;
    .locals 2

    .line 478
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x17

    if-lt v0, v1, :cond_0

    const/high16 v0, 0x4000000

    or-int/2addr p3, v0

    .line 479
    invoke-static {p0, p1, p2, p3}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object p0

    return-object p0

    .line 481
    :cond_0
    invoke-static {p0, p1, p2, p3}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object p0

    return-object p0
.end method

.method public static getBroadcastPendingIntent(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;
    .locals 2

    .line 485
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x17

    if-lt v0, v1, :cond_0

    const/high16 v0, 0x4000000

    or-int/2addr p3, v0

    .line 486
    invoke-static {p0, p1, p2, p3}, Landroid/app/PendingIntent;->getBroadcast(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object p0

    return-object p0

    .line 488
    :cond_0
    invoke-static {p0, p1, p2, p3}, Landroid/app/PendingIntent;->getBroadcast(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object p0

    return-object p0
.end method

.method protected static getNotificationChannel(Landroid/content/Context;Ljava/lang/String;)Lcom/unity/androidnotifications/NotificationChannelWrapper;
    .locals 6

    .line 185
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-lt v0, v1, :cond_0

    .line 186
    invoke-static {p0, p1}, Lcom/unity/androidnotifications/UnityNotificationManagerOreo;->getOreoNotificationChannel(Landroid/content/Context;Ljava/lang/String;)Lcom/unity/androidnotifications/NotificationChannelWrapper;

    move-result-object p0

    return-object p0

    .line 189
    :cond_0
    invoke-static {p1}, Lcom/unity/androidnotifications/UnityNotificationManager;->getSharedPrefsNameByChannelId(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p0

    .line 190
    new-instance v0, Lcom/unity/androidnotifications/NotificationChannelWrapper;

    invoke-direct {v0}, Lcom/unity/androidnotifications/NotificationChannelWrapper;-><init>()V

    .line 192
    iput-object p1, v0, Lcom/unity/androidnotifications/NotificationChannelWrapper;->id:Ljava/lang/String;

    const-string p1, "title"

    const-string v2, "undefined"

    .line 193
    invoke-interface {p0, p1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, v0, Lcom/unity/androidnotifications/NotificationChannelWrapper;->name:Ljava/lang/String;

    const/4 p1, 0x3

    const-string v3, "importance"

    .line 194
    invoke-interface {p0, v3, p1}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result p1

    iput p1, v0, Lcom/unity/androidnotifications/NotificationChannelWrapper;->importance:I

    const-string p1, "description"

    .line 195
    invoke-interface {p0, p1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, v0, Lcom/unity/androidnotifications/NotificationChannelWrapper;->description:Ljava/lang/String;

    const-string p1, "enableLights"

    .line 196
    invoke-interface {p0, p1, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result p1

    iput-boolean p1, v0, Lcom/unity/androidnotifications/NotificationChannelWrapper;->enableLights:Z

    const-string p1, "enableVibration"

    .line 197
    invoke-interface {p0, p1, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result p1

    iput-boolean p1, v0, Lcom/unity/androidnotifications/NotificationChannelWrapper;->enableVibration:Z

    const-string p1, "canBypassDnd"

    .line 198
    invoke-interface {p0, p1, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result p1

    iput-boolean p1, v0, Lcom/unity/androidnotifications/NotificationChannelWrapper;->canBypassDnd:Z

    const-string p1, "canShowBadge"

    .line 199
    invoke-interface {p0, p1, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result p1

    iput-boolean p1, v0, Lcom/unity/androidnotifications/NotificationChannelWrapper;->canShowBadge:Z

    const-string p1, "lockscreenVisibility"

    const/4 v2, 0x1

    .line 200
    invoke-interface {p0, p1, v2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result p1

    iput p1, v0, Lcom/unity/androidnotifications/NotificationChannelWrapper;->lockscreenVisibility:I

    const-string p1, "vibrationPattern"

    const-string v3, "[]"

    .line 201
    invoke-interface {p0, p1, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    const-string p1, ","

    invoke-virtual {p0, p1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p0

    .line 203
    array-length p1, p0

    new-array v3, p1, [J

    if-le p1, v2, :cond_1

    .line 206
    :goto_0
    array-length v4, p0

    if-ge v1, v4, :cond_1

    .line 208
    :try_start_0
    aget-object v4, p0, v1

    invoke-static {v4}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v4

    aput-wide v4, v3, v1
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    const-wide/16 v4, 0x1

    .line 210
    aput-wide v4, v3, v1

    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    if-le p1, v2, :cond_2

    goto :goto_2

    :cond_2
    const/4 v3, 0x0

    .line 215
    :goto_2
    iput-object v3, v0, Lcom/unity/androidnotifications/NotificationChannelWrapper;->vibrationPattern:[J

    return-object v0
.end method

.method public static getNotificationChannelId(Landroid/app/Notification;)Ljava/lang/String;
    .locals 2

    .line 837
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-lt v0, v1, :cond_0

    .line 838
    invoke-virtual {p0}, Landroid/app/Notification;->getChannelId()Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_0
    const/4 p0, 0x0

    return-object p0
.end method

.method public static getNotificationColor(Landroid/app/Notification;)Ljava/lang/Integer;
    .locals 3

    .line 728
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/4 v1, 0x0

    const/16 v2, 0x15

    if-ge v0, v2, :cond_0

    return-object v1

    .line 730
    :cond_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1a

    if-lt v0, v2, :cond_1

    .line 731
    iget-object v0, p0, Landroid/app/Notification;->extras:Landroid/os/Bundle;

    const-string v2, "android.colorized"

    invoke-virtual {v0, v2}, Landroid/os/Bundle;->containsKey(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    return-object v1

    .line 735
    :cond_1
    iget p0, p0, Landroid/app/Notification;->color:I

    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p0

    return-object p0
.end method

.method public static getNotificationFromIntent(Landroid/content/Context;Landroid/content/Intent;)Landroid/app/Notification;
    .locals 0

    .line 845
    invoke-static {p0, p1}, Lcom/unity/androidnotifications/UnityNotificationManager;->getNotificationOrBuilderForIntent(Landroid/content/Context;Landroid/content/Intent;)Ljava/lang/Object;

    move-result-object p0

    if-nez p0, :cond_0

    const/4 p0, 0x0

    return-object p0

    .line 848
    :cond_0
    instance-of p1, p0, Landroid/app/Notification;

    if-eqz p1, :cond_1

    .line 849
    check-cast p0, Landroid/app/Notification;

    return-object p0

    .line 850
    :cond_1
    check-cast p0, Landroid/app/Notification$Builder;

    .line 851
    invoke-virtual {p0}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;

    move-result-object p0

    return-object p0
.end method

.method public static getNotificationGroupAlertBehavior(Landroid/app/Notification;)I
    .locals 2

    .line 739
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-lt v0, v1, :cond_0

    .line 740
    invoke-virtual {p0}, Landroid/app/Notification;->getGroupAlertBehavior()I

    move-result p0

    return p0

    :cond_0
    const/4 p0, 0x0

    return p0
.end method

.method public static getNotificationManager(Landroid/content/Context;)Landroid/app/NotificationManager;
    .locals 1

    const-string v0, "notification"

    .line 130
    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/app/NotificationManager;

    return-object p0
.end method

.method public static getNotificationManagerImpl(Landroid/content/Context;)Lcom/unity/androidnotifications/UnityNotificationManager;
    .locals 1

    .line 107
    move-object v0, p0

    check-cast v0, Landroid/app/Activity;

    invoke-static {p0, v0}, Lcom/unity/androidnotifications/UnityNotificationManager;->getNotificationManagerImpl(Landroid/content/Context;Landroid/app/Activity;)Lcom/unity/androidnotifications/UnityNotificationManager;

    move-result-object p0

    return-object p0
.end method

.method public static getNotificationManagerImpl(Landroid/content/Context;Landroid/app/Activity;)Lcom/unity/androidnotifications/UnityNotificationManager;
    .locals 2

    .line 112
    sget-object v0, Lcom/unity/androidnotifications/UnityNotificationManager;->mUnityNotificationManager:Lcom/unity/androidnotifications/UnityNotificationManager;

    if-eqz v0, :cond_0

    return-object v0

    .line 115
    :cond_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-lt v0, v1, :cond_1

    .line 116
    new-instance v0, Lcom/unity/androidnotifications/UnityNotificationManagerOreo;

    invoke-direct {v0, p0, p1}, Lcom/unity/androidnotifications/UnityNotificationManagerOreo;-><init>(Landroid/content/Context;Landroid/app/Activity;)V

    sput-object v0, Lcom/unity/androidnotifications/UnityNotificationManager;->mUnityNotificationManager:Lcom/unity/androidnotifications/UnityNotificationManager;

    goto :goto_0

    .line 118
    :cond_1
    new-instance v0, Lcom/unity/androidnotifications/UnityNotificationManager;

    invoke-direct {v0, p0, p1}, Lcom/unity/androidnotifications/UnityNotificationManager;-><init>(Landroid/content/Context;Landroid/app/Activity;)V

    sput-object v0, Lcom/unity/androidnotifications/UnityNotificationManager;->mUnityNotificationManager:Lcom/unity/androidnotifications/UnityNotificationManager;

    .line 121
    :goto_0
    sget-object p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mUnityNotificationManager:Lcom/unity/androidnotifications/UnityNotificationManager;

    return-object p0
.end method

.method public static getNotificationOrBuilderForIntent(Landroid/content/Context;Landroid/content/Intent;)Ljava/lang/Object;
    .locals 4

    const-string v0, "com.unity.NotificationID"

    .line 857
    invoke-virtual {p1, v0}, Landroid/content/Intent;->hasExtra(Ljava/lang/String;)Z

    move-result v1

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-eqz v1, :cond_1

    .line 858
    invoke-virtual {p1}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object p1

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result p1

    .line 859
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    .line 860
    invoke-static {v0}, Lcom/unity/androidnotifications/UnityNotificationManager;->getScheduledNotification(Ljava/lang/Integer;)Landroid/app/Notification;

    move-result-object v0

    if-eqz v0, :cond_0

    goto :goto_1

    .line 864
    :cond_0
    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/unity/androidnotifications/UnityNotificationManager;->getSharedPrefsNameByNotificationId(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1, v3}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    .line 865
    invoke-static {p0, p1}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->deserializeNotification(Landroid/content/Context;Landroid/content/SharedPreferences;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :cond_1
    const-string v0, "unityNotification"

    .line 867
    invoke-virtual {p1, v0}, Landroid/content/Intent;->hasExtra(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 870
    invoke-virtual {p1, v0}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v0

    goto :goto_1

    :cond_2
    const/4 v0, 0x0

    :goto_0
    const/4 v2, 0x0

    :goto_1
    if-eqz v0, :cond_5

    if-eqz v2, :cond_3

    goto :goto_3

    .line 878
    :cond_3
    instance-of p1, v0, Landroid/app/Notification;

    if-eqz p1, :cond_4

    .line 879
    check-cast v0, Landroid/app/Notification;

    invoke-static {p0, v0}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->recoverBuilder(Landroid/content/Context;Landroid/app/Notification;)Landroid/app/Notification$Builder;

    move-result-object p0

    goto :goto_2

    .line 882
    :cond_4
    move-object p0, v0

    check-cast p0, Landroid/app/Notification$Builder;

    :goto_2
    return-object p0

    :cond_5
    :goto_3
    return-object v0
.end method

.method private static declared-synchronized getScheduledNotification(Ljava/lang/Integer;)Landroid/app/Notification;
    .locals 2

    const-class v0, Lcom/unity/androidnotifications/UnityNotificationManager;

    monitor-enter v0

    .line 914
    :try_start_0
    sget-object v1, Lcom/unity/androidnotifications/UnityNotificationManager;->mScheduledNotifications:Ljava/util/HashMap;

    invoke-virtual {v1, p0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/app/Notification;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-object p0

    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method private static declared-synchronized getScheduledNotificationIDs(Landroid/content/Context;)Ljava/util/Set;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    const-class v0, Lcom/unity/androidnotifications/UnityNotificationManager;

    monitor-enter v0

    :try_start_0
    const-string v1, "UNITY_STORED_NOTIFICATION_IDS"

    const/4 v2, 0x0

    .line 613
    invoke-virtual {p0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p0

    const-string v1, "UNITY_NOTIFICATION_IDS"

    .line 614
    new-instance v2, Ljava/util/HashSet;

    invoke-direct {v2}, Ljava/util/HashSet;-><init>()V

    invoke-interface {p0, v1, v2}, Landroid/content/SharedPreferences;->getStringSet(Ljava/lang/String;Ljava/util/Set;)Ljava/util/Set;

    move-result-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 615
    monitor-exit v0

    return-object p0

    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method protected static getSharedPrefsNameByChannelId(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/Object;

    const/4 v1, 0x0

    aput-object p0, v0, v1

    const-string p0, "unity_notification_channel_%s"

    .line 179
    invoke-static {p0, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method protected static getSharedPrefsNameByNotificationId(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/Object;

    const/4 v1, 0x0

    aput-object p0, v0, v1

    const-string p0, "u_notification_data_%s"

    .line 501
    invoke-static {p0, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static synthetic lambda$cancelAllPendingNotificationIntents$1(Ljava/util/Set;Landroid/content/Context;)V
    .locals 2

    .line 603
    invoke-interface {p0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 604
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    invoke-static {p1, v1}, Lcom/unity/androidnotifications/UnityNotificationManager;->cancelPendingNotificationIntent(Landroid/content/Context;I)V

    .line 605
    invoke-static {p1, v0}, Lcom/unity/androidnotifications/UnityNotificationManager;->deleteExpiredNotificationIntent(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    .line 607
    invoke-static {p1, p0}, Lcom/unity/androidnotifications/UnityNotificationManager;->triggerHousekeeping(Landroid/content/Context;Ljava/util/Set;)V

    return-void
.end method

.method static synthetic lambda$triggerHousekeeping$0(Landroid/content/Context;Ljava/util/Set;)V
    .locals 3

    .line 392
    const-class v0, Lcom/unity/androidnotifications/UnityNotificationManager;

    const/4 v1, 0x0

    :try_start_0
    monitor-enter v0
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    .line 393
    :goto_0
    :try_start_1
    sget-boolean v2, Lcom/unity/androidnotifications/UnityNotificationManager;->mPerformingHousekeeping:Z

    if-eqz v2, :cond_0

    .line 394
    invoke-virtual {v0}, Ljava/lang/Object;->wait()V

    goto :goto_0

    :cond_0
    const/4 v2, 0x1

    .line 396
    sput-boolean v2, Lcom/unity/androidnotifications/UnityNotificationManager;->mPerformingHousekeeping:Z

    .line 397
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 399
    :try_start_2
    invoke-static {p0, p1}, Lcom/unity/androidnotifications/UnityNotificationManager;->performNotificationHousekeeping(Landroid/content/Context;Ljava/util/Set;)V
    :try_end_2
    .catch Ljava/lang/InterruptedException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    .line 403
    monitor-enter v0

    .line 404
    :try_start_3
    sput-boolean v1, Lcom/unity/androidnotifications/UnityNotificationManager;->mPerformingHousekeeping:Z

    .line 405
    invoke-virtual {v0}, Ljava/lang/Object;->notify()V

    .line 406
    monitor-exit v0

    goto :goto_1

    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw p0

    :catchall_1
    move-exception p0

    .line 397
    :try_start_4
    monitor-exit v0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    :try_start_5
    throw p0
    :try_end_5
    .catch Ljava/lang/InterruptedException; {:try_start_5 .. :try_end_5} :catch_0
    .catchall {:try_start_5 .. :try_end_5} :catchall_2

    :catchall_2
    move-exception p0

    goto :goto_2

    :catch_0
    :try_start_6
    const-string p0, "UnityNotifications"

    const-string p1, "Notification housekeeping interrupted"

    .line 401
    invoke-static {p0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_2

    .line 403
    monitor-enter v0

    .line 404
    :try_start_7
    sput-boolean v1, Lcom/unity/androidnotifications/UnityNotificationManager;->mPerformingHousekeeping:Z

    .line 405
    invoke-virtual {v0}, Ljava/lang/Object;->notify()V

    .line 406
    monitor-exit v0

    :goto_1
    return-void

    :catchall_3
    move-exception p0

    monitor-exit v0
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_3

    throw p0

    .line 403
    :goto_2
    monitor-enter v0

    .line 404
    :try_start_8
    sput-boolean v1, Lcom/unity/androidnotifications/UnityNotificationManager;->mPerformingHousekeeping:Z

    .line 405
    invoke-virtual {v0}, Ljava/lang/Object;->notify()V

    .line 406
    monitor-exit v0
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_4

    .line 407
    throw p0

    :catchall_4
    move-exception p0

    .line 406
    :try_start_9
    monitor-exit v0
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_4

    throw p0
.end method

.method protected static declared-synchronized loadSavedNotifications(Landroid/content/Context;)Ljava/util/List;
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")",
            "Ljava/util/List<",
            "Landroid/app/Notification$Builder;",
            ">;"
        }
    .end annotation

    const-class v0, Lcom/unity/androidnotifications/UnityNotificationManager;

    monitor-enter v0

    .line 506
    :try_start_0
    invoke-static {p0}, Lcom/unity/androidnotifications/UnityNotificationManager;->getScheduledNotificationIDs(Landroid/content/Context;)Ljava/util/Set;

    move-result-object v1

    .line 508
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .line 509
    new-instance v3, Ljava/util/HashSet;

    invoke-direct {v3}, Ljava/util/HashSet;-><init>()V

    .line 511
    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_0
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_3

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    .line 512
    invoke-static {v5}, Lcom/unity/androidnotifications/UnityNotificationManager;->getSharedPrefsNameByNotificationId(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    const/4 v7, 0x0

    invoke-virtual {p0, v6, v7}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v6

    const/4 v7, 0x0

    .line 514
    invoke-static {p0, v6}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->deserializeNotification(Landroid/content/Context;Landroid/content/SharedPreferences;)Ljava/lang/Object;

    move-result-object v6

    if-eqz v6, :cond_1

    .line 516
    instance-of v7, v6, Landroid/app/Notification$Builder;

    if-eqz v7, :cond_0

    .line 517
    move-object v7, v6

    check-cast v7, Landroid/app/Notification$Builder;

    goto :goto_1

    .line 519
    :cond_0
    check-cast v6, Landroid/app/Notification;

    invoke-static {p0, v6}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->recoverBuilder(Landroid/content/Context;Landroid/app/Notification;)Landroid/app/Notification$Builder;

    move-result-object v7

    :cond_1
    :goto_1
    if-eqz v7, :cond_2

    .line 523
    invoke-interface {v2, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 525
    :cond_2
    invoke-interface {v3, v5}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 528
    :cond_3
    invoke-interface {v3}, Ljava/util/Set;->size()I

    move-result v4

    if-lez v4, :cond_5

    .line 529
    new-instance v4, Ljava/util/HashSet;

    invoke-direct {v4, v1}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    .line 530
    invoke-interface {v3}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_2
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_4

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 531
    invoke-interface {v4, v3}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 532
    invoke-static {p0, v3}, Lcom/unity/androidnotifications/UnityNotificationManager;->deleteExpiredNotificationIntent(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_2

    .line 534
    :cond_4
    invoke-static {p0, v4}, Lcom/unity/androidnotifications/UnityNotificationManager;->saveScheduledNotificationIDs(Landroid/content/Context;Ljava/util/Set;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 537
    :cond_5
    monitor-exit v0

    return-object v2

    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method protected static notify(Landroid/content/Context;ILandroid/app/Notification;)V
    .locals 1

    .line 715
    invoke-static {p0}, Lcom/unity/androidnotifications/UnityNotificationManager;->getNotificationManager(Landroid/content/Context;)Landroid/app/NotificationManager;

    move-result-object p0

    invoke-virtual {p0, p1, p2}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    .line 716
    sget p0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v0, 0x17

    if-ge p0, v0, :cond_0

    const-class p0, Lcom/unity/androidnotifications/UnityNotificationManager;

    monitor-enter p0

    .line 717
    :try_start_0
    sget-object v0, Lcom/unity/androidnotifications/UnityNotificationManager;->mVisibleNotifications:Ljava/util/HashSet;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    .line 718
    monitor-exit p0

    goto :goto_0

    :catchall_0
    move-exception p1

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1

    .line 721
    :cond_0
    :goto_0
    :try_start_1
    sget-object p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mNotificationCallback:Lcom/unity/androidnotifications/NotificationCallback;

    invoke-interface {p0, p2}, Lcom/unity/androidnotifications/NotificationCallback;->onSentNotification(Landroid/app/Notification;)V
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1

    :catch_0
    const-string p0, "UnityNotifications"

    const-string p1, "Can not invoke OnNotificationReceived event when the app is not running!"

    .line 723
    invoke-static {p0, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :goto_1
    return-void
.end method

.method private static performNotificationHousekeeping(Landroid/content/Context;Ljava/util/Set;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    const-string v0, "UnityNotifications"

    const-string v1, "Checking for invalid notification IDs still hanging around"

    .line 413
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 415
    invoke-static {p0, p1}, Lcom/unity/androidnotifications/UnityNotificationManager;->findInvalidNotificationIds(Landroid/content/Context;Ljava/util/Set;)Ljava/util/Set;

    move-result-object p1

    .line 416
    const-class v0, Lcom/unity/androidnotifications/UnityNotificationManager;

    monitor-enter v0

    .line 418
    :try_start_0
    new-instance v1, Ljava/util/HashSet;

    invoke-static {p0}, Lcom/unity/androidnotifications/UnityNotificationManager;->getScheduledNotificationIDs(Landroid/content/Context;)Ljava/util/Set;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    .line 419
    invoke-interface {p1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 420
    invoke-interface {v1, v3}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 421
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v3

    invoke-static {v3}, Lcom/unity/androidnotifications/UnityNotificationManager;->removeScheduledNotification(Ljava/lang/Integer;)Landroid/app/Notification;

    goto :goto_0

    .line 423
    :cond_0
    invoke-static {p0, v1}, Lcom/unity/androidnotifications/UnityNotificationManager;->saveScheduledNotificationIDs(Landroid/content/Context;Ljava/util/Set;)V

    const/4 v1, 0x0

    .line 424
    sput v1, Lcom/unity/androidnotifications/UnityNotificationManager;->mSentSinceLastHousekeeping:I

    .line 425
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 428
    invoke-interface {p1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_1
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 429
    invoke-static {p0, v0}, Lcom/unity/androidnotifications/UnityNotificationManager;->deleteExpiredNotificationIntent(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_1

    :cond_1
    return-void

    :catchall_0
    move-exception p0

    .line 425
    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p0
.end method

.method private static declared-synchronized putScheduledNotification(Ljava/lang/Integer;Landroid/app/Notification;)V
    .locals 2

    const-class v0, Lcom/unity/androidnotifications/UnityNotificationManager;

    monitor-enter v0

    .line 910
    :try_start_0
    sget-object v1, Lcom/unity/androidnotifications/UnityNotificationManager;->mScheduledNotifications:Ljava/util/HashMap;

    invoke-virtual {v1, p0, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 911
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method private static declared-synchronized removeScheduledNotification(Ljava/lang/Integer;)Landroid/app/Notification;
    .locals 2

    const-class v0, Lcom/unity/androidnotifications/UnityNotificationManager;

    monitor-enter v0

    .line 918
    :try_start_0
    sget-object v1, Lcom/unity/androidnotifications/UnityNotificationManager;->mScheduledNotifications:Ljava/util/HashMap;

    invoke-virtual {v1, p0}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/app/Notification;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-object p0

    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method protected static declared-synchronized saveNotification(Landroid/content/Context;Landroid/app/Notification;)V
    .locals 4

    const-class v0, Lcom/unity/androidnotifications/UnityNotificationManager;

    monitor-enter v0

    .line 494
    :try_start_0
    iget-object v1, p1, Landroid/app/Notification;->extras:Landroid/os/Bundle;

    const-string v2, "id"

    const/4 v3, -0x1

    invoke-virtual {v1, v2, v3}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v1

    .line 495
    invoke-static {v1}, Lcom/unity/androidnotifications/UnityNotificationManager;->getSharedPrefsNameByNotificationId(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {p0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p0

    .line 496
    invoke-static {p0, p1}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->serializeNotification(Landroid/content/SharedPreferences;Landroid/app/Notification;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 497
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method private static declared-synchronized saveScheduledNotificationIDs(Landroid/content/Context;Ljava/util/Set;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    const-class v0, Lcom/unity/androidnotifications/UnityNotificationManager;

    monitor-enter v0

    :try_start_0
    const-string v1, "UNITY_STORED_NOTIFICATION_IDS"

    const/4 v2, 0x0

    .line 619
    invoke-virtual {p0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p0

    invoke-interface {p0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    invoke-interface {p0}, Landroid/content/SharedPreferences$Editor;->clear()Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    const-string v1, "UNITY_NOTIFICATION_IDS"

    .line 620
    invoke-interface {p0, v1, p1}, Landroid/content/SharedPreferences$Editor;->putStringSet(Ljava/lang/String;Ljava/util/Set;)Landroid/content/SharedPreferences$Editor;

    .line 621
    invoke-interface {p0}, Landroid/content/SharedPreferences$Editor;->apply()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 622
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method static scheduleAlarmWithNotification(Landroid/content/Context;Ljava/lang/Class;Landroid/app/Notification$Builder;Landroid/content/Intent;J)Landroid/app/Notification;
    .locals 12

    move-object v0, p3

    .line 296
    invoke-virtual {p2}, Landroid/app/Notification$Builder;->getExtras()Landroid/os/Bundle;

    move-result-object v1

    const-string v2, "id"

    const/4 v3, -0x1

    .line 297
    invoke-virtual {v1, v2, v3}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v2

    const-string v3, "repeatInterval"

    const-wide/16 v4, -0x1

    .line 298
    invoke-virtual {v1, v3, v4, v5}, Landroid/os/Bundle;->getLong(Ljava/lang/String;J)J

    move-result-wide v7

    .line 301
    invoke-static {p0, p1, p2}, Lcom/unity/androidnotifications/UnityNotificationManager;->buildNotificationForSending(Landroid/content/Context;Ljava/lang/Class;Landroid/app/Notification$Builder;)Landroid/app/Notification;

    move-result-object v1

    .line 302
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-static {v3, v1}, Lcom/unity/androidnotifications/UnityNotificationManager;->putScheduledNotification(Ljava/lang/Integer;Landroid/app/Notification;)V

    const-string v3, "com.unity.NotificationID"

    .line 303
    invoke-virtual {p3, v3, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const/high16 v3, 0x8000000

    move-object v4, p0

    .line 305
    invoke-static {p0, v2, p3, v3}, Lcom/unity/androidnotifications/UnityNotificationManager;->getBroadcastPendingIntent(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v11

    move-object v6, p0

    move-wide/from16 v9, p4

    .line 306
    invoke-static/range {v6 .. v11}, Lcom/unity/androidnotifications/UnityNotificationManager;->scheduleNotificationIntentAlarm(Landroid/content/Context;JJLandroid/app/PendingIntent;)V

    return-object v1
.end method

.method static scheduleAlarmWithNotification(Landroid/app/Notification$Builder;Landroid/content/Context;)V
    .locals 10

    .line 311
    invoke-virtual {p0}, Landroid/app/Notification$Builder;->getExtras()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "fireTime"

    const-wide/16 v2, 0x0

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Bundle;->getLong(Ljava/lang/String;J)J

    move-result-wide v8

    .line 312
    invoke-static {p1}, Lcom/unity/androidnotifications/UnityNotificationManager;->buildNotificationIntent(Landroid/content/Context;)Landroid/content/Intent;

    move-result-object v7

    .line 315
    sget-object v0, Lcom/unity/androidnotifications/UnityNotificationManager;->mUnityNotificationManager:Lcom/unity/androidnotifications/UnityNotificationManager;

    if-eqz v0, :cond_0

    iget-object v0, v0, Lcom/unity/androidnotifications/UnityNotificationManager;->mOpenActivity:Ljava/lang/Class;

    if-nez v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    .line 316
    invoke-static {p1, v0}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->getOpenAppActivity(Landroid/content/Context;Z)Ljava/lang/Class;

    move-result-object v0

    :cond_1
    move-object v5, v0

    move-object v4, p1

    move-object v6, p0

    .line 322
    invoke-static/range {v4 .. v9}, Lcom/unity/androidnotifications/UnityNotificationManager;->scheduleAlarmWithNotification(Landroid/content/Context;Ljava/lang/Class;Landroid/app/Notification$Builder;Landroid/content/Intent;J)Landroid/app/Notification;

    return-void
.end method

.method private static declared-synchronized scheduleHousekeeping(Landroid/content/Context;Ljava/util/Set;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    const-class v0, Lcom/unity/androidnotifications/UnityNotificationManager;

    monitor-enter v0

    .line 374
    :try_start_0
    sget v1, Lcom/unity/androidnotifications/UnityNotificationManager;->mSentSinceLastHousekeeping:I

    add-int/lit8 v1, v1, 0x1

    sput v1, Lcom/unity/androidnotifications/UnityNotificationManager;->mSentSinceLastHousekeeping:I

    const/16 v2, 0x32

    if-le v1, v2, :cond_0

    const/4 v1, 0x0

    .line 376
    sput v1, Lcom/unity/androidnotifications/UnityNotificationManager;->mSentSinceLastHousekeeping:I

    .line 377
    invoke-static {p0, p1}, Lcom/unity/androidnotifications/UnityNotificationManager;->triggerHousekeeping(Landroid/content/Context;Ljava/util/Set;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 379
    :cond_0
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method protected static scheduleNotificationIntentAlarm(Landroid/content/Context;JJLandroid/app/PendingIntent;)V
    .locals 7

    const-string v0, "alarm"

    .line 553
    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    move-object v0, p0

    check-cast v0, Landroid/app/AlarmManager;

    const-wide/16 v1, 0x0

    cmp-long p0, p1, v1

    if-gtz p0, :cond_1

    .line 556
    sget p0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 p1, 0x17

    const/4 p2, 0x0

    if-lt p0, p1, :cond_0

    invoke-static {v0}, Lcom/unity/androidnotifications/UnityNotificationManager;->canScheduleExactAlarms(Landroid/app/AlarmManager;)Z

    move-result p0

    if-eqz p0, :cond_0

    .line 557
    invoke-virtual {v0, p2, p3, p4, p5}, Landroid/app/AlarmManager;->setExactAndAllowWhileIdle(IJLandroid/app/PendingIntent;)V

    goto :goto_0

    .line 559
    :cond_0
    invoke-virtual {v0, p2, p3, p4, p5}, Landroid/app/AlarmManager;->set(IJLandroid/app/PendingIntent;)V

    goto :goto_0

    :cond_1
    const/4 v1, 0x0

    move-wide v2, p3

    move-wide v4, p1

    move-object v6, p5

    .line 562
    invoke-virtual/range {v0 .. v6}, Landroid/app/AlarmManager;->setInexactRepeating(IJJLandroid/app/PendingIntent;)V

    :goto_0
    return-void
.end method

.method public static setNotificationColor(Landroid/app/Notification$Builder;I)V
    .locals 2

    .line 816
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x15

    if-lt v0, v1, :cond_0

    if-eqz p1, :cond_0

    .line 818
    invoke-virtual {p0, p1}, Landroid/app/Notification$Builder;->setColor(I)Landroid/app/Notification$Builder;

    .line 819
    sget p1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v0, 0x1a

    if-lt p1, v0, :cond_0

    const/4 p1, 0x1

    .line 820
    invoke-virtual {p0, p1}, Landroid/app/Notification$Builder;->setColorized(Z)Landroid/app/Notification$Builder;

    :cond_0
    return-void
.end method

.method public static setNotificationGroupAlertBehavior(Landroid/app/Notification$Builder;I)V
    .locals 2

    .line 832
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-lt v0, v1, :cond_0

    .line 833
    invoke-virtual {p0, p1}, Landroid/app/Notification$Builder;->setGroupAlertBehavior(I)Landroid/app/Notification$Builder;

    :cond_0
    return-void
.end method

.method public static setNotificationIcon(Landroid/app/Notification$Builder;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    if-eqz p2, :cond_1

    .line 809
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p0}, Landroid/app/Notification$Builder;->getExtras()Landroid/os/Bundle;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 812
    :cond_0
    invoke-virtual {p0}, Landroid/app/Notification$Builder;->getExtras()Landroid/os/Bundle;

    move-result-object p0

    invoke-virtual {p0, p1, p2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1

    .line 810
    :cond_1
    :goto_0
    invoke-virtual {p0}, Landroid/app/Notification$Builder;->getExtras()Landroid/os/Bundle;

    move-result-object p0

    invoke-virtual {p0, p1}, Landroid/os/Bundle;->remove(Ljava/lang/String;)V

    :goto_1
    return-void
.end method

.method public static setNotificationUsesChronometer(Landroid/app/Notification$Builder;Z)V
    .locals 2

    .line 827
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x16

    if-lt v0, v1, :cond_0

    .line 828
    invoke-virtual {p0, p1}, Landroid/app/Notification$Builder;->setUsesChronometer(Z)Landroid/app/Notification$Builder;

    :cond_0
    return-void
.end method

.method private static declared-synchronized triggerHousekeeping(Landroid/content/Context;Ljava/util/Set;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    const-class v0, Lcom/unity/androidnotifications/UnityNotificationManager;

    monitor-enter v0

    if-nez p1, :cond_0

    .line 383
    :try_start_0
    invoke-static {p0}, Lcom/unity/androidnotifications/UnityNotificationManager;->getScheduledNotificationIDs(Landroid/content/Context;)Ljava/util/Set;

    move-result-object p1

    .line 388
    :cond_0
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/unity/androidnotifications/-$$Lambda$UnityNotificationManager$fSttc7CuZmP-kDH-q_FquZSJ7Yk;

    invoke-direct {v2, p0, p1}, Lcom/unity/androidnotifications/-$$Lambda$UnityNotificationManager$fSttc7CuZmP-kDH-q_FquZSJ7Yk;-><init>(Landroid/content/Context;Ljava/util/Set;)V

    invoke-direct {v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 409
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 410
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method


# virtual methods
.method public cancelAllNotifications()V
    .locals 1

    .line 659
    invoke-virtual {p0}, Lcom/unity/androidnotifications/UnityNotificationManager;->getNotificationManager()Landroid/app/NotificationManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/NotificationManager;->cancelAll()V

    return-void
.end method

.method public cancelAllPendingNotificationIntents()V
    .locals 4

    .line 595
    const-class v0, Lcom/unity/androidnotifications/UnityNotificationManager;

    monitor-enter v0

    .line 596
    :try_start_0
    iget-object v1, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mContext:Landroid/content/Context;

    invoke-static {v1}, Lcom/unity/androidnotifications/UnityNotificationManager;->getScheduledNotificationIDs(Landroid/content/Context;)Ljava/util/Set;

    move-result-object v1

    .line 597
    iget-object v2, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mContext:Landroid/content/Context;

    new-instance v3, Ljava/util/HashSet;

    invoke-direct {v3}, Ljava/util/HashSet;-><init>()V

    invoke-static {v2, v3}, Lcom/unity/androidnotifications/UnityNotificationManager;->saveScheduledNotificationIDs(Landroid/content/Context;Ljava/util/Set;)V

    .line 598
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 600
    invoke-interface {v1}, Ljava/util/Set;->size()I

    move-result v0

    if-lez v0, :cond_0

    .line 601
    iget-object v0, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mContext:Landroid/content/Context;

    .line 602
    new-instance v2, Ljava/lang/Thread;

    new-instance v3, Lcom/unity/androidnotifications/-$$Lambda$UnityNotificationManager$OE4cG-d0jzV4gLmaKMvhpuUAJlI;

    invoke-direct {v3, v1, v0}, Lcom/unity/androidnotifications/-$$Lambda$UnityNotificationManager$OE4cG-d0jzV4gLmaKMvhpuUAJlI;-><init>(Ljava/util/Set;Landroid/content/Context;)V

    invoke-direct {v2, v3}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 608
    invoke-virtual {v2}, Ljava/lang/Thread;->start()V

    :cond_0
    return-void

    :catchall_0
    move-exception v1

    .line 598
    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method

.method public cancelDisplayedNotification(I)V
    .locals 1

    .line 654
    invoke-virtual {p0}, Lcom/unity/androidnotifications/UnityNotificationManager;->getNotificationManager()Landroid/app/NotificationManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/app/NotificationManager;->cancel(I)V

    return-void
.end method

.method public cancelPendingNotification(I)V
    .locals 2

    .line 626
    const-class v0, Lcom/unity/androidnotifications/UnityNotificationManager;

    monitor-enter v0

    .line 627
    :try_start_0
    iget-object v1, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mContext:Landroid/content/Context;

    invoke-static {v1, p1}, Lcom/unity/androidnotifications/UnityNotificationManager;->cancelPendingNotificationIntent(Landroid/content/Context;I)V

    .line 628
    iget-object p1, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mContext:Landroid/content/Context;

    const/4 v1, 0x0

    invoke-static {p1, v1}, Lcom/unity/androidnotifications/UnityNotificationManager;->triggerHousekeeping(Landroid/content/Context;Ljava/util/Set;)V

    .line 629
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1
.end method

.method public checkIfPendingNotificationIsRegistered(I)Z
    .locals 3

    .line 588
    new-instance v0, Landroid/content/Intent;

    iget-object v1, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mActivity:Landroid/app/Activity;

    const-class v2, Lcom/unity/androidnotifications/UnityNotificationManager;

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 589
    iget-object v1, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mContext:Landroid/content/Context;

    const/high16 v2, 0x20000000

    invoke-static {v1, p1, v0, v2}, Lcom/unity/androidnotifications/UnityNotificationManager;->getBroadcastPendingIntent(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object p1

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    return p1
.end method

.method public checkNotificationStatus(I)I
    .locals 6

    .line 568
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/4 v1, 0x2

    const/4 v2, 0x0

    const/16 v3, 0x17

    if-lt v0, v3, :cond_1

    .line 569
    invoke-virtual {p0}, Lcom/unity/androidnotifications/UnityNotificationManager;->getNotificationManager()Landroid/app/NotificationManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/NotificationManager;->getActiveNotifications()[Landroid/service/notification/StatusBarNotification;

    move-result-object v0

    array-length v3, v0

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v3, :cond_4

    aget-object v5, v0, v4

    .line 570
    invoke-virtual {v5}, Landroid/service/notification/StatusBarNotification;->getId()I

    move-result v5

    if-ne p1, v5, :cond_0

    return v1

    :cond_0
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 573
    :cond_1
    const-class v0, Lcom/unity/androidnotifications/UnityNotificationManager;

    monitor-enter v0

    .line 574
    :try_start_0
    sget-object v3, Lcom/unity/androidnotifications/UnityNotificationManager;->mVisibleNotifications:Ljava/util/HashSet;

    invoke-virtual {v3}, Ljava/util/HashSet;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_2
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_3

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Integer;

    .line 575
    invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I

    move-result v4

    if-ne v4, p1, :cond_2

    .line 576
    monitor-exit v0

    return v1

    .line 578
    :cond_3
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 580
    :cond_4
    invoke-virtual {p0, p1}, Lcom/unity/androidnotifications/UnityNotificationManager;->checkIfPendingNotificationIsRegistered(I)Z

    move-result p1

    if-eqz p1, :cond_5

    const/4 p1, 0x1

    return p1

    :cond_5
    return v2

    :catchall_0
    move-exception p1

    .line 578
    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method

.method public createNotificationBuilder(Ljava/lang/String;)Landroid/app/Notification$Builder;
    .locals 1

    .line 759
    iget-object v0, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mContext:Landroid/content/Context;

    invoke-static {v0, p1}, Lcom/unity/androidnotifications/UnityNotificationManager;->createNotificationBuilder(Landroid/content/Context;Ljava/lang/String;)Landroid/app/Notification$Builder;

    move-result-object p1

    return-object p1
.end method

.method public deleteNotificationChannel(Ljava/lang/String;)V
    .locals 5

    .line 228
    iget-object v0, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mContext:Landroid/content/Context;

    const-string v1, "UNITY_NOTIFICATIONS"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 229
    new-instance v1, Ljava/util/HashSet;

    new-instance v3, Ljava/util/HashSet;

    invoke-direct {v3}, Ljava/util/HashSet;-><init>()V

    const-string v4, "ChannelIDs"

    invoke-interface {v0, v4, v3}, Landroid/content/SharedPreferences;->getStringSet(Ljava/lang/String;Ljava/util/Set;)Ljava/util/Set;

    move-result-object v3

    invoke-direct {v1, v3}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    .line 231
    invoke-interface {v1, p1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_0

    return-void

    .line 235
    :cond_0
    invoke-interface {v1, p1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 236
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->clear()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 237
    invoke-interface {v0, v4, v1}, Landroid/content/SharedPreferences$Editor;->putStringSet(Ljava/lang/String;Ljava/util/Set;)Landroid/content/SharedPreferences$Editor;

    .line 238
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 241
    iget-object v0, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mContext:Landroid/content/Context;

    invoke-static {p1}, Lcom/unity/androidnotifications/UnityNotificationManager;->getSharedPrefsNameByChannelId(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    .line 242
    invoke-interface {p1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->clear()Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method

.method protected getNotificationChannel(Ljava/lang/String;)Lcom/unity/androidnotifications/NotificationChannelWrapper;
    .locals 1

    .line 222
    iget-object v0, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mContext:Landroid/content/Context;

    invoke-static {v0, p1}, Lcom/unity/androidnotifications/UnityNotificationManager;->getNotificationChannel(Landroid/content/Context;Ljava/lang/String;)Lcom/unity/androidnotifications/NotificationChannelWrapper;

    move-result-object p1

    return-object p1
.end method

.method public getNotificationChannels()[Ljava/lang/Object;
    .locals 3

    .line 248
    iget-object v0, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mContext:Landroid/content/Context;

    const-string v1, "UNITY_NOTIFICATIONS"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 249
    new-instance v1, Ljava/util/HashSet;

    invoke-direct {v1}, Ljava/util/HashSet;-><init>()V

    const-string v2, "ChannelIDs"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences;->getStringSet(Ljava/lang/String;Ljava/util/Set;)Ljava/util/Set;

    move-result-object v0

    .line 251
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 253
    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 254
    invoke-virtual {p0, v2}, Lcom/unity/androidnotifications/UnityNotificationManager;->getNotificationChannel(Ljava/lang/String;)Lcom/unity/androidnotifications/NotificationChannelWrapper;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 256
    :cond_0
    invoke-virtual {v1}, Ljava/util/ArrayList;->toArray()[Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public getNotificationManager()Landroid/app/NotificationManager;
    .locals 1

    .line 125
    iget-object v0, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mContext:Landroid/content/Context;

    invoke-static {v0}, Lcom/unity/androidnotifications/UnityNotificationManager;->getNotificationManager(Landroid/content/Context;)Landroid/app/NotificationManager;

    move-result-object v0

    return-object v0
.end method

.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 4

    .line 665
    :try_start_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x17

    const/4 v2, -0x1

    if-ge v0, v1, :cond_1

    const-string v0, "com.unity.NotificationDismissed"

    .line 666
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string p1, "com.unity.NotificationDismissed"

    .line 667
    invoke-virtual {p2, p1, v2}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result p1

    if-lez p1, :cond_0

    .line 668
    const-class p2, Lcom/unity/androidnotifications/UnityNotificationManager;

    monitor-enter p2
    :try_end_0
    .catch Landroid/os/BadParcelableException; {:try_start_0 .. :try_end_0} :catch_0

    .line 669
    :try_start_1
    sget-object v0, Lcom/unity/androidnotifications/UnityNotificationManager;->mVisibleNotifications:Ljava/util/HashSet;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/util/HashSet;->remove(Ljava/lang/Object;)Z

    .line 670
    monitor-exit p2

    goto :goto_0

    :catchall_0
    move-exception p1

    monitor-exit p2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw p1

    :cond_0
    :goto_0
    return-void

    .line 674
    :cond_1
    invoke-static {p1, p2}, Lcom/unity/androidnotifications/UnityNotificationManager;->getNotificationOrBuilderForIntent(Landroid/content/Context;Landroid/content/Intent;)Ljava/lang/Object;

    move-result-object p2

    if-eqz p2, :cond_6

    .line 678
    instance-of v0, p2, Landroid/app/Notification;

    if-eqz v0, :cond_2

    .line 680
    check-cast p2, Landroid/app/Notification;

    .line 681
    iget-object v0, p2, Landroid/app/Notification;->extras:Landroid/os/Bundle;

    const-string v1, "id"

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v0

    goto :goto_3

    .line 683
    :cond_2
    check-cast p2, Landroid/app/Notification$Builder;

    if-nez p2, :cond_3

    const-string p1, "UnityNotifications"

    const-string p2, "Failed to recover builder, can\'t send notification"

    .line 686
    invoke-static {p1, p2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    .line 691
    :cond_3
    sget-object v0, Lcom/unity/androidnotifications/UnityNotificationManager;->mUnityNotificationManager:Lcom/unity/androidnotifications/UnityNotificationManager;

    if-eqz v0, :cond_5

    sget-object v0, Lcom/unity/androidnotifications/UnityNotificationManager;->mUnityNotificationManager:Lcom/unity/androidnotifications/UnityNotificationManager;

    iget-object v0, v0, Lcom/unity/androidnotifications/UnityNotificationManager;->mOpenActivity:Ljava/lang/Class;

    if-nez v0, :cond_4

    goto :goto_1

    .line 695
    :cond_4
    sget-object v0, Lcom/unity/androidnotifications/UnityNotificationManager;->mUnityNotificationManager:Lcom/unity/androidnotifications/UnityNotificationManager;

    iget-object v0, v0, Lcom/unity/androidnotifications/UnityNotificationManager;->mOpenActivity:Ljava/lang/Class;

    goto :goto_2

    :cond_5
    :goto_1
    const/4 v0, 0x1

    .line 692
    invoke-static {p1, v0}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->getOpenAppActivity(Landroid/content/Context;Z)Ljava/lang/Class;

    move-result-object v0

    .line 698
    :goto_2
    invoke-virtual {p2}, Landroid/app/Notification$Builder;->getExtras()Landroid/os/Bundle;

    move-result-object v1

    const-string v3, "com.unity.NotificationID"

    invoke-virtual {v1, v3, v2}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v1

    .line 699
    invoke-static {p1, v0, p2}, Lcom/unity/androidnotifications/UnityNotificationManager;->buildNotificationForSending(Landroid/content/Context;Ljava/lang/Class;Landroid/app/Notification$Builder;)Landroid/app/Notification;

    move-result-object p2

    .line 701
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-static {v0, p2}, Lcom/unity/androidnotifications/UnityNotificationManager;->putScheduledNotification(Ljava/lang/Integer;Landroid/app/Notification;)V

    move v0, v1

    :goto_3
    if-eqz p2, :cond_6

    .line 705
    invoke-static {p1, v0, p2}, Lcom/unity/androidnotifications/UnityNotificationManager;->notify(Landroid/content/Context;ILandroid/app/Notification;)V
    :try_end_2
    .catch Landroid/os/BadParcelableException; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_4

    :catch_0
    move-exception p1

    const-string p2, "UnityNotifications"

    .line 709
    invoke-virtual {p1}, Landroid/os/BadParcelableException;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p2, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :cond_6
    :goto_4
    return-void
.end method

.method public registerNotificationChannel(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;ZZZZ[JI)V
    .locals 5

    .line 151
    iget-object v0, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mContext:Landroid/content/Context;

    const-string v1, "UNITY_NOTIFICATIONS"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 152
    new-instance v1, Ljava/util/HashSet;

    new-instance v3, Ljava/util/HashSet;

    invoke-direct {v3}, Ljava/util/HashSet;-><init>()V

    const-string v4, "ChannelIDs"

    invoke-interface {v0, v4, v3}, Landroid/content/SharedPreferences;->getStringSet(Ljava/lang/String;Ljava/util/Set;)Ljava/util/Set;

    move-result-object v3

    invoke-direct {v1, v3}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    .line 153
    invoke-interface {v1, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 156
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->clear()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 157
    invoke-interface {v0, v4, v1}, Landroid/content/SharedPreferences$Editor;->putStringSet(Ljava/lang/String;Ljava/util/Set;)Landroid/content/SharedPreferences$Editor;

    .line 158
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 161
    iget-object v0, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mContext:Landroid/content/Context;

    invoke-static {p1}, Lcom/unity/androidnotifications/UnityNotificationManager;->getSharedPrefsNameByChannelId(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    .line 162
    invoke-interface {p1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    const-string v0, "title"

    .line 164
    invoke-interface {p1, v0, p2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    const-string p2, "importance"

    .line 165
    invoke-interface {p1, p2, p3}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    const-string p2, "description"

    .line 166
    invoke-interface {p1, p2, p4}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    const-string p2, "enableLights"

    .line 167
    invoke-interface {p1, p2, p5}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    const-string p2, "enableVibration"

    .line 168
    invoke-interface {p1, p2, p6}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    const-string p2, "canBypassDnd"

    .line 169
    invoke-interface {p1, p2, p7}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    const-string p2, "canShowBadge"

    .line 170
    invoke-interface {p1, p2, p8}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    .line 171
    invoke-static {p9}, Ljava/util/Arrays;->toString([J)Ljava/lang/String;

    move-result-object p2

    const-string p3, "vibrationPattern"

    invoke-interface {p1, p3, p2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    const-string p2, "lockscreenVisibility"

    .line 172
    invoke-interface {p1, p2, p10}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    .line 174
    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method

.method scheduleAlarmWithNotification(Landroid/app/Notification$Builder;Landroid/content/Intent;J)Landroid/app/Notification;
    .locals 6

    .line 292
    iget-object v0, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mOpenActivity:Ljava/lang/Class;

    move-object v2, p1

    move-object v3, p2

    move-wide v4, p3

    invoke-static/range {v0 .. v5}, Lcom/unity/androidnotifications/UnityNotificationManager;->scheduleAlarmWithNotification(Landroid/content/Context;Ljava/lang/Class;Landroid/app/Notification$Builder;Landroid/content/Intent;J)Landroid/app/Notification;

    move-result-object p1

    return-object p1
.end method

.method public scheduleNotification(Landroid/app/Notification$Builder;)V
    .locals 11

    .line 261
    invoke-virtual {p1}, Landroid/app/Notification$Builder;->getExtras()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "id"

    const/4 v2, -0x1

    .line 262
    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v1

    const-string v2, "repeatInterval"

    const-wide/16 v3, -0x1

    .line 263
    invoke-virtual {v0, v2, v3, v4}, Landroid/os/Bundle;->getLong(Ljava/lang/String;J)J

    move-result-wide v5

    const-string v2, "fireTime"

    .line 264
    invoke-virtual {v0, v2, v3, v4}, Landroid/os/Bundle;->getLong(Ljava/lang/String;J)J

    move-result-wide v2

    .line 268
    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Calendar;->getTime()Ljava/util/Date;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Date;->getTime()J

    move-result-wide v7

    sub-long v7, v2, v7

    const-wide/16 v9, 0x3e8

    cmp-long v0, v7, v9

    if-gez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    if-eqz v0, :cond_1

    const-wide/16 v7, 0x0

    cmp-long v4, v5, v7

    if-lez v4, :cond_3

    :cond_1
    if-eqz v0, :cond_2

    add-long/2addr v2, v5

    .line 275
    :cond_2
    iget-object v4, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mContext:Landroid/content/Context;

    invoke-static {v4, v1}, Lcom/unity/androidnotifications/UnityNotificationManager;->buildNotificationIntentUpdateList(Landroid/content/Context;I)Landroid/content/Intent;

    move-result-object v4

    if-eqz v4, :cond_3

    .line 278
    iget-object v5, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mContext:Landroid/content/Context;

    invoke-virtual {p1}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/unity/androidnotifications/UnityNotificationManager;->saveNotification(Landroid/content/Context;Landroid/app/Notification;)V

    .line 279
    invoke-virtual {p0, p1, v4, v2, v3}, Lcom/unity/androidnotifications/UnityNotificationManager;->scheduleAlarmWithNotification(Landroid/app/Notification$Builder;Landroid/content/Intent;J)Landroid/app/Notification;

    move-result-object v2

    goto :goto_1

    :cond_3
    const/4 v2, 0x0

    :goto_1
    if-eqz v0, :cond_5

    if-nez v2, :cond_4

    .line 285
    iget-object v0, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mContext:Landroid/content/Context;

    iget-object v2, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mOpenActivity:Ljava/lang/Class;

    invoke-static {v0, v2, p1}, Lcom/unity/androidnotifications/UnityNotificationManager;->buildNotificationForSending(Landroid/content/Context;Ljava/lang/Class;Landroid/app/Notification$Builder;)Landroid/app/Notification;

    move-result-object v2

    .line 287
    :cond_4
    iget-object p1, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mContext:Landroid/content/Context;

    invoke-static {p1, v1, v2}, Lcom/unity/androidnotifications/UnityNotificationManager;->notify(Landroid/content/Context;ILandroid/app/Notification;)V

    :cond_5
    return-void
.end method

.method public setNotificationCallback(Lcom/unity/androidnotifications/NotificationCallback;)V
    .locals 0

    .line 135
    sput-object p1, Lcom/unity/androidnotifications/UnityNotificationManager;->mNotificationCallback:Lcom/unity/androidnotifications/NotificationCallback;

    return-void
.end method

.method public showNotificationSettings(Ljava/lang/String;)V
    .locals 3

    .line 890
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-ge v0, v1, :cond_0

    .line 891
    new-instance p1, Landroid/content/Intent;

    const-string v0, "android.settings.APPLICATION_DETAILS_SETTINGS"

    invoke-direct {p1, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 892
    iget-object v0, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    const-string v2, "package"

    invoke-static {v2, v0, v1}, Landroid/net/Uri;->fromParts(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    .line 893
    invoke-virtual {p1, v0}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    goto :goto_1

    :cond_0
    if-eqz p1, :cond_1

    .line 895
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_1

    .line 896
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.settings.CHANNEL_NOTIFICATION_SETTINGS"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const-string v1, "android.provider.extra.CHANNEL_ID"

    .line 897
    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-object p1, v0

    goto :goto_0

    .line 899
    :cond_1
    new-instance p1, Landroid/content/Intent;

    const-string v0, "android.settings.APP_NOTIFICATION_SETTINGS"

    invoke-direct {p1, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 902
    :goto_0
    iget-object v0, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    const-string v1, "android.provider.extra.APP_PACKAGE"

    invoke-virtual {p1, v1, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    :goto_1
    const/high16 v0, 0x10000000

    .line 905
    invoke-virtual {p1, v0}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 906
    iget-object v0, p0, Lcom/unity/androidnotifications/UnityNotificationManager;->mActivity:Landroid/app/Activity;

    invoke-virtual {v0, p1}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V

    return-void
.end method
