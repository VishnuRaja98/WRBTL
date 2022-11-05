.class public Lcom/unity/androidnotifications/UnityNotificationUtilities;
.super Ljava/lang/Object;
.source "UnityNotificationUtilities.java"


# static fields
.field private static final INTENT_SERIALIZATION_VERSION:I = 0x0

.field private static final NOTIFICATION_SERIALIZATION_VERSION:I = 0x0

.field private static final SAVED_NOTIFICATION_FALLBACK_KEY:Ljava/lang/String; = "fallback.data"

.field private static final SAVED_NOTIFICATION_PRIMARY_KEY:Ljava/lang/String; = "data"

.field private static final UNITY_MAGIC_NUMBER:[B

.field private static final UNITY_MAGIC_NUMBER_PARCELLED:[B


# direct methods
.method static constructor <clinit>()V
    .locals 2

    const/4 v0, 0x4

    new-array v1, v0, [B

    .line 36
    fill-array-data v1, :array_0

    sput-object v1, Lcom/unity/androidnotifications/UnityNotificationUtilities;->UNITY_MAGIC_NUMBER:[B

    new-array v0, v0, [B

    .line 37
    fill-array-data v0, :array_1

    sput-object v0, Lcom/unity/androidnotifications/UnityNotificationUtilities;->UNITY_MAGIC_NUMBER_PARCELLED:[B

    return-void

    :array_0
    .array-data 1
        0x55t
        0x4dt
        0x4et
        0x4et
    .end array-data

    :array_1
    .array-data 1
        0x55t
        0x4dt
        0x4et
        0x50t
    .end array-data
.end method

.method public constructor <init>()V
    .locals 0

    .line 34
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method protected static deserializeNotification(Landroid/content/Context;Landroid/content/SharedPreferences;)Ljava/lang/Object;
    .locals 4

    const-string v0, "data"

    const-string v1, ""

    .line 199
    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const/4 v2, 0x0

    if-eqz v0, :cond_3

    .line 200
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v3

    if-gtz v3, :cond_0

    goto :goto_0

    :cond_0
    const/4 v3, 0x0

    .line 202
    invoke-static {v0, v3}, Landroid/util/Base64;->decode(Ljava/lang/String;I)[B

    move-result-object v0

    .line 203
    invoke-static {p0, v0}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->deserializeNotification(Landroid/content/Context;[B)Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_1

    return-object v0

    :cond_1
    const-string v0, "fallback.data"

    .line 206
    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_3

    .line 207
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-gtz v0, :cond_2

    goto :goto_0

    .line 209
    :cond_2
    invoke-static {p1, v3}, Landroid/util/Base64;->decode(Ljava/lang/String;I)[B

    move-result-object p1

    .line 210
    invoke-static {p0, p1}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->deserializeNotification(Landroid/content/Context;[B)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    :cond_3
    :goto_0
    return-object v2
.end method

.method private static deserializeNotification(Landroid/content/Context;[B)Ljava/lang/Object;
    .locals 2

    .line 217
    new-instance p0, Ljava/io/ByteArrayInputStream;

    invoke-direct {p0, p1}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    .line 218
    new-instance v0, Ljava/io/DataInputStream;

    invoke-direct {v0, p0}, Ljava/io/DataInputStream;-><init>(Ljava/io/InputStream;)V

    .line 219
    invoke-static {v0}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->deserializeNotificationParcelable(Ljava/io/DataInputStream;)Landroid/app/Notification;

    move-result-object v1

    if-eqz v1, :cond_0

    return-object v1

    .line 222
    :cond_0
    invoke-virtual {p0}, Ljava/io/ByteArrayInputStream;->reset()V

    .line 223
    invoke-static {v0}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->deserializeNotificationCustom(Ljava/io/DataInputStream;)Landroid/app/Notification$Builder;

    move-result-object p0

    if-nez p0, :cond_1

    .line 225
    invoke-static {p1}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->deserializedFromOldIntent([B)Landroid/app/Notification$Builder;

    move-result-object p0

    :cond_1
    return-object p0
.end method

.method private static deserializeNotificationCustom(Ljava/io/DataInputStream;)Landroid/app/Notification$Builder;
    .locals 39

    const-string v1, "Failed to deserialize notification"

    const-string v2, "UnityNotifications"

    const/4 v3, 0x0

    .line 268
    :try_start_0
    sget-object v0, Lcom/unity/androidnotifications/UnityNotificationUtilities;->UNITY_MAGIC_NUMBER:[B

    move-object/from16 v4, p0

    invoke-static {v4, v0}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->readAndCheckMagicNumber(Ljava/io/DataInputStream;[B)Z

    move-result v0

    if-nez v0, :cond_0

    return-object v3

    .line 270
    :cond_0
    invoke-virtual/range {p0 .. p0}, Ljava/io/DataInputStream;->readInt()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/lang/OutOfMemoryError; {:try_start_0 .. :try_end_0} :catch_3

    if-ltz v0, :cond_12

    if-lez v0, :cond_1

    goto/16 :goto_6

    .line 281
    :cond_1
    :try_start_1
    invoke-static/range {p0 .. p0}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->deserializeParcelable(Ljava/io/DataInputStream;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Landroid/os/Bundle;
    :try_end_1
    .catch Ljava/lang/ClassCastException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_4
    .catch Ljava/lang/OutOfMemoryError; {:try_start_1 .. :try_end_1} :catch_3

    goto :goto_0

    :catch_0
    move-exception v0

    :try_start_2
    const-string v5, "Unexpect type of deserialized object"

    .line 283
    invoke-static {v2, v5, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_4
    .catch Ljava/lang/OutOfMemoryError; {:try_start_2 .. :try_end_2} :catch_3

    move-object v0, v3

    :goto_0
    const-string v5, "data"

    const-string v6, "repeatInterval"

    const-string v7, "fireTime"

    const-string v8, "largeIcon"

    const-string v9, "smallIcon"

    const-wide/16 v10, -0x1

    const/4 v12, 0x0

    if-nez v0, :cond_2

    .line 288
    :try_start_3
    invoke-virtual/range {p0 .. p0}, Ljava/io/DataInputStream;->readInt()I

    move-result v13

    .line 289
    invoke-static/range {p0 .. p0}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->deserializeString(Ljava/io/DataInputStream;)Ljava/lang/String;

    move-result-object v14

    .line 290
    invoke-static/range {p0 .. p0}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->deserializeString(Ljava/io/DataInputStream;)Ljava/lang/String;

    move-result-object v15

    .line 291
    invoke-static/range {p0 .. p0}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->deserializeString(Ljava/io/DataInputStream;)Ljava/lang/String;

    move-result-object v16

    .line 292
    invoke-static/range {p0 .. p0}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->deserializeString(Ljava/io/DataInputStream;)Ljava/lang/String;

    move-result-object v17

    .line 293
    invoke-virtual/range {p0 .. p0}, Ljava/io/DataInputStream;->readLong()J

    move-result-wide v18

    .line 294
    invoke-virtual/range {p0 .. p0}, Ljava/io/DataInputStream;->readLong()J

    move-result-wide v20

    .line 295
    invoke-static/range {p0 .. p0}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->deserializeString(Ljava/io/DataInputStream;)Ljava/lang/String;

    move-result-object v22

    .line 296
    invoke-virtual/range {p0 .. p0}, Ljava/io/DataInputStream;->readBoolean()Z

    move-result v23

    .line 297
    invoke-virtual/range {p0 .. p0}, Ljava/io/DataInputStream;->readBoolean()Z

    move-result v24

    .line 298
    invoke-static/range {p0 .. p0}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->deserializeString(Ljava/io/DataInputStream;)Ljava/lang/String;

    move-result-object v25

    move-object/from16 v3, v16

    move-object/from16 v12, v17

    move-wide/from16 v10, v18

    move/from16 v26, v23

    move-object/from16 v4, v25

    move-object/from16 v19, v1

    move-object/from16 v23, v15

    move-wide/from16 v37, v20

    move-object/from16 v20, v2

    move-wide/from16 v1, v37

    move-object/from16 v21, v22

    goto :goto_2

    :cond_2
    const-string v13, "android.title"

    .line 300
    invoke-virtual {v0, v13}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    const-string v13, "android.text"

    .line 301
    invoke-virtual {v0, v13}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v15

    .line 302
    invoke-virtual {v0, v9}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v16

    .line 303
    invoke-virtual {v0, v8}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v17

    .line 304
    invoke-virtual {v0, v7, v10, v11}, Landroid/os/Bundle;->getLong(Ljava/lang/String;J)J

    move-result-wide v18

    .line 305
    invoke-virtual {v0, v6, v10, v11}, Landroid/os/Bundle;->getLong(Ljava/lang/String;J)J

    move-result-wide v20

    .line 306
    sget v13, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x15

    if-ge v13, v3, :cond_3

    const/4 v3, 0x0

    goto :goto_1

    :cond_3
    const-string v3, "android.bigText"

    invoke-virtual {v0, v3}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    :goto_1
    const-string v13, "android.showChronometer"

    .line 307
    invoke-virtual {v0, v13, v12}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result v23

    const-string v13, "android.showWhen"

    .line 308
    invoke-virtual {v0, v13, v12}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result v24

    .line 309
    invoke-virtual {v0, v5}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v25
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_4
    .catch Ljava/lang/OutOfMemoryError; {:try_start_3 .. :try_end_3} :catch_3

    move-object/from16 v12, v17

    move-wide/from16 v10, v18

    move/from16 v26, v23

    move-object/from16 v4, v25

    const/4 v13, 0x0

    move-object/from16 v19, v1

    move-object/from16 v23, v15

    move-wide/from16 v37, v20

    move-object/from16 v20, v2

    move-object/from16 v21, v3

    move-object/from16 v3, v16

    move-wide/from16 v1, v37

    .line 312
    :goto_2
    :try_start_4
    invoke-static/range {p0 .. p0}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->deserializeString(Ljava/io/DataInputStream;)Ljava/lang/String;

    move-result-object v15

    .line 313
    invoke-virtual/range {p0 .. p0}, Ljava/io/DataInputStream;->readBoolean()Z

    move-result v25

    if-eqz v25, :cond_4

    .line 316
    invoke-virtual/range {p0 .. p0}, Ljava/io/DataInputStream;->readInt()I

    move-result v16

    move/from16 v27, v16

    move-object/from16 v16, v14

    goto :goto_3

    :cond_4
    move-object/from16 v16, v14

    const/16 v27, 0x0

    .line 317
    :goto_3
    invoke-virtual/range {p0 .. p0}, Ljava/io/DataInputStream;->readInt()I

    move-result v14

    move/from16 v28, v14

    .line 318
    invoke-virtual/range {p0 .. p0}, Ljava/io/DataInputStream;->readBoolean()Z

    move-result v14

    move/from16 v29, v14

    .line 319
    invoke-static/range {p0 .. p0}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->deserializeString(Ljava/io/DataInputStream;)Ljava/lang/String;

    move-result-object v14

    move-object/from16 v30, v14

    .line 320
    invoke-virtual/range {p0 .. p0}, Ljava/io/DataInputStream;->readBoolean()Z

    move-result v14

    move/from16 v31, v14

    .line 321
    invoke-virtual/range {p0 .. p0}, Ljava/io/DataInputStream;->readInt()I

    move-result v14

    move/from16 v32, v14

    .line 322
    invoke-static/range {p0 .. p0}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->deserializeString(Ljava/io/DataInputStream;)Ljava/lang/String;

    move-result-object v14

    if-eqz v24, :cond_5

    .line 323
    invoke-virtual/range {p0 .. p0}, Ljava/io/DataInputStream;->readLong()J

    move-result-wide v33

    goto :goto_4

    :cond_5
    const-wide/16 v33, 0x0

    :goto_4
    move-wide/from16 v35, v33

    move-object/from16 v33, v14

    .line 325
    sget-object v14, Lcom/unity/androidnotifications/UnityNotificationManager;->mUnityNotificationManager:Lcom/unity/androidnotifications/UnityNotificationManager;

    invoke-virtual {v14, v15}, Lcom/unity/androidnotifications/UnityNotificationManager;->createNotificationBuilder(Ljava/lang/String;)Landroid/app/Notification$Builder;

    move-result-object v14

    if-eqz v0, :cond_6

    .line 327
    invoke-virtual {v14, v0}, Landroid/app/Notification$Builder;->setExtras(Landroid/os/Bundle;)Landroid/app/Notification$Builder;

    goto :goto_5

    .line 329
    :cond_6
    invoke-virtual {v14}, Landroid/app/Notification$Builder;->getExtras()Landroid/os/Bundle;

    move-result-object v0

    const-string v15, "id"

    invoke-virtual {v0, v15, v13}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 330
    invoke-static {v14, v9, v3}, Lcom/unity/androidnotifications/UnityNotificationManager;->setNotificationIcon(Landroid/app/Notification$Builder;Ljava/lang/String;Ljava/lang/String;)V

    .line 331
    invoke-static {v14, v8, v12}, Lcom/unity/androidnotifications/UnityNotificationManager;->setNotificationIcon(Landroid/app/Notification$Builder;Ljava/lang/String;Ljava/lang/String;)V

    const-wide/16 v8, -0x1

    cmp-long v0, v10, v8

    if-eqz v0, :cond_7

    .line 333
    invoke-virtual {v14}, Landroid/app/Notification$Builder;->getExtras()Landroid/os/Bundle;

    move-result-object v0

    invoke-virtual {v0, v7, v10, v11}, Landroid/os/Bundle;->putLong(Ljava/lang/String;J)V

    :cond_7
    const-wide/16 v7, -0x1

    cmp-long v0, v1, v7

    if-eqz v0, :cond_8

    .line 335
    invoke-virtual {v14}, Landroid/app/Notification$Builder;->getExtras()Landroid/os/Bundle;

    move-result-object v0

    invoke-virtual {v0, v6, v1, v2}, Landroid/os/Bundle;->putLong(Ljava/lang/String;J)V

    :cond_8
    if-eqz v4, :cond_9

    .line 337
    invoke-virtual {v14}, Landroid/app/Notification$Builder;->getExtras()Landroid/os/Bundle;

    move-result-object v0

    invoke-virtual {v0, v5, v4}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    :cond_9
    :goto_5
    if-eqz v16, :cond_a

    move-object/from16 v0, v16

    .line 340
    invoke-virtual {v14, v0}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    :cond_a
    if-eqz v23, :cond_b

    move-object/from16 v15, v23

    .line 342
    invoke-virtual {v14, v15}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    :cond_b
    if-eqz v21, :cond_c

    .line 344
    new-instance v0, Landroid/app/Notification$BigTextStyle;

    invoke-direct {v0}, Landroid/app/Notification$BigTextStyle;-><init>()V

    move-object/from16 v3, v21

    invoke-virtual {v0, v3}, Landroid/app/Notification$BigTextStyle;->bigText(Ljava/lang/CharSequence;)Landroid/app/Notification$BigTextStyle;

    move-result-object v0

    invoke-virtual {v14, v0}, Landroid/app/Notification$Builder;->setStyle(Landroid/app/Notification$Style;)Landroid/app/Notification$Builder;

    :cond_c
    if-eqz v25, :cond_d

    move/from16 v0, v27

    .line 346
    invoke-static {v14, v0}, Lcom/unity/androidnotifications/UnityNotificationManager;->setNotificationColor(Landroid/app/Notification$Builder;I)V

    :cond_d
    if-ltz v28, :cond_e

    move/from16 v0, v28

    .line 348
    invoke-virtual {v14, v0}, Landroid/app/Notification$Builder;->setNumber(I)Landroid/app/Notification$Builder;

    :cond_e
    move/from16 v0, v29

    .line 349
    invoke-virtual {v14, v0}, Landroid/app/Notification$Builder;->setAutoCancel(Z)Landroid/app/Notification$Builder;

    move/from16 v0, v26

    .line 350
    invoke-static {v14, v0}, Lcom/unity/androidnotifications/UnityNotificationManager;->setNotificationUsesChronometer(Landroid/app/Notification$Builder;Z)V

    if-eqz v30, :cond_f

    .line 351
    invoke-virtual/range {v30 .. v30}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_f

    move-object/from16 v0, v30

    .line 352
    invoke-virtual {v14, v0}, Landroid/app/Notification$Builder;->setGroup(Ljava/lang/String;)Landroid/app/Notification$Builder;

    :cond_f
    move/from16 v0, v31

    .line 353
    invoke-virtual {v14, v0}, Landroid/app/Notification$Builder;->setGroupSummary(Z)Landroid/app/Notification$Builder;

    move/from16 v0, v32

    .line 354
    invoke-static {v14, v0}, Lcom/unity/androidnotifications/UnityNotificationManager;->setNotificationGroupAlertBehavior(Landroid/app/Notification$Builder;I)V

    if-eqz v33, :cond_10

    .line 355
    invoke-virtual/range {v33 .. v33}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_10

    move-object/from16 v0, v33

    .line 356
    invoke-virtual {v14, v0}, Landroid/app/Notification$Builder;->setSortKey(Ljava/lang/String;)Landroid/app/Notification$Builder;

    :cond_10
    if-eqz v24, :cond_11

    const/4 v0, 0x1

    .line 358
    invoke-virtual {v14, v0}, Landroid/app/Notification$Builder;->setShowWhen(Z)Landroid/app/Notification$Builder;

    move-wide/from16 v0, v35

    .line 359
    invoke-virtual {v14, v0, v1}, Landroid/app/Notification$Builder;->setWhen(J)Landroid/app/Notification$Builder;
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_2
    .catch Ljava/lang/OutOfMemoryError; {:try_start_4 .. :try_end_4} :catch_1

    :cond_11
    return-object v14

    :catch_1
    move-exception v0

    move-object/from16 v2, v19

    move-object/from16 v1, v20

    goto :goto_7

    :catch_2
    move-exception v0

    move-object/from16 v2, v19

    move-object/from16 v1, v20

    goto :goto_8

    :cond_12
    :goto_6
    move-object v1, v3

    return-object v1

    :catch_3
    move-exception v0

    move-object/from16 v37, v2

    move-object v2, v1

    move-object/from16 v1, v37

    .line 366
    :goto_7
    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_9

    :catch_4
    move-exception v0

    move-object/from16 v37, v2

    move-object v2, v1

    move-object/from16 v1, v37

    .line 364
    :goto_8
    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :goto_9
    const/4 v1, 0x0

    return-object v1
.end method

.method private static deserializeNotificationParcelable(Ljava/io/DataInputStream;)Landroid/app/Notification;
    .locals 4

    const-string v0, "Failed to deserialize notification intent"

    const-string v1, "UnityNotifications"

    const/4 v2, 0x0

    .line 249
    :try_start_0
    sget-object v3, Lcom/unity/androidnotifications/UnityNotificationUtilities;->UNITY_MAGIC_NUMBER_PARCELLED:[B

    invoke-static {p0, v3}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->readAndCheckMagicNumber(Ljava/io/DataInputStream;[B)Z

    move-result v3

    if-nez v3, :cond_0

    return-object v2

    .line 251
    :cond_0
    invoke-virtual {p0}, Ljava/io/DataInputStream;->readInt()I

    move-result v3

    if-ltz v3, :cond_2

    if-lez v3, :cond_1

    goto :goto_0

    .line 254
    :cond_1
    invoke-static {p0}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->deserializeParcelable(Ljava/io/DataInputStream;)Landroid/os/Parcelable;

    move-result-object p0

    check-cast p0, Landroid/content/Intent;

    const-string v3, "unityNotification"

    .line 255
    invoke-virtual {p0, v3}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object p0

    check-cast p0, Landroid/app/Notification;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/OutOfMemoryError; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :cond_2
    :goto_0
    return-object v2

    :catch_0
    move-exception p0

    .line 260
    invoke-static {v1, v0, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1

    :catch_1
    move-exception p0

    .line 258
    invoke-static {v1, v0, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :goto_1
    return-object v2
.end method

.method private static deserializeParcelable(Ljava/io/DataInputStream;)Landroid/os/Parcelable;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T::",
            "Landroid/os/Parcelable;",
            ">(",
            "Ljava/io/DataInputStream;",
            ")TT;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const-string v0, "Failed to deserialize parcelable"

    const-string v1, "UnityNotifications"

    .line 447
    invoke-virtual {p0}, Ljava/io/DataInputStream;->readInt()I

    move-result v2

    const/4 v3, 0x0

    if-gtz v2, :cond_0

    return-object v3

    .line 450
    :cond_0
    new-array v4, v2, [B

    .line 451
    invoke-virtual {p0, v4}, Ljava/io/DataInputStream;->read([B)I

    move-result p0

    if-ne p0, v2, :cond_2

    .line 456
    :try_start_0
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object p0

    const/4 v5, 0x0

    .line 457
    invoke-virtual {p0, v4, v5, v2}, Landroid/os/Parcel;->unmarshall([BII)V

    .line 458
    invoke-virtual {p0, v5}, Landroid/os/Parcel;->setDataPosition(I)V

    .line 459
    const-class v2, Lcom/unity/androidnotifications/UnityNotificationUtilities;

    invoke-virtual {v2}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v2

    invoke-virtual {p0, v2}, Landroid/os/Parcel;->readParcelable(Ljava/lang/ClassLoader;)Landroid/os/Parcelable;

    move-result-object v2

    check-cast v2, Landroid/os/Bundle;

    .line 460
    invoke-virtual {p0}, Landroid/os/Parcel;->recycle()V

    if-eqz v2, :cond_1

    const-string p0, "obj"

    .line 462
    invoke-virtual {v2, p0}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/OutOfMemoryError; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    move-exception p0

    .line 467
    invoke-static {v1, v0, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    :catch_1
    move-exception p0

    .line 465
    invoke-static {v1, v0, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_1
    :goto_0
    return-object v3

    .line 453
    :cond_2
    new-instance p0, Ljava/io/IOException;

    const-string v0, "Insufficient amount of bytes read"

    invoke-direct {p0, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static deserializeString(Ljava/io/DataInputStream;)Ljava/lang/String;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 436
    invoke-virtual {p0}, Ljava/io/DataInputStream;->readInt()I

    move-result v0

    if-gtz v0, :cond_0

    const/4 p0, 0x0

    return-object p0

    .line 439
    :cond_0
    new-array v1, v0, [B

    .line 440
    invoke-virtual {p0, v1}, Ljava/io/DataInputStream;->read([B)I

    move-result p0

    if-ne p0, v0, :cond_1

    .line 443
    new-instance p0, Ljava/lang/String;

    sget-object v0, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {p0, v1, v0}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    return-object p0

    .line 442
    :cond_1
    new-instance p0, Ljava/io/IOException;

    const-string v0, "Insufficient amount of bytes read"

    invoke-direct {p0, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static deserializedFromOldIntent([B)Landroid/app/Notification$Builder;
    .locals 28

    move-object/from16 v0, p0

    const-string v1, "data"

    const-string v2, "repeatInterval"

    const-string v3, "fireTime"

    const-string v4, "id"

    const-string v5, "Failed to deserialize old style notification"

    const-string v6, "UnityNotifications"

    .line 374
    :try_start_0
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v7

    .line 375
    array-length v8, v0

    const/4 v9, 0x0

    invoke-virtual {v7, v0, v9, v8}, Landroid/os/Parcel;->unmarshall([BII)V

    .line 376
    invoke-virtual {v7, v9}, Landroid/os/Parcel;->setDataPosition(I)V

    .line 377
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 378
    invoke-virtual {v0, v7}, Landroid/os/Bundle;->readFromParcel(Landroid/os/Parcel;)V

    const/4 v7, -0x1

    .line 380
    invoke-virtual {v0, v4, v7}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v8

    const-string v10, "channelID"

    .line 381
    invoke-virtual {v0, v10}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    const-string v11, "textTitle"

    .line 382
    invoke-virtual {v0, v11}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    const-string v12, "textContent"

    .line 383
    invoke-virtual {v0, v12}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    const-string v13, "smallIconStr"

    .line 384
    invoke-virtual {v0, v13}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    const-string v14, "autoCancel"

    .line 385
    invoke-virtual {v0, v14, v9}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result v14

    const-string v15, "usesChronometer"

    .line 386
    invoke-virtual {v0, v15, v9}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result v15

    move-object/from16 p0, v10

    const-wide/16 v9, -0x1

    move/from16 v17, v8

    .line 387
    invoke-virtual {v0, v3, v9, v10}, Landroid/os/Bundle;->getLong(Ljava/lang/String;J)J

    move-result-wide v7

    .line 388
    invoke-virtual {v0, v2, v9, v10}, Landroid/os/Bundle;->getLong(Ljava/lang/String;J)J

    move-result-wide v9
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_5
    .catch Ljava/lang/OutOfMemoryError; {:try_start_0 .. :try_end_0} :catch_4

    move-object/from16 v18, v5

    :try_start_1
    const-string v5, "largeIconStr"

    .line 389
    invoke-virtual {v0, v5}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_3
    .catch Ljava/lang/OutOfMemoryError; {:try_start_1 .. :try_end_1} :catch_2

    move-object/from16 v19, v6

    :try_start_2
    const-string v6, "style"

    move-object/from16 v20, v5

    const/4 v5, -0x1

    .line 390
    invoke-virtual {v0, v6, v5}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v6

    const-string v5, "color"

    move/from16 v21, v6

    const/4 v6, 0x0

    .line 391
    invoke-virtual {v0, v5, v6}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v5

    move/from16 v22, v5

    const-string v5, "number"

    .line 392
    invoke-virtual {v0, v5, v6}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v5

    .line 393
    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    move-object/from16 v23, v1

    const-string v1, "group"

    .line 394
    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    move-object/from16 v24, v1

    const-string v1, "groupSummary"

    move-object/from16 v25, v6

    const/4 v6, 0x0

    .line 395
    invoke-virtual {v0, v1, v6}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    const-string v6, "sortKey"

    .line 396
    invoke-virtual {v0, v6}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    move-object/from16 v26, v6

    const-string v6, "groupAlertBehaviour"

    move/from16 v27, v1

    const/4 v1, -0x1

    .line 397
    invoke-virtual {v0, v6, v1}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v1

    const-string v6, "showTimestamp"

    move/from16 v16, v1

    const/4 v1, 0x0

    .line 398
    invoke-virtual {v0, v6, v1}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    .line 400
    sget-object v1, Lcom/unity/androidnotifications/UnityNotificationManager;->mUnityNotificationManager:Lcom/unity/androidnotifications/UnityNotificationManager;

    move-object/from16 v6, p0

    invoke-virtual {v1, v6}, Lcom/unity/androidnotifications/UnityNotificationManager;->createNotificationBuilder(Ljava/lang/String;)Landroid/app/Notification$Builder;

    move-result-object v1

    .line 401
    invoke-virtual {v1}, Landroid/app/Notification$Builder;->getExtras()Landroid/os/Bundle;

    move-result-object v6

    move/from16 p0, v0

    move/from16 v0, v17

    invoke-virtual {v6, v4, v0}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 402
    invoke-virtual {v1, v11}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    .line 403
    invoke-virtual {v1, v12}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    const-string v0, "smallIcon"

    .line 404
    invoke-static {v1, v0, v13}, Lcom/unity/androidnotifications/UnityNotificationManager;->setNotificationIcon(Landroid/app/Notification$Builder;Ljava/lang/String;Ljava/lang/String;)V

    .line 405
    invoke-virtual {v1, v14}, Landroid/app/Notification$Builder;->setAutoCancel(Z)Landroid/app/Notification$Builder;

    .line 406
    invoke-virtual {v1, v15}, Landroid/app/Notification$Builder;->setUsesChronometer(Z)Landroid/app/Notification$Builder;

    .line 407
    invoke-virtual {v1}, Landroid/app/Notification$Builder;->getExtras()Landroid/os/Bundle;

    move-result-object v0

    invoke-virtual {v0, v3, v7, v8}, Landroid/os/Bundle;->putLong(Ljava/lang/String;J)V

    .line 408
    invoke-virtual {v1}, Landroid/app/Notification$Builder;->getExtras()Landroid/os/Bundle;

    move-result-object v0

    invoke-virtual {v0, v2, v9, v10}, Landroid/os/Bundle;->putLong(Ljava/lang/String;J)V

    const-string v0, "largeIcon"

    move-object/from16 v2, v20

    .line 409
    invoke-static {v1, v0, v2}, Lcom/unity/androidnotifications/UnityNotificationManager;->setNotificationIcon(Landroid/app/Notification$Builder;Ljava/lang/String;Ljava/lang/String;)V

    const/4 v0, 0x2

    move/from16 v2, v21

    if-ne v2, v0, :cond_0

    .line 411
    new-instance v0, Landroid/app/Notification$BigTextStyle;

    invoke-direct {v0}, Landroid/app/Notification$BigTextStyle;-><init>()V

    invoke-virtual {v0, v12}, Landroid/app/Notification$BigTextStyle;->bigText(Ljava/lang/CharSequence;)Landroid/app/Notification$BigTextStyle;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/app/Notification$Builder;->setStyle(Landroid/app/Notification$Style;)Landroid/app/Notification$Builder;

    :cond_0
    if-eqz v22, :cond_1

    move/from16 v0, v22

    .line 413
    invoke-static {v1, v0}, Lcom/unity/androidnotifications/UnityNotificationManager;->setNotificationColor(Landroid/app/Notification$Builder;I)V

    :cond_1
    if-ltz v5, :cond_2

    .line 415
    invoke-virtual {v1, v5}, Landroid/app/Notification$Builder;->setNumber(I)Landroid/app/Notification$Builder;

    :cond_2
    if-eqz v25, :cond_3

    .line 417
    invoke-virtual {v1}, Landroid/app/Notification$Builder;->getExtras()Landroid/os/Bundle;

    move-result-object v0

    move-object/from16 v3, v23

    move-object/from16 v2, v25

    invoke-virtual {v0, v3, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    :cond_3
    if-eqz v24, :cond_4

    .line 418
    invoke-virtual/range {v24 .. v24}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_4

    move-object/from16 v0, v24

    .line 419
    invoke-virtual {v1, v0}, Landroid/app/Notification$Builder;->setGroup(Ljava/lang/String;)Landroid/app/Notification$Builder;

    :cond_4
    move/from16 v0, v27

    .line 420
    invoke-virtual {v1, v0}, Landroid/app/Notification$Builder;->setGroupSummary(Z)Landroid/app/Notification$Builder;

    if-eqz v26, :cond_5

    .line 421
    invoke-virtual/range {v26 .. v26}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_5

    move-object/from16 v0, v26

    .line 422
    invoke-virtual {v1, v0}, Landroid/app/Notification$Builder;->setSortKey(Ljava/lang/String;)Landroid/app/Notification$Builder;

    :cond_5
    move/from16 v0, v16

    .line 423
    invoke-static {v1, v0}, Lcom/unity/androidnotifications/UnityNotificationManager;->setNotificationGroupAlertBehavior(Landroid/app/Notification$Builder;I)V

    move/from16 v0, p0

    .line 424
    invoke-virtual {v1, v0}, Landroid/app/Notification$Builder;->setShowWhen(Z)Landroid/app/Notification$Builder;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1
    .catch Ljava/lang/OutOfMemoryError; {:try_start_2 .. :try_end_2} :catch_0

    return-object v1

    :catch_0
    move-exception v0

    move-object/from16 v2, v18

    move-object/from16 v1, v19

    goto :goto_0

    :catch_1
    move-exception v0

    move-object/from16 v2, v18

    move-object/from16 v1, v19

    goto :goto_1

    :catch_2
    move-exception v0

    move-object v1, v6

    move-object/from16 v2, v18

    goto :goto_0

    :catch_3
    move-exception v0

    move-object v1, v6

    move-object/from16 v2, v18

    goto :goto_1

    :catch_4
    move-exception v0

    move-object v2, v5

    move-object v1, v6

    .line 429
    :goto_0
    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_2

    :catch_5
    move-exception v0

    move-object v2, v5

    move-object v1, v6

    .line 427
    :goto_1
    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :goto_2
    const/4 v0, 0x0

    return-object v0
.end method

.method protected static findResourceIdInContextByName(Landroid/content/Context;Ljava/lang/String;)I
    .locals 4

    const/4 v0, 0x0

    if-nez p1, :cond_0

    return v0

    .line 49
    :cond_0
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    if-eqz v1, :cond_2

    const-string v2, "mipmap"

    .line 51
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, p1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    if-nez v2, :cond_1

    const-string v2, "drawable"

    .line 53
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v1, p1, v2, p0}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result p0
    :try_end_0
    .catch Landroid/content/res/Resources$NotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    return p0

    :cond_1
    return v2

    :catch_0
    :cond_2
    return v0
.end method

.method protected static getOpenAppActivity(Landroid/content/Context;Z)Ljava/lang/Class;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Z)",
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation

    const/4 v0, 0x0

    .line 476
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    const/16 v3, 0x80

    invoke-virtual {v1, v2, v3}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;

    move-result-object v1
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v1

    .line 478
    invoke-virtual {v1}, Landroid/content/pm/PackageManager$NameNotFoundException;->printStackTrace()V

    move-object v1, v0

    .line 480
    :goto_0
    iget-object v1, v1, Landroid/content/pm/ApplicationInfo;->metaData:Landroid/os/Bundle;

    const-string v2, "custom_notification_android_activity"

    .line 485
    invoke-virtual {v1, v2}, Landroid/os/Bundle;->containsKey(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 486
    invoke-virtual {v1, v2}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 489
    :try_start_1
    invoke-static {v1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0
    :try_end_1
    .catch Ljava/lang/ClassNotFoundException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_1

    :catch_1
    nop

    :cond_0
    :goto_1
    if-nez v0, :cond_1

    if-eqz p1, :cond_1

    const-string p1, "UnityNotifications"

    const-string v1, "No custom_notification_android_activity found, attempting to find app activity class"

    .line 496
    invoke-static {p1, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    const-string v1, "com.unity3d.player.UnityPlayerActivity"

    .line 500
    :try_start_2
    invoke-static {v1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object p0
    :try_end_2
    .catch Ljava/lang/ClassNotFoundException; {:try_start_2 .. :try_end_2} :catch_2

    return-object p0

    :catch_2
    const/4 v2, 0x1

    new-array v3, v2, [Ljava/lang/Object;

    const/4 v4, 0x0

    aput-object v1, v3, v4

    const-string v1, "Attempting to find : %s, failed!"

    .line 502
    invoke-static {v1, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {p1, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    new-array v1, v2, [Ljava/lang/Object;

    .line 503
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p0

    aput-object p0, v1, v4

    const-string p0, "%s.UnityPlayerActivity"

    invoke-static {p0, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    .line 505
    :try_start_3
    invoke-static {p0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object p0
    :try_end_3
    .catch Ljava/lang/ClassNotFoundException; {:try_start_3 .. :try_end_3} :catch_3

    return-object p0

    :catch_3
    new-array v1, v2, [Ljava/lang/Object;

    aput-object p0, v1, v4

    const-string p0, "Attempting to find class based on package name: %s, failed!"

    .line 507
    invoke-static {p0, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    invoke-static {p1, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    return-object v0
.end method

.method private static readAndCheckMagicNumber(Ljava/io/DataInputStream;[B)Z
    .locals 4

    const/4 v0, 0x0

    const/4 v1, 0x0

    .line 233
    :goto_0
    :try_start_0
    array-length v2, p1

    if-ge v1, v2, :cond_1

    .line 234
    invoke-virtual {p0}, Ljava/io/DataInputStream;->readByte()B

    move-result v2

    .line 235
    aget-byte v3, p1, v1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    if-eq v2, v3, :cond_0

    goto :goto_1

    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    const/4 v0, 0x1

    :catch_0
    :goto_1
    return v0
.end method

.method protected static recoverBuilder(Landroid/content/Context;Landroid/app/Notification;)Landroid/app/Notification$Builder;
    .locals 2

    .line 516
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x18

    if-lt v0, v1, :cond_0

    .line 517
    invoke-static {p0, p1}, Landroid/app/Notification$Builder;->recoverBuilder(Landroid/content/Context;Landroid/app/Notification;)Landroid/app/Notification$Builder;

    move-result-object p0

    .line 519
    iget-object p1, p1, Landroid/app/Notification;->extras:Landroid/os/Bundle;

    invoke-virtual {p0, p1}, Landroid/app/Notification$Builder;->setExtras(Landroid/os/Bundle;)Landroid/app/Notification$Builder;

    return-object p0

    .line 523
    :cond_0
    invoke-static {p0, p1}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->recoverBuilderPreNougat(Landroid/content/Context;Landroid/app/Notification;)Landroid/app/Notification$Builder;

    move-result-object p0

    return-object p0
.end method

.method private static recoverBuilderPreNougat(Landroid/content/Context;Landroid/app/Notification;)Landroid/app/Notification$Builder;
    .locals 7

    .line 528
    iget-object v0, p1, Landroid/app/Notification;->extras:Landroid/os/Bundle;

    const-string v1, "channelID"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 529
    invoke-static {p0, v0}, Lcom/unity/androidnotifications/UnityNotificationManager;->createNotificationBuilder(Landroid/content/Context;Ljava/lang/String;)Landroid/app/Notification$Builder;

    move-result-object p0

    .line 530
    iget-object v0, p1, Landroid/app/Notification;->extras:Landroid/os/Bundle;

    const-string v1, "smallIcon"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v1, v0}, Lcom/unity/androidnotifications/UnityNotificationManager;->setNotificationIcon(Landroid/app/Notification$Builder;Ljava/lang/String;Ljava/lang/String;)V

    .line 531
    iget-object v0, p1, Landroid/app/Notification;->extras:Landroid/os/Bundle;

    const-string v1, "largeIcon"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 532
    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_0

    .line 533
    invoke-static {p0, v1, v0}, Lcom/unity/androidnotifications/UnityNotificationManager;->setNotificationIcon(Landroid/app/Notification$Builder;Ljava/lang/String;Ljava/lang/String;)V

    .line 534
    :cond_0
    iget-object v0, p1, Landroid/app/Notification;->extras:Landroid/os/Bundle;

    const-string v1, "android.title"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    .line 535
    iget-object v0, p1, Landroid/app/Notification;->extras:Landroid/os/Bundle;

    const-string v1, "android.text"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    .line 536
    iget v0, p1, Landroid/app/Notification;->flags:I

    and-int/lit8 v0, v0, 0x10

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-eqz v0, :cond_1

    const/4 v0, 0x1

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    :goto_0
    invoke-virtual {p0, v0}, Landroid/app/Notification$Builder;->setAutoCancel(Z)Landroid/app/Notification$Builder;

    .line 537
    iget v0, p1, Landroid/app/Notification;->number:I

    if-ltz v0, :cond_2

    .line 538
    iget v0, p1, Landroid/app/Notification;->number:I

    invoke-virtual {p0, v0}, Landroid/app/Notification$Builder;->setNumber(I)Landroid/app/Notification$Builder;

    .line 539
    :cond_2
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x15

    if-lt v0, v3, :cond_3

    .line 540
    iget-object v0, p1, Landroid/app/Notification;->extras:Landroid/os/Bundle;

    const-string v3, "android.bigText"

    invoke-virtual {v0, v3}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_3

    .line 542
    new-instance v3, Landroid/app/Notification$BigTextStyle;

    invoke-direct {v3}, Landroid/app/Notification$BigTextStyle;-><init>()V

    invoke-virtual {v3, v0}, Landroid/app/Notification$BigTextStyle;->bigText(Ljava/lang/CharSequence;)Landroid/app/Notification$BigTextStyle;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroid/app/Notification$Builder;->setStyle(Landroid/app/Notification$Style;)Landroid/app/Notification$Builder;

    .line 545
    :cond_3
    iget-wide v3, p1, Landroid/app/Notification;->when:J

    invoke-virtual {p0, v3, v4}, Landroid/app/Notification$Builder;->setWhen(J)Landroid/app/Notification$Builder;

    .line 546
    invoke-virtual {p1}, Landroid/app/Notification;->getGroup()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_4

    .line 547
    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_4

    .line 548
    invoke-virtual {p0, v0}, Landroid/app/Notification$Builder;->setGroup(Ljava/lang/String;)Landroid/app/Notification$Builder;

    .line 549
    :cond_4
    iget v0, p1, Landroid/app/Notification;->flags:I

    and-int/lit16 v0, v0, 0x200

    if-eqz v0, :cond_5

    goto :goto_1

    :cond_5
    const/4 v1, 0x0

    :goto_1
    invoke-virtual {p0, v1}, Landroid/app/Notification$Builder;->setGroupSummary(Z)Landroid/app/Notification$Builder;

    .line 550
    invoke-virtual {p1}, Landroid/app/Notification;->getSortKey()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_6

    .line 551
    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_6

    .line 552
    invoke-virtual {p0, v0}, Landroid/app/Notification$Builder;->setSortKey(Ljava/lang/String;)Landroid/app/Notification$Builder;

    .line 553
    :cond_6
    iget-object v0, p1, Landroid/app/Notification;->extras:Landroid/os/Bundle;

    const-string v1, "android.showWhen"

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    invoke-virtual {p0, v0}, Landroid/app/Notification$Builder;->setShowWhen(Z)Landroid/app/Notification$Builder;

    .line 554
    invoke-static {p1}, Lcom/unity/androidnotifications/UnityNotificationManager;->getNotificationColor(Landroid/app/Notification;)Ljava/lang/Integer;

    move-result-object v0

    if-eqz v0, :cond_7

    .line 556
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-static {p0, v0}, Lcom/unity/androidnotifications/UnityNotificationManager;->setNotificationColor(Landroid/app/Notification$Builder;I)V

    .line 557
    :cond_7
    iget-object v0, p1, Landroid/app/Notification;->extras:Landroid/os/Bundle;

    const-string v1, "android.showChronometer"

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    invoke-static {p0, v0}, Lcom/unity/androidnotifications/UnityNotificationManager;->setNotificationUsesChronometer(Landroid/app/Notification$Builder;Z)V

    .line 558
    invoke-static {p1}, Lcom/unity/androidnotifications/UnityNotificationManager;->getNotificationGroupAlertBehavior(Landroid/app/Notification;)I

    move-result v0

    invoke-static {p0, v0}, Lcom/unity/androidnotifications/UnityNotificationManager;->setNotificationGroupAlertBehavior(Landroid/app/Notification$Builder;I)V

    .line 560
    invoke-virtual {p0}, Landroid/app/Notification$Builder;->getExtras()Landroid/os/Bundle;

    move-result-object v0

    iget-object v1, p1, Landroid/app/Notification;->extras:Landroid/os/Bundle;

    const-string v3, "id"

    invoke-virtual {v1, v3, v2}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v1

    invoke-virtual {v0, v3, v1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 561
    invoke-virtual {p0}, Landroid/app/Notification$Builder;->getExtras()Landroid/os/Bundle;

    move-result-object v0

    iget-object v1, p1, Landroid/app/Notification;->extras:Landroid/os/Bundle;

    const-string v2, "repeatInterval"

    const-wide/16 v3, 0x0

    invoke-virtual {v1, v2, v3, v4}, Landroid/os/Bundle;->getLong(Ljava/lang/String;J)J

    move-result-wide v5

    invoke-virtual {v0, v2, v5, v6}, Landroid/os/Bundle;->putLong(Ljava/lang/String;J)V

    .line 562
    invoke-virtual {p0}, Landroid/app/Notification$Builder;->getExtras()Landroid/os/Bundle;

    move-result-object v0

    iget-object v1, p1, Landroid/app/Notification;->extras:Landroid/os/Bundle;

    const-string v2, "fireTime"

    invoke-virtual {v1, v2, v3, v4}, Landroid/os/Bundle;->getLong(Ljava/lang/String;J)J

    move-result-wide v3

    invoke-virtual {v0, v2, v3, v4}, Landroid/os/Bundle;->putLong(Ljava/lang/String;J)V

    .line 563
    iget-object p1, p1, Landroid/app/Notification;->extras:Landroid/os/Bundle;

    const-string v0, "data"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_8

    .line 564
    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_8

    .line 565
    invoke-virtual {p0}, Landroid/app/Notification$Builder;->getExtras()Landroid/os/Bundle;

    move-result-object v1

    invoke-virtual {v1, v0, p1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    :cond_8
    return-object p0
.end method

.method protected static serializeNotification(Landroid/content/SharedPreferences;Landroid/app/Notification;)V
    .locals 6

    const/4 v0, 0x0

    .line 77
    :try_start_0
    new-instance v1, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v1}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 78
    new-instance v2, Ljava/io/DataOutputStream;

    invoke-direct {v2, v1}, Ljava/io/DataOutputStream;-><init>(Ljava/io/OutputStream;)V

    .line 79
    invoke-static {p1, v2}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->serializeNotificationCustom(Landroid/app/Notification;Ljava/io/DataOutputStream;)Z

    move-result v3

    const/4 v4, 0x0

    if-eqz v3, :cond_0

    .line 80
    invoke-virtual {v2}, Ljava/io/DataOutputStream;->flush()V

    .line 81
    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    .line 82
    array-length v3, v0

    invoke-static {v0, v4, v3, v4}, Landroid/util/Base64;->encodeToString([BIII)Ljava/lang/String;

    move-result-object v0

    .line 84
    :cond_0
    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->reset()V

    .line 85
    new-instance v3, Landroid/content/Intent;

    invoke-direct {v3}, Landroid/content/Intent;-><init>()V

    const-string v5, "unityNotification"

    .line 86
    invoke-virtual {v3, v5, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    .line 87
    invoke-static {v3, v2}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->serializeNotificationParcel(Landroid/content/Intent;Ljava/io/DataOutputStream;)Z

    move-result p1

    if-eqz p1, :cond_1

    .line 88
    invoke-virtual {v2}, Ljava/io/DataOutputStream;->close()V

    .line 89
    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object p1

    .line 90
    array-length v1, p1

    invoke-static {p1, v4, v1, v4}, Landroid/util/Base64;->encodeToString([BIII)Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    :cond_1
    move-object p1, v0

    .line 95
    :goto_0
    invoke-interface {p0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    invoke-interface {p0}, Landroid/content/SharedPreferences$Editor;->clear()Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    const-string v1, "data"

    .line 96
    invoke-interface {p0, v1, p1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    const-string p1, "fallback.data"

    .line 97
    invoke-interface {p0, p1, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 98
    invoke-interface {p0}, Landroid/content/SharedPreferences$Editor;->apply()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception p0

    const-string p1, "UnityNotifications"

    const-string v0, "Failed to serialize notification"

    .line 100
    invoke-static {p1, v0, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :goto_1
    return-void
.end method

.method private static serializeNotificationCustom(Landroid/app/Notification;Ljava/io/DataOutputStream;)Z
    .locals 9

    const/4 v0, 0x0

    .line 125
    :try_start_0
    sget-object v1, Lcom/unity/androidnotifications/UnityNotificationUtilities;->UNITY_MAGIC_NUMBER:[B

    invoke-virtual {p1, v1}, Ljava/io/DataOutputStream;->write([B)V

    .line 126
    invoke-virtual {p1, v0}, Ljava/io/DataOutputStream;->writeInt(I)V

    .line 129
    iget-object v1, p0, Landroid/app/Notification;->extras:Landroid/os/Bundle;

    const-string v2, "android.showWhen"

    invoke-virtual {v1, v2, v0}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    .line 130
    iget-object v2, p0, Landroid/app/Notification;->extras:Landroid/os/Bundle;

    invoke-static {v2}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->serializeParcelable(Landroid/os/Parcelable;)[B

    move-result-object v2

    if-nez v2, :cond_0

    const/4 v3, 0x0

    goto :goto_0

    .line 131
    :cond_0
    array-length v3, v2

    :goto_0
    invoke-virtual {p1, v3}, Ljava/io/DataOutputStream;->writeInt(I)V

    const/4 v3, 0x0

    if-eqz v2, :cond_1

    .line 132
    array-length v4, v2

    if-lez v4, :cond_1

    .line 133
    invoke-virtual {p1, v2}, Ljava/io/DataOutputStream;->write([B)V

    goto/16 :goto_2

    .line 136
    :cond_1
    iget-object v2, p0, Landroid/app/Notification;->extras:Landroid/os/Bundle;

    const-string v4, "id"

    invoke-virtual {v2, v4}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {p1, v2}, Ljava/io/DataOutputStream;->writeInt(I)V

    .line 137
    iget-object v2, p0, Landroid/app/Notification;->extras:Landroid/os/Bundle;

    const-string v4, "android.title"

    invoke-virtual {v2, v4}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {p1, v2}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->serializeString(Ljava/io/DataOutputStream;Ljava/lang/String;)V

    .line 138
    iget-object v2, p0, Landroid/app/Notification;->extras:Landroid/os/Bundle;

    const-string v4, "android.text"

    invoke-virtual {v2, v4}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {p1, v2}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->serializeString(Ljava/io/DataOutputStream;Ljava/lang/String;)V

    .line 139
    iget-object v2, p0, Landroid/app/Notification;->extras:Landroid/os/Bundle;

    const-string v4, "smallIcon"

    invoke-virtual {v2, v4}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {p1, v2}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->serializeString(Ljava/io/DataOutputStream;Ljava/lang/String;)V

    .line 140
    iget-object v2, p0, Landroid/app/Notification;->extras:Landroid/os/Bundle;

    const-string v4, "largeIcon"

    invoke-virtual {v2, v4}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {p1, v2}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->serializeString(Ljava/io/DataOutputStream;Ljava/lang/String;)V

    .line 141
    iget-object v2, p0, Landroid/app/Notification;->extras:Landroid/os/Bundle;

    const-string v4, "fireTime"

    const-wide/16 v5, -0x1

    invoke-virtual {v2, v4, v5, v6}, Landroid/os/Bundle;->getLong(Ljava/lang/String;J)J

    move-result-wide v7

    invoke-virtual {p1, v7, v8}, Ljava/io/DataOutputStream;->writeLong(J)V

    .line 142
    iget-object v2, p0, Landroid/app/Notification;->extras:Landroid/os/Bundle;

    const-string v4, "repeatInterval"

    invoke-virtual {v2, v4, v5, v6}, Landroid/os/Bundle;->getLong(Ljava/lang/String;J)J

    move-result-wide v4

    invoke-virtual {p1, v4, v5}, Ljava/io/DataOutputStream;->writeLong(J)V

    .line 143
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v4, 0x15

    if-ge v2, v4, :cond_2

    move-object v2, v3

    goto :goto_1

    :cond_2
    iget-object v2, p0, Landroid/app/Notification;->extras:Landroid/os/Bundle;

    const-string v4, "android.bigText"

    invoke-virtual {v2, v4}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    :goto_1
    invoke-static {p1, v2}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->serializeString(Ljava/io/DataOutputStream;Ljava/lang/String;)V

    .line 144
    iget-object v2, p0, Landroid/app/Notification;->extras:Landroid/os/Bundle;

    const-string v4, "android.showChronometer"

    invoke-virtual {v2, v4, v0}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    invoke-virtual {p1, v2}, Ljava/io/DataOutputStream;->writeBoolean(Z)V

    .line 145
    invoke-virtual {p1, v1}, Ljava/io/DataOutputStream;->writeBoolean(Z)V

    .line 146
    iget-object v2, p0, Landroid/app/Notification;->extras:Landroid/os/Bundle;

    const-string v4, "data"

    invoke-virtual {v2, v4}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {p1, v2}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->serializeString(Ljava/io/DataOutputStream;Ljava/lang/String;)V

    .line 149
    :goto_2
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v4, 0x1a

    if-ge v2, v4, :cond_3

    goto :goto_3

    :cond_3
    invoke-virtual {p0}, Landroid/app/Notification;->getChannelId()Ljava/lang/String;

    move-result-object v3

    :goto_3
    invoke-static {p1, v3}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->serializeString(Ljava/io/DataOutputStream;Ljava/lang/String;)V

    .line 150
    invoke-static {p0}, Lcom/unity/androidnotifications/UnityNotificationManager;->getNotificationColor(Landroid/app/Notification;)Ljava/lang/Integer;

    move-result-object v2

    const/4 v3, 0x1

    if-eqz v2, :cond_4

    const/4 v4, 0x1

    goto :goto_4

    :cond_4
    const/4 v4, 0x0

    .line 151
    :goto_4
    invoke-virtual {p1, v4}, Ljava/io/DataOutputStream;->writeBoolean(Z)V

    if-eqz v2, :cond_5

    .line 153
    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    invoke-virtual {p1, v2}, Ljava/io/DataOutputStream;->writeInt(I)V

    .line 154
    :cond_5
    iget v2, p0, Landroid/app/Notification;->number:I

    invoke-virtual {p1, v2}, Ljava/io/DataOutputStream;->writeInt(I)V

    .line 155
    iget v2, p0, Landroid/app/Notification;->flags:I

    and-int/lit8 v2, v2, 0x10

    if-eqz v2, :cond_6

    const/4 v2, 0x1

    goto :goto_5

    :cond_6
    const/4 v2, 0x0

    :goto_5
    invoke-virtual {p1, v2}, Ljava/io/DataOutputStream;->writeBoolean(Z)V

    .line 156
    invoke-virtual {p0}, Landroid/app/Notification;->getGroup()Ljava/lang/String;

    move-result-object v2

    invoke-static {p1, v2}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->serializeString(Ljava/io/DataOutputStream;Ljava/lang/String;)V

    .line 157
    iget v2, p0, Landroid/app/Notification;->flags:I

    and-int/lit16 v2, v2, 0x200

    if-eqz v2, :cond_7

    const/4 v2, 0x1

    goto :goto_6

    :cond_7
    const/4 v2, 0x0

    :goto_6
    invoke-virtual {p1, v2}, Ljava/io/DataOutputStream;->writeBoolean(Z)V

    .line 158
    invoke-static {p0}, Lcom/unity/androidnotifications/UnityNotificationManager;->getNotificationGroupAlertBehavior(Landroid/app/Notification;)I

    move-result v2

    invoke-virtual {p1, v2}, Ljava/io/DataOutputStream;->writeInt(I)V

    .line 159
    invoke-virtual {p0}, Landroid/app/Notification;->getSortKey()Ljava/lang/String;

    move-result-object v2

    invoke-static {p1, v2}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->serializeString(Ljava/io/DataOutputStream;Ljava/lang/String;)V

    if-eqz v1, :cond_8

    .line 161
    iget-wide v1, p0, Landroid/app/Notification;->when:J

    invoke-virtual {p1, v1, v2}, Ljava/io/DataOutputStream;->writeLong(J)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :cond_8
    return v3

    :catch_0
    move-exception p0

    const-string p1, "UnityNotifications"

    const-string v1, "Failed to serialize notification"

    .line 165
    invoke-static {p1, v1, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    return v0
.end method

.method private static serializeNotificationParcel(Landroid/content/Intent;Ljava/io/DataOutputStream;)Z
    .locals 4

    const-string v0, "Failed to serialize notification as Parcel"

    const-string v1, "UnityNotifications"

    const/4 v2, 0x0

    .line 106
    :try_start_0
    invoke-static {p0}, Lcom/unity/androidnotifications/UnityNotificationUtilities;->serializeParcelable(Landroid/os/Parcelable;)[B

    move-result-object p0

    if-eqz p0, :cond_1

    .line 107
    array-length v3, p0

    if-nez v3, :cond_0

    goto :goto_0

    .line 109
    :cond_0
    sget-object v3, Lcom/unity/androidnotifications/UnityNotificationUtilities;->UNITY_MAGIC_NUMBER_PARCELLED:[B

    invoke-virtual {p1, v3}, Ljava/io/DataOutputStream;->write([B)V

    .line 110
    invoke-virtual {p1, v2}, Ljava/io/DataOutputStream;->writeInt(I)V

    .line 111
    array-length v3, p0

    invoke-virtual {p1, v3}, Ljava/io/DataOutputStream;->writeInt(I)V

    .line 112
    invoke-virtual {p1, p0}, Ljava/io/DataOutputStream;->write([B)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/OutOfMemoryError; {:try_start_0 .. :try_end_0} :catch_0

    const/4 p0, 0x1

    return p0

    :cond_1
    :goto_0
    return v2

    :catch_0
    move-exception p0

    .line 117
    invoke-static {v1, v0, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1

    :catch_1
    move-exception p0

    .line 115
    invoke-static {v1, v0, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :goto_1
    return v2
.end method

.method private static serializeParcelable(Landroid/os/Parcelable;)[B
    .locals 5

    const-string v0, "Failed to serialize Parcelable"

    const-string v1, "UnityNotifications"

    .line 182
    :try_start_0
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v2

    .line 183
    new-instance v3, Landroid/os/Bundle;

    invoke-direct {v3}, Landroid/os/Bundle;-><init>()V

    const-string v4, "obj"

    .line 184
    invoke-virtual {v3, v4, p0}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    const/4 p0, 0x0

    .line 185
    invoke-virtual {v2, v3, p0}, Landroid/os/Parcel;->writeParcelable(Landroid/os/Parcelable;I)V

    .line 186
    invoke-virtual {v2}, Landroid/os/Parcel;->marshall()[B

    move-result-object p0

    .line 187
    invoke-virtual {v2}, Landroid/os/Parcel;->recycle()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/OutOfMemoryError; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    move-exception p0

    .line 192
    invoke-static {v1, v0, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    :catch_1
    move-exception p0

    .line 190
    invoke-static {v1, v0, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :goto_0
    const/4 p0, 0x0

    return-object p0
.end method

.method private static serializeString(Ljava/io/DataOutputStream;Ljava/lang/String;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    if-eqz p1, :cond_1

    .line 171
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 174
    :cond_0
    sget-object v0, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {p1, v0}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object p1

    .line 175
    array-length v0, p1

    invoke-virtual {p0, v0}, Ljava/io/DataOutputStream;->writeInt(I)V

    .line 176
    invoke-virtual {p0, p1}, Ljava/io/DataOutputStream;->write([B)V

    goto :goto_1

    :cond_1
    :goto_0
    const/4 p1, 0x0

    .line 172
    invoke-virtual {p0, p1}, Ljava/io/DataOutputStream;->writeInt(I)V

    :goto_1
    return-void
.end method
